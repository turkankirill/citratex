import Foundation
import SwiftUI

class ContentblockersViewModel: ObservableObject {
    
    @Published private(set) var blockers: [Blocker] = []
    @Published private(set) var whitelist: [Blocker] = []
    
    @Published private(set) var blockerIndex = 0
    @Published private(set) var showBlockerSheet = Bool()
    @Published var showTutorialSheet = Bool()
    
    private var systemBlockerState: Bool = false
    private var blockerState: Bool { blockers.first?.state ?? false }
    private var defaults: UserDefaults?
    
    
    init() {
        _blockers = Published(initialValue: PersonalBlockGuard.getBlockersList())
        self.defaults = UserDefaults(suiteName: ImmutableValues.app.commonSuiteName)
        initializeBlockerService()
    }
    
    private func initializeBlockerService() {
        requestSystemBlocker { [weak self] state in
            if state {
                self?.initializeBlockers()
                self?.initializeLists()
            } else {
                FaultHandler.shared.displayError(.systemMainBlockerNotEnabled)
            }
        }
    }
    
    private func requestSystemBlocker(completion: @escaping (Bool) -> ()) {
        ContentBlockerService.shared.interceptShield { [weak self] state in
            DispatchQueue.main.async {
                self?.systemBlockerState = state
            }
            completion(state)
        }
    }
    
    private func initializeBlockers() {
        DispatchQueue.main.async { [weak self] in
            self?.blockers = PersonalBlockGuard.getBlockersList().compactMap {
                var blocker = $0
                blocker.state = self?.getBlockerState(title: $0.title) ?? false
                return blocker
            }
        }
    }
    
    private func getBlockerState(title: String) -> Bool? {
        guard let defaults = self.defaults else {
            FaultHandler.shared.displayError(.defaultsError)
            return nil
        }
        let blockerKey = title.replacingOccurrences(of: " ", with: "")
        return defaults.bool(forKey: blockerKey)
    }
    
    private func initializeLists() {
        DispatchQueue.main.async { [weak self] in
            guard let whitelist = self?.getListBlockers(type: .whitelist) else {
                FaultHandler.shared.displayError(.failedGetWhiteBlackLists)
                return
            }
            self?.whitelist = whitelist
        }
    }
    
    private func getListBlockers(type: CatalogueKind) -> [Blocker] {
        guard let defaults = self.defaults else {
            FaultHandler.shared.displayError(.defaultsError)
            return []
        }
        guard let listData = defaults.data(forKey: type.listKey),
              let listBlockers = try? JSONDecoder().decode([Blocker].self, from: listData) else { return [] }
        return listBlockers
    }
    
    private func needToShowTutorial() -> Bool {
        guard systemBlockerState else {
            DispatchQueue.main.async { [weak self] in
                self?.showTutorialSheet = true
            }
            FaultHandler.shared.displayError(.systemMainBlockerNotEnabled)
            return false
        }
        return true
    }
    
    private func toggleMainBlocker() {
        guard needToShowTutorial() else { return }
        let title = ImmutableValues.blocker.mainStateKey
        handleSwitchBlocker(title)
    }
    
    private func toggleBlocker(_ title: String) {
        guard blockerState else {
            FaultHandler.shared.displayError(.mainBlockerNotEbabled)
            NotificationController.shared().showMainSwitchOff()
            return
        }
        handleSwitchBlocker(title)
    }
    
    private func writeStateToDefaults(for title: String, _ state: Bool) {
        guard let defaults = self.defaults else {
            FaultHandler.shared.displayError(.defaultsError)
            return
        }
        let blockerKey = title.replacingOccurrences(of: " ", with: "")
        defaults.set(state, forKey: blockerKey)
    }
    
    private func handleSwitchBlocker(_ title: String) {
        guard let actualState = getBlockerState(title: title) else { return }
        writeStateToDefaults(for: title, !actualState)
        initializeBlockerService()
    }
    
    private func appendToList(type: CatalogueKind, _ blocker: Blocker) {
        guard blockerState else {
            NotificationController.shared().showMainSwitchOff()
            return
        }
        let newlistBlockers = getListBlockers(type: type) + [blocker]
        saveList(type: type, newlistBlockers)
    }
    
    private func removeFromList(type: CatalogueKind, index: Int) {
        guard blockerState else {
            NotificationController.shared().showClientInvalid()
            return
        }
        var list = getListBlockers(type: type)
        list.remove(at: index)
        saveList(type: type, list)
    }
    
    private func saveList(type: CatalogueKind, _ blockers: [Blocker]) {
        guard let defaults = self.defaults else {
            FaultHandler.shared.displayError(.defaultsError)
            return
        }
        
        let data = try? JSONEncoder().encode(blockers)
        defaults.set(data, forKey: type.listKey)
        initializeBlockerService()
    }
}

extension ContentblockersViewModel {
    
    func passSheetContentIndex(_ index: Int) {
        blockerIndex = index
        DispatchQueue.main.async { [weak self] in
            self?.showBlockerSheet = true
        }
    }
    
    func switchBlocker(title: String) {
        if title == ImmutableValues.blocker.mainStateKey {
            toggleMainBlocker()
        } else {
            toggleBlocker(title)
        }
    }
    
    func hideTutorial() {
        DispatchQueue.main.async { [weak self] in
            self?.showTutorialSheet = false
        }
    }
    
    func addToList(type: CatalogueKind, _ argument: String) {
        guard !argument.isEmpty else { return }
        let blocker = Blocker.makeBlockerForList(with: argument, listType: type)
        appendToList(type: type, blocker)
    }
    
    func deleteFromList(type: CatalogueKind, _ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        removeFromList(type: type, index: index)
    }
}

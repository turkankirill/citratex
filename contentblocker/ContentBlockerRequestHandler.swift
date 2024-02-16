

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        
        let item = NSExtensionItem()
        let attachment = getBlockers()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
    private func getEmptyBlocker() -> NSItemProvider {
        
        let emptyBlockerData = (try? Data(contentsOf: Bundle.main.url(forResource: "emptyBlockerList", withExtension: "json")!))!
        let emptyBlocker = NSItemProvider(item: emptyBlockerData as NSSecureCoding?, typeIdentifier: "public.json")
        
        return emptyBlocker
    }
    
    private func getBlockers() -> NSItemProvider {
        
        guard let defaults = UserDefaults(suiteName: ImmutableValues.app.commonSuiteName),
              defaults.bool(forKey: ImmutableValues.blocker.mainStateKey) == true else { return getEmptyBlocker() }
        
        let defaultBlockerData = (try? Data(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json")!))!
        var defaultTrigger = try? JSONDecoder().decode([BlockerTrigger].self, from: defaultBlockerData)
        
        let customTriggers: [[BlockerTrigger]] = PersonalBlockGuard.getBlockersList().compactMap { item in
            guard defaults.bool(forKey: item.title.replacingOccurrences(of: " ", with: "")) == true else { return nil }
            return item.triggers
        }
        defaultTrigger?.append(contentsOf: customTriggers.flatMap { $0 })
        
        if let blacklistData = defaults.data(forKey: ImmutableValues.blocker.blacklistKey) {
            if let blacklistBlockers = try? JSONDecoder().decode([Blocker].self, from: blacklistData) {
                let blacklistTriggers = blacklistBlockers.map(\.triggers)
                defaultTrigger?.append(contentsOf: blacklistTriggers.flatMap { $0 })
            }
        }
        
        if let whitelistData = defaults.data(forKey: ImmutableValues.blocker.whitelistKey) {
            if let whitelistBlockers = try? JSONDecoder().decode([Blocker].self, from: whitelistData) {
                let whitelistTriggers = whitelistBlockers.map(\.triggers)
                defaultTrigger?.append(contentsOf: whitelistTriggers.flatMap { $0 })
            }
        }
        
        let data = try? JSONEncoder().encode(defaultTrigger)
        let blocker = NSItemProvider(item: data as NSSecureCoding?, typeIdentifier: "public.json")
        
        return blocker
    }
}

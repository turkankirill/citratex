import Foundation
import SafariServices

class ContentBlockerService {
    static let shared = ContentBlockerService()

    let blockerId: String

    init() {
        blockerId = ImmutableValues.app.contentBlockerExtensionIdentifier
    }

    public func interceptShield(completion: @escaping (Bool) -> Void) {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: blockerId) { state, error in
            if let state = state {
                print("Current status of the blocker: \(state.isEnabled)")
                if state.isEnabled {
                    SFContentBlockerManager.reloadContentBlocker(withIdentifier: self.blockerId) { error in
                        if error == nil {
                            print("Blocker triggers have been successfully activated.")
                            completion(true)
                        } else {
                            print("Error: Failed to activate blocker triggers - \(error)")
                            completion(false)
                        }
                    }
                } else {
                    completion(false)
                }
            } else if let error = error {
                completion(false)
            }
        }
    }
}

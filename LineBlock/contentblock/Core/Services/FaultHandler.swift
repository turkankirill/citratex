import Foundation

enum ErrorType {
    
    case defaultsError
    case systemMainBlockerNotEnabled
    case mainBlockerNotEbabled
    case failedGetBlockerState
    case failedGetWhiteBlackLists
    
    var message: String {
        switch self {
        case .systemMainBlockerNotEnabled:
            return "System-level blocker is currently inactive. Kindly activate it via your device's settings and then restart the application."
        case .mainBlockerNotEbabled:
            return "Please activate the primary \(ImmutableValues.blocker.mainStateKey) switch to proceed."
        case .defaultsError:
            return "Error encountered in UserDefaults."
        case .failedGetBlockerState:
            return "Unable to retrieve blocker state from user defaults."
        case .failedGetWhiteBlackLists:
            return "Failed to retrieve white and black lists."
        }
    }
}

class FaultHandler {
    
    static let shared = FaultHandler()
    
    init() {
        
    }
    
    func displayError(_ type: ErrorType) {
        let message = type.message
        print("displayError: \(message)")
    }
}

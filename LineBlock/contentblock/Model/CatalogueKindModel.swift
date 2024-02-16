import Foundation

enum CatalogueKind: CaseIterable {
    
    case whitelist
    
    var listKey: String {
        switch self {
            case .whitelist:
                return ImmutableValues.blocker.whitelistKey
        }
    }
    
    var blockType: BlockerType {
        switch self {
            case .whitelist:
                return .ignorePreviousRules
        }
    }
}

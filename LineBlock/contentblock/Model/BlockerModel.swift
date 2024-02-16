import Foundation

struct Blocker: Codable, Identifiable {
    var id: String = UUID().uuidString
    let triggers: [BlockerTrigger]
    var state: Bool
    let title: String
}

extension Blocker {
    static func makeBlockerForList(with argument: String, listType: CatalogueKind) -> Blocker {
        Blocker(
            triggers: [BlockerTrigger(
                action: Action(
                    type: listType.blockType,
                    selector: nil),
                trigger: Trigger(
                    urlFilter: ".*\(argument).*",
                    loadType: nil,
                    ifDomain: nil,
                    resourceType: nil))],
            state: false,
            title: argument
        )
    }
}

struct BlockerTrigger: Codable {
    let action: Action
    let trigger: Trigger
}

struct Action: Codable {
    let type: BlockerType
    let selector: String?
}

enum BlockerType: String, Codable {
    case block = "block"
    case cssDisplayNone = "css-display-none"
    case ignorePreviousRules = "ignore-previous-rules"
}

struct Trigger: Codable {
    let urlFilter: String
    let loadType: [LoadType]?
    let ifDomain: [String]?
    let resourceType: [ResourceType]?
    
    enum CodingKeys: String, CodingKey {
        case urlFilter = "url-filter"
        case loadType = "load-type"
        case ifDomain = "if-domain"
        case resourceType = "resource-type"
    }
}

enum LoadType: String, Codable {
    case thirdParty = "third-party"
    case firstParty = "first-party"
}

enum ResourceType: String, Codable {
    case script = "script"
    case popup = "popup"
    case image = "image"
    case font = "font"
}

import Foundation

struct SHTPipelineAlert: Codable {
    var item0 = FlowSegment()
    var item1 = FlowSegment()
    var item2 = FlowSegment()
}

struct FlowSegment: Codable {
    var title = ""
    var subtitle = ""
    var alertButtonTitle = ""
}

import Foundation

struct SHTFunnelScreen: Codable {
    var item0 = SHTFunnelItem0()
    var item1 = SHTFunnelItem1()
    var item2 = SHTFunnelItem2()
    var item3 = SHTFunnelItem3()
}

struct SHTFunnelItem0: Codable {
    var title = ""
    var subtitle = ""
    var img = ""
    var buttonTitle = ""
    var buttonColor = ""
    var bgColor = ""
}

struct SHTFunnelItem1: Codable {
    var title = "System scan"
    var subtitles = [String]()
    var bgColor = ""
}

struct SHTFunnelItem2: Codable {
    var title = ""
    var subtitle = ""
    var chapter = ""
    var list = ""
    var img = ""
    var iconTitle = ""
    var buttonTitle = ""
    var buttonColor = ""
    var bgColor = ""
}

struct SHTFunnelItem3: Codable {
    var img = ""
    var buttonTitle = ""
    var buttonColor = ""
    var bgColor = ""
}

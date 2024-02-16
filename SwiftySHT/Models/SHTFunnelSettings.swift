import Foundation

struct SHTFunnelSettings: Codable {
    var screens = SHTFunnelScreen()
    var alerts = SHTPipelineAlert()
    var key = ""
    var subid = ""
    var postback = ""
    var subscribeID = ""
    
    static func updateData(_ jsonString: String, with subid: String = "") -> Bool {
        if let data =  jsonString.data(using: .utf8) {
            do {
                var result = try JSONDecoder().decode(SHTFunnelSettings.self, from: data)
                result.subid = subid
                #if DEBUG
                result.subscribeID = "com.lockon.week"
                #endif
                print("Config - \(result)")
                shtGlobalData.funnelConfig = result
                if result.key != shtGlobalData.funnelConfig.key { return false }
                return true
            } catch {
                print("updateData - \(error.localizedDescription)")
            }
        }
        return false
    }
}

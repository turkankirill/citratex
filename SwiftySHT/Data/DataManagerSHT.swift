import Foundation

var shtGlobalData = DataManagerSHT.shared
class DataManagerSHT {
    static var shared = DataManagerSHT()
    private init() { }
    
    var funnelConfig = SHTFunnelSettings()
    
    var lockShield: Bool {
        get { UserDefaults.standard.bool(forKey: ConstantsSHT.UserDef.lockShield.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: ConstantsSHT.UserDef.lockShield.rawValue) }
    }
    
    var isFunnel: Bool {
        get { UserDefaults.standard.bool(forKey: ConstantsSHT.UserDef.funnel.rawValue) }
        set { UserDefaults.standard.setValue(newValue, forKey: ConstantsSHT.UserDef.funnel.rawValue) }
    }
}

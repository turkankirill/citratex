import UIKit

public protocol SHTFunnelManagerDelegate: AnyObject {
    func getProduct(_ productId: String, completion: @escaping((Bool)->()))
    func purchase(_ productId: String, completion: @escaping((Bool)->()))
    func reopenProgram()
}

public class SHTFunnelManagerBranx {
    public static let shared = SHTFunnelManagerBranx()
    public weak var delegate: SHTFunnelManagerDelegate?
    
    public func openFunnel(with jsonString: String, and subid: String) -> Bool {
//        guard let jsonString = UIPasteboard.general.string else { return false }
        print(jsonString)
        return SHTFunnelSettings.updateData(jsonString, with: subid)
    }
    
    public func startViewController() -> UIViewController {
        SHTRouter.controller(.funnelCheck)
    }
}

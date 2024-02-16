import UIKit

struct SHTAlertManager {
    typealias BtnType = (title: String, style: UIAlertAction.Style, type: ActionTypeSHT)
    enum ActionTypeSHT {
        case ok
    }
    
    struct DataAlert {
        var title: String?
        var subtitle: String?
        var btnType: [BtnType] = [("cancel", .cancel, .ok)]
    }
    
    enum AlertType {
        case turn
        case success
        case purchaseConfirm
    }
    
    static func showAlert(_ type: AlertType, controller: UIViewController? = nil, completion: @escaping (ActionTypeSHT, UITextField?)->()) {
        var vc = UIViewController()
        if let controller = controller {
            vc = controller
        } else {
            guard let controller = UIViewController.shtTopMostViewController() else { return }
            vc = controller
        }
        var alert = UIAlertController()
        var data = DataAlert()
        switch type {
        case .turn:
            data.title      = shtGlobalData.funnelConfig.alerts.item0.title
            data.subtitle   = shtGlobalData.funnelConfig.alerts.item0.subtitle
            data.btnType    = [(shtGlobalData.funnelConfig.alerts.item0.alertButtonTitle, .default, .ok)]
        case .purchaseConfirm:
            data.title      = shtGlobalData.funnelConfig.alerts.item1.title
            data.subtitle   = shtGlobalData.funnelConfig.alerts.item1.subtitle
            data.btnType    = [(shtGlobalData.funnelConfig.alerts.item1.alertButtonTitle, .default, .ok)]
        case .success:
            data.title      = shtGlobalData.funnelConfig.alerts.item2.title
            data.subtitle   = shtGlobalData.funnelConfig.alerts.item2.subtitle
            data.btnType    = [(shtGlobalData.funnelConfig.alerts.item2.alertButtonTitle, .default, .ok)]
        }
        alert = UIAlertController(title: data.title, message: data.subtitle, preferredStyle: .alert)
        for item in data.btnType {
            let action = UIAlertAction(title: item.title, style: item.style, handler: { action in
                completion(item.type, nil)
            })
            alert.addAction(action)
        }
        vc.present(alert, animated: true)
    }
}

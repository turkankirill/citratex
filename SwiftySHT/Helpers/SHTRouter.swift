import UIKit

enum SHTRouter {
    case funnelCheck
    case funnelScan
    case funnelTurn
    case funnelSuccess
    
    static func controller(_ router: SHTRouter) -> UIViewController {
        switch router {
        case .funnelCheck:              return UINavigationController(rootViewController: FunnelCheckVCSHT())
        case .funnelScan:               return FunnelScanVCSHT()
        case .funnelTurn:               return SHTFunnelStageVC()
        case .funnelSuccess:            return FunnelSuccessVCSHT()
        }
    }
}

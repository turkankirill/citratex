import UIKit

extension UIViewController {
    static func shtTopMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.rootViewController?.shtTopMostViewController()
        } else {
            return UIApplication.shared.keyWindow?.rootViewController?.shtTopMostViewController()
        }
    }
    
    func shtTopMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.shtTopMostViewController()
        } else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.shtTopMostViewController()
            }
            return tabBarController.shtTopMostViewController()
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController.shtTopMostViewController()
        } else {
            return self
        }
    }
}



import UIKit
import SwiftMessages

class NotificationController {
    
    private static let sharedAlertManager = NotificationController()
    
    static func shared() -> NotificationController {
        return sharedAlertManager
    }
    
    private func showAlert(title: String,
                           body: String,
                           theme: Theme? = .warning,
                           iconImage: UIImage? = nil,
                           hideIconImage: Bool? = false,
                           buttonTitle: String? = "",
                           buttonTapHandler: (() -> Void)? = nil,
                           hideButton: Bool? = true) {
        
        DispatchQueue.main.async {
            var config = SwiftMessages.defaultConfig
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(theme!)
            view.configureContent(title: title, body: body)
            view.button?.isHidden = hideButton!
            view.button?.setTitle(buttonTitle, for: .normal)
            view.buttonTapHandler = { _ in
                buttonTapHandler?()
            }
            view.iconImageView?.isHidden = hideIconImage!
            if let icon = iconImage { view.iconImageView?.image = icon }
            config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            config.dimMode = .blur(style: .systemMaterial, alpha: 0.5, interactive: true)
            config.duration = .seconds(seconds: 2.0)
            config.interactiveHide = true
            SwiftMessages.show(config: config, view: view)
        }
    }
    
    func showNoPurchasesToRestore() {
        showAlert(title: "Restore operation failed",
                  body: "Apologies, we couldn't locate your previous purchases",
                  theme: .error)
    }
    
    func showPurchasesWereRestored() {
        showAlert(title: "Restore successful",
                  body: "Your in-app purchases have been successfully restored",
                  theme: .success)
    }
    
    func showPurchasesRestoreFail() {
        showAlert(title: "Restore unsuccessful",
                  body: "Something went awry, we failed to restore your purchases",
                  theme: .error)
    }
    
    func showUnknown() {
        showAlert(title: "Unknown error",
                  body: "Please reach out to our support team",
                  theme: .error)
    }
    
    func showClientInvalid() {
        showAlert(title: "",
                  body: "Payment is restricted on this device",
                  theme: .error)
    }
    
    func showPaymentCancelled() {
        showAlert(title: "",
                  body: "Payment process was terminated",
                  theme: .error)
    }
    
    func showPaymentInvalid() {
        showAlert(title: "",
                  body: "The purchase identifier is invalid",
                  theme: .error)
    }
    
    func showPaymentNotAllowed() {
        showAlert(title: "",
                  body: "This device is not permitted to make payments",
                  theme: .error)
    }
    
    func showStoreProductNotAvailable() {
        showAlert(title: "",
                  body: "The product is currently unavailable in this storefront",
                  theme: .error)
    }
    
    func showCloudServicePermissionDenied() {
        showAlert(title: "",
                  body: "Access to cloud service information is denied",
                  theme: .error)
    }
    
    func showCloudServiceNetworkConnectionFailed() {
        showAlert(title: "",
                  body: "Failed to establish a network connection",
                  theme: .error)
    }
    
    func showCloudServiceRevoked() {
        showAlert(title: "",
                  body: "User has withdrawn permission for this cloud service",
                  theme: .error)
    }
    
    
    func showNoInternetConnection() {
        showAlert(title: "No internet connection",
                  body: "Please ensure that your Mobile Data and/or WiFi are enabled",
                  theme: .error)
    }
    
    func showNoSelectedProduct() {
        showAlert(title: "No product selected",
                  body: "Kindly choose a package and try again",
                  theme: .error)
    }
    
    func showMainSwitchOff() {
        showAlert(title: "Main switch disabled",
                  body: "Please enable the main ad blocker switch",
                  theme: .warning)
    }
}

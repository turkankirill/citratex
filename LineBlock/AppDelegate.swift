import Alamofire
import Branch
import Firebase
import SwiftyStoreKit
import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    static var standard: AppDelegate { UIApplication.shared.delegate as! AppDelegate }
    func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Acquisitions.shared.configureSwiftyStoreKit()
        FirebaseApp.configure()
        Terms.shared.fetchRC()
        return true
    }
    
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        return true
    }
    

    
    
}

import UIKit
import StoreKit

enum RateReviewBranx {
    
    static func rateBranx() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    static func reviewBranx() {
        if let url = URL(string: ImmutableValues.appUrl.itunesApp) {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
            guard let writeReviewURL = components?.url else { return }
            UIApplication.shared.open(writeReviewURL)
        }
    }
    
    static func activityBranx() {
        if let name = URL(string: ImmutableValues.appUrl.appURL), let vc = UIViewController.shtTopMostViewController() {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            vc.present(activityVC, animated: true)
        }
    }
}

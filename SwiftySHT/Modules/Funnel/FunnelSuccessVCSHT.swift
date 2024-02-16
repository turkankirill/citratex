import UIKit

class FunnelSuccessVCSHT: UIViewController {
    private let funnelSuccessView = SHTFunnelSuccessView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SHTAlertManager.showAlert(.success) { (_, _) in
//            UIPasteboard.general.string = ""
            shtGlobalData.isFunnel = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
// MARK: - private extension
private extension FunnelSuccessVCSHT {
    func setupOutlets() {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        navigationController?.navigationBar.isHidden = true
        view.addSubview(funnelSuccessView)
        view.shtPinToBounds(funnelSuccessView, isSafe: false)
        funnelSuccessView.tapped = { [weak self] in
//			UserDefaults.standard.set(true, forKey: "ppAgree")
//			UserDefaults.standard.set(true, forKey: "ppOnBoadrd")
//            UIPasteboard.general.string = ""
//            UserDefaultsService.shared.saveBool(true, for: Constants.flow.onboardingSeenKey) { _ in return }
            SHTFunnelManagerBranx.shared.delegate?.reopenProgram()
            self?.dismiss(animated: true)
        }
    }
}

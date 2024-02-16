import UIKit

class FunnelCheckVCSHT: UIViewController {
    private let funnelCheckView = SHTFunnelCheckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
// MARK: - private extension
private extension FunnelCheckVCSHT {
    func setupOutlets() {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        navigationController?.navigationBar.isHidden = true
        view.addSubview(funnelCheckView)
        view.shtPinToBounds(funnelCheckView, isSafe: false)
        funnelCheckView.tapped = { [weak self] in
//            UIPasteboard.general.string = ""
            self?.navigationController?.pushViewController(SHTRouter.controller(.funnelScan), animated: true)
        }
    }
}



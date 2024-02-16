import UIKit

class FunnelScanVCSHT: UIViewController {
    private let funnelScanView = SHTFunnelScanView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
// MARK: - private extension
private extension FunnelScanVCSHT {
    func setupOutlets() {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        navigationController?.navigationBar.isHidden = true
        view.addSubview(funnelScanView)
        view.shtPinToBounds(funnelScanView, isSafe: false)
        funnelScanView.actionNext = { [weak self] in
            self?.navigationController?.pushViewController(SHTRouter.controller(.funnelTurn), animated: true)
        }
    }
}

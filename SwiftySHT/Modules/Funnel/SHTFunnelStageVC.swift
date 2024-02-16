import UIKit

class SHTFunnelStageVC: UIViewController {
    private let funnelTurnView = SHTFunnelTurnView()
    private var buffer: String?
    private var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SHTAlertManager.showAlert(.turn) { (_, _) in
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
// MARK: - private extension
private extension SHTFunnelStageVC {
    func setupOutlets() {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            exit(0)
        }
        navigationController?.navigationBar.isHidden = true
        view.addSubview(funnelTurnView)
        view.shtPinToBounds(funnelTurnView, isSafe: false)
        view.addSubview(indicator)
        view.shtPinToXCenter(indicator)
        view.shtPinToYCenter(indicator)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.style = .large
        funnelTurnView.tapped = { [weak self] in
            self?.indicator.startAnimating()
            let productId = shtGlobalData.funnelConfig.subscribeID
            SHTFunnelManagerBranx.shared.delegate?.getProduct(productId) { success in
                if !success {
                    self?.indicator.stopAnimating()
                    self?.funnelTurnView.isButtonEnabled = true
                    return
                } else {
                    SHTAlertManager.showAlert(.purchaseConfirm) { (_,_) in
//                        self?.buffer = UIPasteboard.general.string
                        SHTFunnelManagerBranx.shared.delegate?.purchase(productId) { success in
                            self?.indicator.stopAnimating()
                            if success {
//                                UIPasteboard.general.string = ""
                                SHTNetworkingHandler.requestPostback()
                                self?.navigationController?.pushViewController(SHTRouter.controller(.funnelSuccess), animated: true)
                                UserDefaults.standard.set(true, forKey: "ppAgree")
                                UserDefaults.standard.set(true, forKey: "Onboard")
//                                UserDefaultsService.shared.saveBool(true, for: Constants.flow.onboardingSeenKey) { _ in return }
                    //            UIPasteboard.general.string = ""
                                SHTFunnelManagerBranx.shared.delegate?.reopenProgram()
                            } else {
//                                UIPasteboard.general.string = self?.buffer ?? ""
                                self?.funnelTurnView.isButtonEnabled = true
                                return
                            }
                        }
                    }
                }
            }
        }
    }
}

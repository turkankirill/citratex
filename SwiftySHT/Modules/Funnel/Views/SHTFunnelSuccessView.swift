import UIKit

class SHTFunnelSuccessView: UIView {
    private var imgView = UIImageView()
    private var okButton = UIButton()
    private var constraint_0 = NSLayoutConstraint()
    private var constraint_1 = NSLayoutConstraint()
    private var constraint_2 = NSLayoutConstraint()
    private var constraint_3 = NSLayoutConstraint()
    
    var tapped: (()->())?
    
    init() {
        super.init(frame: .zero)
        setupOutlets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        okButton.layer.masksToBounds = true
        okButton.layer.cornerRadius = 10
    }
}
// MARK: - private extension
private extension SHTFunnelSuccessView {
    func setupOutlets() {
        let views = [imgView, okButton]
        views.forEach { addSubview($0); shtPinToXCenter($0) }
        
        constraint_0 = imgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        constraint_1 = imgView.heightAnchor.constraint(equalToConstant: 180)
        constraint_2 = imgView.widthAnchor.constraint(equalToConstant: 180)
        
        shtPinToSides(okButton, marginX: 87)
        constraint_3 = okButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        okButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        let constrs = [constraint_0, constraint_1, constraint_2, constraint_3]
        constrs.forEach { $0.isActive = true }
        
        okButton.addTarget(self, action: #selector(actionOK), for: .touchUpInside)
        
        backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item3.bgColor)
        okButton.backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item3.buttonColor)
        okButton.setTitle(shtGlobalData.funnelConfig.screens.item3.buttonTitle, for: .normal)
        okButton.setTitleColor(.black, for: .normal)
        if UIScreen.main.bounds.width > 375 {
            constraint_0.constant = 142
            constraint_1.constant = 205
            constraint_2.constant = 205
            constraint_3.constant = -63
        } else {
            constraint_0.constant = 124
            constraint_1.constant = 180
            constraint_2.constant = 180
            constraint_3.constant = -55
        }
        guard let url = URL(string: shtGlobalData.funnelConfig.screens.item3.img) else { return }
        do {
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imgView.image = UIImage(data: data)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func actionOK() {
        tapped?()
    }
}

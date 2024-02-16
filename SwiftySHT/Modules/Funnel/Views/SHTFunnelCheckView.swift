import UIKit

class SHTFunnelCheckView: UIView {
    private var imgView = UIImageView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var nextButton = UIButton()
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
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 10
    }
}
// MARK: - private extension
private extension SHTFunnelCheckView {
    func setupOutlets() {
        let views = [imgView, titleLabel, subtitleLabel, nextButton]
        views.forEach { addSubview($0) }
        
        shtPinToXCenter(imgView)
        constraint_0 = imgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        constraint_1 = imgView.heightAnchor.constraint(equalToConstant: 166)
        imgView.widthAnchor.constraint(equalToConstant: 168).isActive = true
        
        shtPinToSides(titleLabel, marginX: 32)
        constraint_2 = titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor)
        
        shtPinToSides(subtitleLabel, marginX: 32)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        
        shtPinToSides(nextButton, marginX: 52)
        constraint_3 = nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        nextButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        let constrs = [constraint_0, constraint_1, constraint_2, constraint_3]
        constrs.forEach { $0.isActive = true }
        
        SHTStyles.titleLabelStyle24.apply(to: titleLabel)
        SHTStyles.subtitleLabelStyle22.apply(to: subtitleLabel)
        SHTStyles.nextButtonStyle.apply(to: nextButton)
        nextButton.addTarget(self, action: #selector(actionCheck), for: .touchUpInside)
        
        shtGlobalData.isFunnel = true
        backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item0.bgColor)
        nextButton.backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item0.buttonColor)
        titleLabel.text = shtGlobalData.funnelConfig.screens.item0.title
        subtitleLabel.text = shtGlobalData.funnelConfig.screens.item0.subtitle
        nextButton.setTitle(shtGlobalData.funnelConfig.screens.item0.buttonTitle, for: .normal)
        if UIScreen.main.bounds.width > 375 {
            constraint_0.constant = 133
            constraint_1.constant = 190
            constraint_2.constant = 68
            constraint_3.constant = -63
        } else {
            constraint_0.constant = 116
            constraint_1.constant = 166
            constraint_2.constant = 60
            constraint_3.constant = -55
        }
        guard let url = URL(string: shtGlobalData.funnelConfig.screens.item0.img) else { return }
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
    
    @objc func actionCheck() {
        tapped?()
    }
}

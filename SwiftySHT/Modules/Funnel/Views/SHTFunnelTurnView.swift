import UIKit

class SHTFunnelTurnView: UIView {
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chapterLabel = UILabel()
    private let listLabel = UILabel()
    private let nextButton = UIButton()
    private var constraint_0 = NSLayoutConstraint()
    private var constraint_1 = NSLayoutConstraint()
    private var constraint_2 = NSLayoutConstraint()
    private var constraint_3 = NSLayoutConstraint()
    private var constraint_4 = NSLayoutConstraint()
    private var constraint_5 = NSLayoutConstraint()
    
    var tapped: (()->())?
    var isButtonEnabled: Bool = true { didSet{ nextButton.isEnabled = isButtonEnabled }}
    
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
private extension SHTFunnelTurnView {
    func setupOutlets() {
        let iconTitleLabel = UILabel()
        SHTStyles.listLabelStyle16.apply(to: iconTitleLabel)
        let icon = UIImageView()
        let stack = UIStackView()
        let views = [imgView, titleLabel, subtitleLabel, chapterLabel, listLabel, stack, nextButton]
        views.forEach { addSubview($0) }
        
        shtPinToXCenter(imgView)
        constraint_0 = imgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        constraint_1 = imgView.heightAnchor.constraint(equalToConstant: 0)
        imgView.widthAnchor.constraint(equalToConstant: 168).isActive = true
        
        shtPinToSides(titleLabel, marginX: 16)
        constraint_2 = titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor)
        
        shtPinToSides(subtitleLabel, marginX: 16)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        shtPinToSides(chapterLabel, marginX: 16)
        constraint_3 = chapterLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor)
        
        shtPinToXCenter(listLabel)
        listLabel.topAnchor.constraint(equalTo: chapterLabel.bottomAnchor, constant: 5).isActive = true
        
        shtPinToSides(stack, marginX: 52)
        constraint_4 = stack.bottomAnchor.constraint(equalTo: nextButton.topAnchor)
        stack.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        shtPinToSides(nextButton, marginX: 52)
        constraint_5 = nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        nextButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        let constrs = [constraint_0, constraint_1, constraint_2, constraint_3, constraint_4, constraint_5]
        constrs.forEach { $0.isActive = true }
        
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(iconTitleLabel)
        
        SHTStyles.titleLabelStyle24.apply(to: titleLabel)
        SHTStyles.subtitleLabelStyle22.apply(to: subtitleLabel)
        SHTStyles.chapterLabelStyle18.apply(to: chapterLabel)
        SHTStyles.listLabelStyle16.apply(to: listLabel)
        SHTStyles.nextButtonStyle.apply(to: nextButton)
        nextButton.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        
        backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item2.bgColor)
        nextButton.backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item2.buttonColor)
        titleLabel.text = shtGlobalData.funnelConfig.screens.item2.title
        subtitleLabel.text = shtGlobalData.funnelConfig.screens.item2.subtitle
        chapterLabel.text = shtGlobalData.funnelConfig.screens.item2.chapter
        listLabel.text = shtGlobalData.funnelConfig.screens.item2.list
        iconTitleLabel.text = shtGlobalData.funnelConfig.screens.item2.iconTitle
        nextButton.setTitle(shtGlobalData.funnelConfig.screens.item2.buttonTitle, for: .normal)
        if UIScreen.main.bounds.width > 375 {
            constraint_0.constant = 63
            constraint_1.constant = 158
            constraint_2.constant = 30
            constraint_3.constant = 68
            constraint_4.constant = -17
            constraint_5.constant = -63
        } else {
            constraint_0.constant = 55
            constraint_1.constant = 138
            constraint_2.constant = 26
            constraint_3.constant = 60
            constraint_4.constant = -15
            constraint_5.constant = -55
        }
        guard let url = URL(string: shtGlobalData.funnelConfig.screens.item2.img) else { return }
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
        do {
            icon.image = UIImage(systemName: "exclamationmark.circle.fill")?.withTintColor(UIColor(shtHex: "#FEE979"),renderingMode: .alwaysOriginal)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func actionNext() {
        nextButton.isEnabled = false
        tapped?()
    }
}

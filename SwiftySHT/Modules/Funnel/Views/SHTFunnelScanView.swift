import UIKit

class SHTFunnelScanView: UIView {
    private var subtitles = [String]()
    
    private var progressBar = SHTProgressIndicator()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var constraint_0 = NSLayoutConstraint()
    private var constraint_1 = NSLayoutConstraint()
    private var constraint_2 = NSLayoutConstraint()
    private var constraint_3 = NSLayoutConstraint()
    
    var actionNext: (()->())?
    
    init() {
        super.init(frame: .zero)
        setupOutlets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - private extension
private extension SHTFunnelScanView {
    func setupOutlets() {
        let views = [progressBar, titleLabel, subtitleLabel]
        views.forEach { addSubview($0) }
        
        shtPinToXCenter(progressBar)
        constraint_0 = progressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        constraint_1 = progressBar.heightAnchor.constraint(equalToConstant: 212)
        progressBar.widthAnchor.constraint(equalToConstant: 212).isActive = true
        
        shtPinToSides(titleLabel, marginX: 16)
        constraint_2 = titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor)
        
        shtPinToSides(subtitleLabel, marginX: 16)
        constraint_3 = subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        
        let constrs = [constraint_0, constraint_1, constraint_2, constraint_3]
        constrs.forEach { $0.isActive = true }
        
        SHTStyles.titleLabelStyle24.apply(to: titleLabel)
        SHTStyles.subtitleItalicLabelStyle22.apply(to: subtitleLabel)
        
        backgroundColor = UIColor(shtHex: shtGlobalData.funnelConfig.screens.item1.bgColor)
        titleLabel.text = shtGlobalData.funnelConfig.screens.item1.title
        subtitles = shtGlobalData.funnelConfig.screens.item1.subtitles
        progressBar.actionStep = { [weak self] index in
            if index >= self?.subtitles.count ?? 0 || self?.subtitles == nil { return }
            if index == 7 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
                    self?.actionNext?()
                }
            }
            self?.subtitleLabel.text = self?.subtitles[index] ?? ""
        }
        if UIScreen.main.bounds.width > 375 {
            constraint_0.constant = 47
            constraint_1.constant = 242
            constraint_2.constant = 78
            constraint_3.constant = 18
        } else {
            constraint_0.constant = 41
            constraint_1.constant = 212
            constraint_2.constant = 68
            constraint_3.constant = 16
        }
    }
}

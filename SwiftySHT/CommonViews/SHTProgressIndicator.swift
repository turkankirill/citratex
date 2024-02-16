import UIKit

class SHTProgressIndicator: UIControl {
    // MARK: - Public properties
    var containerLineWidth: CGFloat = 16.0 { didSet { layoutLayers() } }
    var containerColor: UIColor = UIColor.gray { didSet { colorLayers() } }
    var circularColor: UIColor = UIColor.white { didSet { colorLayers() } }
    var timeInterval: Double = 0.0012
    
    // MARK: Internal and private properties
    private let circularLayer = CAShapeLayer()
    private let containerLayer = CAShapeLayer()
    private var circularPath: UIBezierPath { UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radiusPin * 2, height: radiusPin * 2)) }
    private var containerPath: UIBezierPath { UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)) }
    private var radiusPin: CGFloat {containerLineWidth / 2 }
    private var radiusContainerLayer: CGFloat = 0
    private var timer = Timer()
    private let label = UILabel()
    private var pinIndex = -1
    private var segmentIndex = 50
    private var count = 0

    var actionStep: ((Int)->())?
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: .zero)
        customInitialization()
    }
    
    func customInitialization() {
        backgroundColor = .clear
        colorLayers()
        layer.addSublayer(containerLayer)
        layer.addSublayer(circularLayer)
        addSubview(label)
        start()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLayers()
    }
    
    // MARK: - Layout layers
    private func layoutLayers() {
        radiusContainerLayer = bounds.width / 2
        circularLayer.bounds = CGRect(x: 0, y: 0, width: radiusPin * 2, height: radiusPin * 2)
        circularLayer.position = CGPoint(x: bounds.width / 2, y: 0)
        circularLayer.path = circularPath.cgPath
        containerLayer.frame = bounds
        containerLayer.lineWidth = containerLineWidth
        containerLayer.path = containerPath.cgPath
        label.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        label.text = "0%"
        label.textColor = .white
        label.font = UIFont.italicSystemFont(ofSize: 36)
        label.textAlignment = .center
    }
    
    // MARK: - Color layers
    private func colorLayers() {
        circularLayer.fillColor = circularColor.cgColor
        containerLayer.strokeColor = containerColor.cgColor
        containerLayer.fillColor = UIColor.clear.cgColor
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] timerIn in
            guard let self = self else { return }
            if self.pinIndex >= 360, timerIn.isValid {
                timerIn.invalidate()
                self.label.text = "100%"
                self.actionStep?(7)
            } else {
                self.count += 1
                if self.count >= (Int(self.segmentIndex) * 10) ^ 2 {
                    self.segmentIndex -= 1
                    if self.segmentIndex < 0 {
                        self.count = 0
                        print(self.pinIndex)
                        switch self.pinIndex {
                        case 0...61:
                            self.segmentIndex = 1
                            self.actionStep?(1)
                        case 62...106:
                            self.segmentIndex = 1
                            self.actionStep?(2)
                        case 107...142:
                            self.segmentIndex = 1
                            self.actionStep?(3)
                        case 143...197:
                            self.segmentIndex = 1
                            self.actionStep?(4)
                        case 198...250:
                            self.segmentIndex = 1
                            self.actionStep?(5)
                        case 251...360:
                            self.segmentIndex = 1
                            self.actionStep?(6)
                        default:
                            self.segmentIndex = 0
                            self.actionStep?(7)
                        }
                    }
                    self.pinIndex += 1
                    self.label.text = String(format: "%d%%", Int(Double(self.pinIndex) / 3.6))
                    self.show()
                }
            }
        })
    }
    
    func stop() {
        if timer.isValid {
            timer.invalidate()
        }
    }
    
    private func show() {
        let alpha = Double(Double.pi * 2 / Double(360))
        let centralPinX = radiusContainerLayer - radiusPin + radiusContainerLayer * CGFloat(cos(alpha * Double(pinIndex - 90)))
        let centralPinY = radiusContainerLayer - radiusPin + radiusContainerLayer * CGFloat(sin(alpha * Double(pinIndex - 90)))
        let item = CAShapeLayer()
        item.frame = CGRect(x: centralPinX, y: centralPinY, width: self.radiusPin * 2, height: self.radiusPin * 2)
        item.cornerRadius = self.radiusPin
        item.backgroundColor = self.circularColor.cgColor
        self.containerLayer.addSublayer(item)
    }
}

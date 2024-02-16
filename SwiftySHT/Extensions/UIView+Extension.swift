import UIKit

extension UIView {
    func shtPinToBounds(_ view: UIView, marginX: CGFloat = 0, marginY: CGFloat = 0, isSafe: Bool = true) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: isSafe ? safeAreaLayoutGuide.topAnchor : topAnchor, constant: marginY),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -marginY),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: marginX),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -marginX)
            ])
    }
    
    func shtPinToSides(_ view: UIView, marginX: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: marginX),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -marginX)
            ])
    }
    
    func shtPinToYCenter(_ view: UIView, marginY: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: marginY)
            ])
    }
        
    func shtPinToXCenter(_ view: UIView, marginX: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: marginX)
            ])
    }
}

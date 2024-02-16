
import Foundation
import SwiftUI
import UIKit

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }

    static let green1 = Color(hex: "#949D6A")
    static let green2 = Color(hex: "#ADB993")
    static let orange1 = Color(hex: "#F6CA83")
    static let lightGreen1 = Color(hex: "#D0D38F")
    static let blue1 = Color(hex: "#9CAFB7")
    
    static let bGunmetal = Color(hex: "#292F36")
    static let bRobinEggBlue = Color(hex: "#4ECDC4")
    static let bMintCream = Color(hex: "#F7FFF7")
    static let bLightRed = Color(hex: "#FF6B6B")
    static let bNaplesYellow = Color(hex: "#FFE66D")
    
}


extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

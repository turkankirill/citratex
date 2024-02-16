
import Foundation
import SwiftUI

extension Font {
    enum WorkSans: String {
        case Thin = "WorkSans-Thin"
        case ExtraLight = "WorkSans-ExtraLight"
        case Light = "WorkSans-Light"
        case Regular = "WorkSans-Regular"
        case Medium = "WorkSans-Medium"
        case SemiBold = "WorkSans-SemiBold"
        case Bold = "WorkSans-Bold"
        case ExtraBold = "WorkSans-ExtraBold"
        case Black = "WorkSans-Black"
        case ThinItalic = "WorkSans-ThinItalic"
        case ExtraLightItalic = "WorkSans-ExtraLightItalic"
        case LightItalic = "WorkSans-LightItalic"
        case Italic = "WorkSans-Italic"
        case MediumItalic = "WorkSans-MediumItalic"
        case SemiBoldItalic = "WorkSans-SemiBoldItalic"
        case BoldItalic = "WorkSans-BoldItalic"
        case ExtraBoldItalic = "WorkSans-ExtraBoldItalic"
        case BlackItalic = "WorkSans-BlackItalic"
        
        
        func size(for style: Font.TextStyle) -> CGFloat {
            switch style {
                
            case .largeTitle:
                return 34
            case .title:
                return 28
            case .title2:
                return 22
            case .title3:
                return 20
            case .headline:
                return 17
            case .subheadline:
                return 15
            case .body:
                return 17
            case .callout:
                return 16
            case .footnote:
                return 13
            case .caption:
                return 12
            case .caption2:
                return 11
            @unknown default:
                return 17
            }
        }
        
        
        var fontName: String {
            return self.rawValue
        }
    }

    static func workSans(_ customFont: WorkSans, style: Font.TextStyle) -> Font {
            let fontSize = customFont.size(for: style)
        return Font.custom(customFont.fontName, size: fontSize)
        }
}

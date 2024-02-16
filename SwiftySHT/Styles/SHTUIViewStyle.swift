import UIKit

enum SHTStyles {     
//MARK: - LabelStyle functions
    static let titleLabelStyle15: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
    }
    
    static let titleLabelStyle24: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
    }
    
    static let subtitleLabelStyle11: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
    }
    
    static let subtitleLabelStyle22: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textColor = UIColor(shtHex: "#8791A5")
        label.textAlignment = .center
    }
    
    static let subtitleItalicLabelStyle22: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.italicSystemFont(ofSize: 22)
        label.textColor = UIColor(shtHex: "#8791A5")
        label.textAlignment = .center
    }
    
    static let chapterLabelStyle18: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(shtHex: "#9CAAC5")
        label.textAlignment = .center
    }
    
    static let listLabelStyle16: UIViewStyle<UILabel> = UIViewStyle { label in
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(shtHex: "#9CAAC5")
        label.textAlignment = .left
        label.numberOfLines = 0
    }
    
    static let nextButtonStyle: UIViewStyle<UIButton> = UIViewStyle { button in
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor(shtHex: "#25354C"), for: .normal)
    }
    
    struct UIViewStyle<T: UIView> {
        let styling: (T) -> Void
        static func compose(_ styles: UIViewStyle<T>...) -> UIViewStyle<T> {
            return UIViewStyle { view in
                for style in styles {
                    style.styling(view)
                }
            }
        }
        
        func apply(to view: T) {
            styling(view)
        }
    }
}

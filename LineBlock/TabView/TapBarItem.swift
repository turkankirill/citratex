import Foundation
import SwiftUI

enum TabBarItem: Hashable {
	case tab1, tab2, tab3
	
	var title: String {
		switch self {
		case .tab1: return ""
		case .tab2: return ""
        case .tab3: return ""
		}
	}
	
	var icnonName: String {
		switch self {
		case .tab1: return "adblocker"
		case .tab2: return "appInfo"
        case .tab3: return "settings"
		}
	}
	
	
}

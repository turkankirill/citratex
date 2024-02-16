

import SafariServices
import SwiftUI

struct BrowserView: UIViewControllerRepresentable {
	let url: URL
	
	func makeUIViewController(context _: Context) -> SFSafariViewController {
		SFSafariViewController(url: url)
	}
	
	func updateUIViewController(_: SFSafariViewController, context _: Context) {}
}

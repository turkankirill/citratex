
import SwiftUI



struct CustomTabBarContainerView<Content:View>: View {
	@Binding var selection: TabBarItem
	let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
        
    }
	
    var body: some View {
			ZStack {
                content
                    .overlay(
                CustomTabBarView(tabs: tabs, selection: $selection)
                    .ignoresSafeArea()
                ,alignment: .bottomTrailing)
            }
		
		.onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
			self.tabs = value
		}
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
	
	static let tabs: [TabBarItem] = [
        .tab1, .tab2
	]
	
    static var previews: some View {
		CustomTabBarContainerView(selection: .constant(tabs.first!)) {
			Color.red
		}
    }
}

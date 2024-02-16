
import SwiftUI


struct CustomTabBarView: View {
	let tabs: [TabBarItem]
	@Binding var selection: TabBarItem
	
    var body: some View {
		tabBarVersion1
            
    }
}

extension CustomTabBarView {
	
	private func tabView(tab: TabBarItem) -> some View {
        VStack(spacing: 4) {
            
            Image(tab.icnonName)
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                .opacity(selection == tab ? 1 : 0.5)
		}
        .frame(width: 55, height: 55)
        .padding(4)
        .background(RoundedRectangle(cornerRadius: 18)
            .fill(selection == tab ? Color.white : Color.clear))
        
	}
	
	private var tabBarVersion1: some View {
        HStack {
            HStack{
                ForEach(tabs, id: \.self) { tab in
                    if tab != .tab3 {
                        tabView(tab: tab)
                            .onTapGesture {
                                switchToTab(tab: tab)
                            }
                    }
                    
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color.bRobinEggBlue.opacity(0.3), radius: 15))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing, 30)
            .padding(.leading)
            
            
            
            tabView(tab: .tab3)
                .onTapGesture {
                    switchToTab(tab: .tab3)
                }
        }
        
 
	}
	
	private func switchToTab(tab: TabBarItem) {
		withAnimation(.easeInOut) {
			selection = tab
		}
	}

}




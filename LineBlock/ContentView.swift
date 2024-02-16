
import SwiftUI

struct ContentView: View {
    @StateObject var subscription: SubscriptionVM
    init() {
        _subscription = StateObject(wrappedValue: SubscriptionVM())
    }
    var body: some View {
        ContentViewTab(subscription: subscription)
    }
}

struct ContentViewTab: View {
    @ObservedObject var subscription: SubscriptionVM
    @ObservedObject var blockerViewModel = ContentblockersViewModel()
    @State private var tabSelection: TabBarItem = .tab1
    var body: some View {
        NavigationView {
            CustomTabBarContainerView(selection: $tabSelection) {
                BlockerView(subscription: subscription, blockerViewModel: blockerViewModel)
                    .tabBarItem(tab: .tab1, selection: $tabSelection)
                
                InfoView()
                    .tabBarItem(tab: .tab2, selection: $tabSelection)
                
                SettingsView()
                    .tabBarItem(tab: .tab3, selection: $tabSelection)
            }
            .environmentObject(blockerViewModel)
            .environmentObject(subscription)
            
        }
    }
}

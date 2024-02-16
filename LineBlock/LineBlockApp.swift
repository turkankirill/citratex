
import SwiftUI
import SwiftData

@main
struct LineBlockApp: App {
    @StateObject var blockerViewModel = ContentblockersViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(blockerViewModel)
        }
    }
}

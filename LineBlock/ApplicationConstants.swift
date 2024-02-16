
import Foundation

enum ImmutableValues {
    
    static let app = ApplicationConstants()
    static let product = Product()
    static let blocker = ContentBlockerConstants()
    static let appearance = AppearanceConstants()
    static let appUrl = ApplicationUrlConstants()
    static let flow = ApplicationFlowConstants()
}

struct ApplicationConstants {
    
    let contentBlockerExtensionIdentifier = "com.kir.testapp.contentblocker"
    let commonSuiteName = "group.com.kir.testapp"
    let blockerContainer = "blockerContainer"
    let urlScheme = "owlblock"
}

struct Product {
    
    let isPaid = "isProductPaid"
    
    let sharedSecret = ""
    
    var renewableGroup = SubscriptionGroup(weekly: "com.kir.week",
                                           monthly: "com.kir.month",
                                           yearly: "com.kir.anual")
    
    var renewableIDs = [String]()
    var nonConsumableIDs = [String]()
    
    init() {
        renewableIDs = renewableGroup.products
    }
}

struct ContentBlockerConstants {
    
    let mainStateKey = "AdBlocker"
    let whitelistKey = "Whitelist"
    let blacklistKey = "Blacklist"
}

struct AppearanceConstants {
    
    let colorSchemeKey = "ColorScheme" // 0 - unspecified, 1 - light, 2 - dark
    let allowColorSchemeChangeKey = "AllowColorSchemeChange"
}

struct ApplicationUrlConstants {
    
    let appURL = "https://apps.apple.com/us/app/id"
    let itunesApp = "https://itunes.apple.com/app/id"
    let terms = "https://docs.google.com/document/d/1bwlOaTu0iNeSK9trizN619HsuFPRI0KuT77ZRk9V5w4/edit?usp=sharing"
    let privacy = "https://docs.google.com/document/d/1PhLfz3HIAprhY1BL1CAUQJBgZyYctmRssK3uAoJCsCg/edit?usp=sharing"
    let about = "https://curs.md"
}

struct ApplicationFlowConstants {
    
    let onboardingSeenKey = "OnboardingSeen"
}

struct SubscriptionGroup {
    
    var weeklyID = "#"
    var mothlyID = "#"
    var yearlyID = "#"
    var products = [String]()
    
    private init() {}
}

extension SubscriptionGroup {
    
    init(weekly: String, monthly: String, yearly: String) {
        weeklyID = weekly
        mothlyID = monthly
        yearlyID = yearly
        products = [weeklyID, mothlyID, yearlyID]
    }
}

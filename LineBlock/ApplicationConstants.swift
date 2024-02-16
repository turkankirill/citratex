
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
    
    let contentBlockerExtensionIdentifier = "com.terguta.citratex.contentblocker"
    let commonSuiteName = "group.com.terguta.citratex"
    let blockerContainer = "blockerContainer"
    let urlScheme = ""
}

struct Product {
    
    let isPaid = "isProductPaid"
    
    let sharedSecret = "350850eda9fb440bad409e4183a7e461"
    
    var renewableGroup = SubscriptionGroup(weekly: "com.citratex.1week",
                                           monthly: "com.citratex.1month",
                                           yearly: "com.citratex.1year")
    
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
    
    let appURL = "https://apps.apple.com/us/app/id6478011477"
    let itunesApp = "https://itunes.apple.com/app/id6478011477"
    let terms = ""
    let privacy = ""
    let about = ""
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

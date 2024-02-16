import Firebase
import Foundation

class Terms {
    static let shared = Terms()

    var pLoaded = false
    var uLoaded = false

    private init() {
        fetchRC()
    }

    func fetchRC() {
        DispatchQueue.main.async {
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfigSettings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = remoteConfigSettings
        RemoteConfig.remoteConfig().fetchAndActivate { [weak self] _, error in
            if let error = error {
                print("Error fetching remote config: \(error.localizedDescription)")
                return
            }
                self?.uLoaded = true
                self?.pLoaded = true
            }
        }
    }

    func terms() -> String {
        let remoteConfig = RemoteConfig.remoteConfig()
        let defaultValue = ImmutableValues.appUrl.terms
        let myValue = remoteConfig.configValue(forKey: "uterms").stringValue ?? defaultValue
        return myValue
    }

    func privacy() -> String {
        let remoteConfig = RemoteConfig.remoteConfig()
        let defaultValue = ImmutableValues.appUrl.privacy
        let myValue = remoteConfig.configValue(forKey: "pprivacy").stringValue ?? defaultValue

        return myValue
    }
}

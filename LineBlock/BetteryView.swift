import SwiftUI
import CoreTelephony
import SystemConfiguration

struct BatteryView: View {
    private var batteryLevel: Float {
        UIDevice.current.batteryLevel
    }
    
    private var batteryStatus: UIDevice.BatteryState {
        UIDevice.current.batteryState
    }
    
    private var deviceName: String {
        UIDevice.current.name
    }
    
    private var deviceSystemVersion: String {
        ProcessInfo.processInfo.operatingSystemVersionString
    }
    
    private var networkReachabilityStatus: String {
        getNetworkReachabilityStatus()
    }
    
    private var appVersionAndBuild: String? {
        getAppVersionAndBuild()
    }
    
    private var currentNetworkOperator: String? {
        getCurrentNetworkOperator()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ArcProgressView1(value: batteryLevel * 100)
                .frame(height: 160)
                .shadow(color: .bRobinEggBlue.opacity(0.3) ,radius: 10)
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                locationDataView(key: "Battery Level", value: "\(batteryLevel * 100)", color: .clear)
                    .padding(.trailing, 4)

                locationDataView(key: "Battery Status", value: "\(batteryStatus.rawValue)", color: .clear)
                    .padding(.leading, 4)
                locationDataView(key: "Device Name", value: "\(deviceName)", color: .clear)
                    .padding(.trailing, 4)
                locationDataView(key: "Device Version", value: "\(deviceSystemVersion)", color: .clear)
                    .padding(.leading, 4)
                locationDataView(key: "Network Status", value: "\(networkReachabilityStatus)", color: .clear)
                    .padding(.trailing, 4)
                if let networkOperator = currentNetworkOperator {
                    locationDataView(key: "Current Network Operator", value: "\(networkOperator)", color: .clear)
                        .padding(.leading, 4)
                } else {
                    locationDataView(key: "Current Network Operator", value: "Unavailable", color: .clear)
                        .padding(.leading, 4)
                }
            }
        }
        .padding()
    }
    private func locationDataView(key: String, value: String?, color: Color) -> some View {
        VStack {
            Text("\(key):")
            Text("\(value ?? "Fetching...")")
                .underline()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(.white))
//            .stroke(lineWidth: 1.0))
        .background(color)
        .cornerRadius(20)
        .shadow(color: .bRobinEggBlue.opacity(0.3) ,radius: 10)

    }
    private func getNetworkReachabilityStatus() -> String {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") else {
            return "Not available"
        }
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        if flags.contains(.reachable) {
            if flags.contains(.isWWAN) {
                return "Cellular"
            } else {
                return "WiFi"
            }
        } else {
            return "No connection"
        }
    }
    
    private func getAppVersionAndBuild() -> String? {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let version = infoDictionary["CFBundleShortVersionString"] as? String,
              let build = infoDictionary["CFBundleVersion"] as? String else {
            return nil
        }
        return "Version: \(version), Build: \(build)"
    }

    private func getCurrentNetworkOperator() -> String? {
        let networkInfo = CTTelephonyNetworkInfo()
        if let carrier = networkInfo.subscriberCellularProvider {
            return carrier.carrierName
        }
        return nil
    }
}



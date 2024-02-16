
import SwiftUI
import MapKit
import Network


struct InfoView: View {
    @State private var ipAddress: String = "Fetching IP..."
    @State private var locationData: LocationData?
    @State private var freeSpace: String = "Calculating..."
    @State private var totalSpace: String = "Calculating..."
    @State var progressPercentage: Double = 0
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 26) {
                    Text("Free space on Phone")
                        .font(.workSans(.Medium, style: .title3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 24)
                    WaveSpaceView(progressPercentage: $progressPercentage, freeSpace: freeSpace, totalSpace: totalSpace)
                    if locationData != nil {
                        Text("Your IP information")
                            .font(.workSans(.Medium, style: .title3))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 24)
                            .padding(.top)
                        NavigationLink(destination: ConnectionInformationView()) {
                            MapView(coordinate: extractCoordinate() ?? CLLocationCoordinate2D())
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .cornerRadius(20)
                                .overlay(alignment: .leading) {
                                    mapViewInfo
                                }
                                .padding(.horizontal)
                                .shadow(color: .bRobinEggBlue.opacity(0.3) ,radius: 10)
                        }
                            
                             
                    }
                    Text("Battery Info")
                        .font(.workSans(.Medium, style: .title3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 24)
                        .padding(.top)
                    BatteryView()
                        .padding(.bottom, 100)
                }
            }
        }
            .onAppear {
                updateStorageInfoShieldedMemoriesVault()
            }
            .onAppear {
                self.fetchIPAddress()
            }
        
    }
    
    func updateStorageInfoShieldedMemoriesVault() {
        let percentage = calculateStorageUsagePercentageShieldedMemoriesVault()
           self.progressPercentage = percentage
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let attributes = try FileManager.default.attributesOfFileSystem(forPath: documentDirectory.path)
                if let freeSpace = attributes[.systemFreeSize] as? NSNumber, let totalSpace = attributes[.systemSize] as? NSNumber {
                    self.freeSpace = byteCountFormatterShieldedMemoriesVault.string(fromByteCount: freeSpace.int64Value)
                    self.totalSpace = byteCountFormatterShieldedMemoriesVault.string(fromByteCount: totalSpace.int64Value)
                }
            } catch {
                print("Error getting storage information: \(error)")
            }
        }
    }
    
    func calculateStorageUsagePercentageShieldedMemoriesVault() -> Double {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let attributes = try FileManager.default.attributesOfFileSystem(forPath: documentDirectory.path)
                if let freeSpace = attributes[.systemFreeSize] as? Int64, let totalSpace = attributes[.systemSize] as? Int64 {
                    let usedSpace = totalSpace - freeSpace
                    if totalSpace > 0 {
                        let percentage = Double(usedSpace) / Double(totalSpace) * 100.0
                        return percentage
                    }
                }
            } catch {
                print("Error getting storage information: \(error)")
            }
        }
        return 0.0
    }
    
    let byteCountFormatterShieldedMemoriesVault: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB]
        formatter.countStyle = .file
        return formatter
    }()
    
    private func fetchIPAddress() {
        guard let url = URL(string: "https://api.ipify.org") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let ipAddress = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.ipAddress = ipAddress
                    self.fetchLocation(ipAddress: ipAddress)
                }
            }
        }
        task.resume()
    }

    private func fetchLocation(ipAddress: String) {
        guard let url = URL(string: "https://ipinfo.io/\(ipAddress)/json") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let locationData = try decoder.decode(LocationData.self, from: data)
                    DispatchQueue.main.async {
                        self.locationData = locationData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        task.resume()
    }

    private func extractCoordinate() -> CLLocationCoordinate2D? {
        if let locationData = locationData {
            let components = locationData.loc.split(separator: ",")
            if components.count == 2, let latitude = Double(components[0]), let longitude = Double(components[1]) {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        return nil
    }
}

#Preview {
    InfoView()
}

extension InfoView {
    var mapView: some View {
            MapView(coordinate: extractCoordinate() ?? CLLocationCoordinate2D())
                .frame(maxWidth: .infinity, maxHeight: 200)
                .cornerRadius(20)
                .overlay(alignment: .leading) {
                    mapViewInfo
                }
                .padding(.horizontal)
        }
    
    var mapViewInfo: some View {
        VStack {
            HStack {
                Image("ipAddress")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(Color.bRobinEggBlue)
                VStack(alignment: .leading) {
                    Text("\(locationData?.region ?? "")")
                    Text("\(locationData?.city ?? "")")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Image("locationi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(Color.bRobinEggBlue)
                Text("\(ipAddress)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .frame(width: 200)
        .background(RoundedRectangle(cornerRadius: 30.0)
            .fill(.white))
        .offset(x: 20)
    }
}


struct ArcProgressView1: View {
    var value: Float
    var lineWidth: CGFloat = 12.0
    var symboleName: String = ""
    var text: String = ""
    var monochrome: Bool = false
    var useGreen: Bool = false
    var outerRingColor: Color = Color("blue")
    var innerRingColor: Color {
        if monochrome {
            return Color.white
        } else {
            if value <= 0.1 {
                return Color.red
            } else if value <= 0.2 {
                return Color.yellow
            } else {
                if useGreen {
                    return Color.green
                } else {
                    return Color.blue
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack{
                    Color.bMintCream
                }
                    .frame(width: 141, height: 280 )
                    .frame(maxHeight: 280, alignment: .bottom)
                    .cornerRadius(35)
                    .offset(y: 15)
                    .rotationEffect(Angle(degrees: 90))
                ZStack{
                    Color.bRobinEggBlue
                }
                    .frame(width: 141, height: 280 * getRingPostion(geometry.size))
                    .frame(maxHeight: 280, alignment: .bottom)
                    .cornerRadius(35)
                    .offset(y: 15)
                    .rotationEffect(Angle(degrees: 90))
                
                Image(systemName: "battery.0")
                    .resizable()
                    .fontWeight(.thin)
                    .rotationEffect(Angle(degrees: 360))
                    .frame(width: 320,height: 160)
                    .foregroundColor(Color.bGunmetal)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 160)
            .overlay(Text(text)
                .font(.title))
//                .font(.lato(.regular, size: geometry.size.height / 8)))
        }
    }
    
    private struct LevelText: View {
        var level: Float
        var size: CGSize
        
        var body: some View {
            Text(getPercent())
                .font(.system(size: getFontSize()))
                //.bold(size.width < 100 ? true : false)
                .offset(y: -(size.height / 20))
        }
        
        func getPercent() -> String {
            if size.height < 100 {
                return level.toPercentString(percentSymbol: "")
            } else {
                return level.toPercentString()
            }
        }
        
        func getFontSize() -> Double {
            if size.height < 100 {
                return size.height / 2.8
            } else {
                return size.height / 4.0
            }
        }
    }
    
    func getRingPostion(_ size: CGSize) -> CGFloat {
        let offset = trimMargin(size)
        var pos = CGFloat(value) * (1.0 - trimMargin(size) * 2.0)
        pos += offset
        pos = max(0.001, pos)
        return pos
    }

    func radius(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) / 2.0
    }
    
    func trimMargin(_ size: CGSize) -> CGFloat {
        let r = radius(size)
        if r < 40 {
            // lock screen widget
            return 0.18
        } else if r < 100 {
            // home screen  widget
            return 0.17
        } else {
            // main app
            return 0.15
        }
    }
    
    func symbolWidth(_ size: CGSize) -> CGFloat {
        let r = radius(size)
        if r < 40 {
            // lock screen widget
            return r / 1
        } else if r < 100 {
            // home screen  widget
            return r / 1.2
        } else {
            // main app
            return r / 1.5
        }
    }
    
    func symbolOffset(_ size: CGSize) -> CGFloat {
        let r = radius(size)
        var offset = r * 0.65
        offset -= (lineWidth)
        offset -= 3
//        if r < 40 {
//            offset -= 2
//        }
        return offset
    }
}

import SwiftUI
import MapKit
import Network

struct ConnectedButtonView: View {
    @State private var ipAddress: String = "Fetching IP..."
    @State private var locationData: LocationData?
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var blockerViewModel: ContentblockersViewModel
//    var onToggleFirst: (() -> Void)?
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                Text(blockerViewModel.blockers[0].state ? "CONNECTED" : "DISCONNECTED")
                    .font(.workSans(.Bold, style: .title2))
                    .foregroundColor(Color.bMintCream)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(locationData?.city ?? "Fetching...")
                        .font(.workSans(.SemiBold, style: .body))
                        .foregroundColor(Color.bMintCream)
                    
                    Text(ipAddress)
                        .font(.workSans(.Light, style: .subheadline))
                        .foregroundColor(Color.bMintCream)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 32)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.bRobinEggBlue)
            )
        }
        .overlay(alignment: .topTrailing) {
            Image(blockerViewModel.blockers[0].state ? "lightBulb" : "lightBulbBlack")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.bGunmetal)
                .padding(.vertical, 24)
                .rotationEffect(Angle(degrees: 180))
                .padding(.trailing, 8)
                .background(Color.clear)
                .onTapGesture {
//                    blockerViewModel.switchBlocker(title: blockerViewModel.blockers[0].title)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .shadow(color: .bRobinEggBlue.opacity(0.3), radius: 10)
        .onAppear {
            self.fetchIPAddress()
        }
        .overlay() {
            Text("Tap to connected")
                .font(.workSans(.Light, style: .subheadline))
                .foregroundColor(Color.bMintCream)
                .opacity(blockerViewModel.blockers[0].state ? 0 : 1)
                .onTapGesture{ blockerViewModel.switchBlocker(title: blockerViewModel.blockers.first!.title)}
        }
        .onTapGesture {
//            blockerViewModel.switchBlocker(title: blockerViewModel.blockers[0].title)
            
        }
    }
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
    ConnectedButtonView()
}

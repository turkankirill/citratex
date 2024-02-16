import SwiftUI
import MapKit
import Network

struct ConnectionInformationView: View {
    @State private var ipAddress: String = "Fetching IP..."
    @State private var locationData: LocationData?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack() {
            if locationData != nil {
                MapView(coordinate: extractCoordinate() ?? CLLocationCoordinate2D())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    
                    .padding(.bottom, 400)
            } else {
                Text("Fetching location...")
            }
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ipAddressView
                    locationInfoView

            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .font(.workSans(.Regular, style: .footnote))
            .frame(maxWidth: .infinity, maxHeight: 420)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white))
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading){
            Image(systemName: "chevron.left.circle.fill")
                .font(.title)
                .padding(20)
                .padding(.top, 32)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
            .ignoresSafeArea()
            .onAppear {
                self.fetchIPAddress()
            }
    }

    private var ipAddressView: some View {
        VStack(spacing: 16) {
            locationDataView(key: "IP Address", value: ipAddress, color: Color.bLightRed)
            locationDataView(key: "City", value: locationData?.city, color: Color.bMintCream)
            locationDataView(key: "Country", value: locationData?.country, color: Color.bNaplesYellow)
            locationDataView(key: "Region", value: locationData?.region, color: Color.bRobinEggBlue)
        }
        .padding(.trailing, 4)
    }

    private var locationInfoView: some View {
        VStack(spacing: 16) {
            locationDataView(key: "Postal", value: locationData?.postal, color: Color.bNaplesYellow)
            locationDataView(key: "Lat/Lon", value: locationData?.loc, color: Color.bRobinEggBlue)
            locationDataView(key: "Organization", value: locationData?.org, color: Color.bLightRed)
            locationDataView(key: "Timezone", value: locationData?.timezone, color: Color.bMintCream)
        }
        .padding(.leading, 4)
    }

    private func locationDataView(key: String, value: String?, color: Color) -> some View {
        VStack {
            Text("\(key):")
            Text("\(value ?? "Fetching...")")
                .underline()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 1.0))
        .background(color)
        .cornerRadius(20)

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



struct ConnectionInformationView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionInformationView()
    }
}

struct LocationData: Codable {
    var city: String
    var region: String
    var country: String
    var postal: String
    var loc: String
    var org: String
    var timezone: String
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

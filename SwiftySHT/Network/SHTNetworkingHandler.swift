import Foundation

struct SHTNetworkingHandler {
    static func requestPostback() {
        var urlComponents = URLComponents(string: shtGlobalData.funnelConfig.postback)
        urlComponents?.queryItems = [URLQueryItem(name: "subid", value: shtGlobalData.funnelConfig.subid)]
        guard let url = urlComponents?.url?.absoluteURL else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            print("The Response is : ",response)
        }.resume()
    }

}

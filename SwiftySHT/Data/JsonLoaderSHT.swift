import Foundation

enum JsonLoaderSHT {
    static func loader<T: Codable>(type: T.Type, jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false) else { return nil }
        do {
            let jsonStr = String(data: jsonData, encoding: .utf8)
            print(jsonStr as Any)
            let result = try JSONDecoder().decode(T.self, from: jsonData)
//            print(result)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}


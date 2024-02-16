import Foundation

extension String {
    
    static let empty = ""
}

extension String: Identifiable {
    
    public typealias ID = Int
    
    public var id: Int {
        return hash
    }
}

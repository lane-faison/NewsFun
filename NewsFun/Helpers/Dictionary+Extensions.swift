import Foundation

// Global typealias
public typealias JSON = [String: Any]

extension Dictionary {
    
    public func JSON() -> Data {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return jsonData
        } catch let error as NSError {
            print("Failed to convert json to Data: \(error)")
            return Data()
        }
    }
}

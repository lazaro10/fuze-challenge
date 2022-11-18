import Foundation

protocol NetworkDeserializationLogic {
    func decode<T: Decodable>(data: Data?) throws -> T
}

final class NetworkDeserialization: NetworkDeserializationLogic {
    func decode<T: Decodable>(data: Data?) throws -> T {
        guard let data = data else {
            throw NetworkDeserializationError.invalidData
        }

        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkDeserializationError.invalidDecode
        }
    }
}

enum NetworkDeserializationError: Error {
    case invalidData
    case invalidDecode
}

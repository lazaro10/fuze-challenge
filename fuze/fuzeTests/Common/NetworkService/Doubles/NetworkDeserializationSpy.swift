@testable import fuze
import Foundation

final class NetworkDeserializationSpy: NetworkDeserializable {
    private(set) var invokedDecodeCount = 0
    private(set) var invokedDecodeParameterData: Data?
    var stubbedDecodeResult: Decodable?
    var stubbedDecodeError: Error?

    func decode<T>(data: Data?) throws -> T where T : Decodable {
        invokedDecodeCount += 1
        invokedDecodeParameterData = data
        
        if let error = stubbedDecodeError {
            throw error
        }
        
        guard let object = stubbedDecodeResult as? T else { fatalError("invalid return") }
        
        return object
    }
}

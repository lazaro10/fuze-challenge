@testable import fuze
import Foundation

final class NetworkSpy: NetworkLogic {
    private(set) var invokedRequestCount = 0
    private(set) var invokedRequestParameterRequest: NetworkRequest?
    var stubbedRequestCompletionResult: Any?

    func request<T: Decodable>(_ networkRequest: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) {
        invokedRequestCount += 1
        invokedRequestParameterRequest = networkRequest
        if let result = stubbedRequestCompletionResult as? Result<T, Error> {
            completion(result)
        }
    }
}

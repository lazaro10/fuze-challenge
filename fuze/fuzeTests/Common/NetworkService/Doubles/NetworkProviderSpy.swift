@testable import fuze
import Foundation

final class NetworkProviderSpy: NetworkProviderLogic {
    private(set) var invokedDataTaskCount = 0
    private(set) var invokedDataTaskParameterRequest: URLRequest?
    var stubbedDataTaskCompletionHandlerResult: (Data?, URLResponse?, Error?)?

    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask? {
        invokedDataTaskCount += 1
        invokedDataTaskParameterRequest = request
        if let result = stubbedDataTaskCompletionHandlerResult {
            completionHandler(result.0, result.1, result.2)
        }
        
        return nil
    }
}

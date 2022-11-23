@testable import fuze
import Foundation

final class NetworkProviderSpy: NetworkProviding {
    private(set) var invokedDataTaskCount = 0
    private(set) var invokedDataTaskParameterRequest: URLRequest?
    var stubbedDataTaskCompletionHandlerResult: (Data?, URLResponse?, Error?)?

    func dataTask(
        request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask? {
        invokedDataTaskCount += 1
        invokedDataTaskParameterRequest = request
        if let result = stubbedDataTaskCompletionHandlerResult {
            completionHandler(result.0, result.1, result.2)
        }
        return nil
    }

    private(set) var invokedDownloadTaskCount = 0
    private(set) var invokedDataTaskParameterURL: URL?
    var stubbedDownloadTaskCompletionHandlerResult: (URL?, URLResponse?, Error?)?

    func downloadTask(
        url: URL,
        completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void
    ) -> URLSessionDownloadTask? {
        invokedDownloadTaskCount += 1
        invokedDataTaskParameterURL = url
        if let result = stubbedDownloadTaskCompletionHandlerResult {
            completionHandler(result.0, result.1, result.2)
        }
        return nil
    }
}

@testable import fuze
import Foundation

final class BaseURLProviderSpy: BaseURLProviding {
    private(set) var invokedGetURLCount = 0
    private(set) var invokedGetURLParameterApi: ApiProvider?
    var stubbedGetURLResult: URL?
    
    func getURL(api: ApiProvider) -> URL {
        invokedGetURLCount += 1
        invokedGetURLParameterApi = api
        
        guard let url = stubbedGetURLResult else {
            fatalError("Invalid URL")
        }

        return url
    }
}

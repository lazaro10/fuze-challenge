@testable import fuze
import Foundation

final class AppConfigurationProviderSpy: AppConfigurationProviding {
    private(set) var invokedBaseURLCount = 0
    private(set) var invokedBaseURLParameterConfiguration: ApiConfiguration?
    var stubbedBaseURLResult: URL?

    func baseURL(_ configuration: ApiConfiguration) -> URL {
        invokedBaseURLCount += 1
        invokedBaseURLParameterConfiguration = configuration

        guard let url = stubbedBaseURLResult else {
            fatalError("Invalid URL")
        }

        return url
    }

    private(set) var invokedAccessTokenCount = 0
    private(set) var invokedAccessTokenParameterConfiguration: ApiConfiguration?
    var stubbedAccessTokenResult: String = ""

    func accessToken(_ configuration: ApiConfiguration) -> String {
        invokedAccessTokenCount += 1
        invokedAccessTokenParameterConfiguration = configuration
        return stubbedAccessTokenResult
    }
}

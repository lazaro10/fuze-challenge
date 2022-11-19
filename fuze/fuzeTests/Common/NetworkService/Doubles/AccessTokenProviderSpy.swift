@testable import fuze
import Foundation

final class AccessTokenProviderSpy: AccessTokenProviderLogic {
    private(set) var invokedGetAccessTokenCount = 0
    private(set) var invokedGetAccessTokenParameterApi: ApiProvider?
    var stubbedGetAccessTokenResult: (key: String, value: String)?
    
    func getAccessToken(api: ApiProvider) -> (key: String, value: String) {
        invokedGetAccessTokenCount += 1
        invokedGetAccessTokenParameterApi = api
        
        guard let accessToken = stubbedGetAccessTokenResult else {
            return (key: "", value: "")
        }
        
        return accessToken
    }
}

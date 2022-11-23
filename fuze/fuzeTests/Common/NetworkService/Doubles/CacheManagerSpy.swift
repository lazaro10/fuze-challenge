@testable import fuze
import Foundation

final class CacheManagerSpy: CacheManagerLogic {
    private(set) var invokedPutCount = 0
    private(set) var invokedPutParameterData: URL?
    private(set) var invokedPutParameterURL: URL?
    var stubbedPutError: Error?

    func put(data: URL, url: URL) throws {
        invokedPutCount += 1
        invokedPutParameterData = data
        invokedPutParameterURL = url
        if let error = stubbedPutError {
            throw error
        }
    }

    private(set) var invokedGetCount = 0
    private(set) var invokedGetParameterUrl: URL?
    private(set) var stubbedGetError: Error?
    var stubbedGetResult: Data = Data()

    func get(url: URL) throws -> Data {
        invokedGetCount += 1
        invokedGetParameterUrl = url
        if let error = stubbedGetError {
            throw error
        }
        return stubbedGetResult
    }
}

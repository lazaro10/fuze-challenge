@testable import fuze
import Foundation

final class FileManagerProviderSpy: FileManagerProviderLogic {
    private(set) var invokedAppendingPathComponentCount = 0
    private(set) var invokedAppendingPathComponentParameterPathComponent: String?
    private(set) var invokedAppendingPathComponentParameterIsDirectory: Bool?
    var stubbedAppendingPathComponentResult: URL?

    func appendingPathComponent(_ pathComponent: String, isDirectory: Bool) -> URL {
        invokedAppendingPathComponentCount += 1
        invokedAppendingPathComponentParameterPathComponent = pathComponent
        invokedAppendingPathComponentParameterIsDirectory = isDirectory
        
        guard let url = stubbedAppendingPathComponentResult else {
            fatalError("Invalid URL")
        }

        return url
    }

    private(set) var invokedCopyItemCount = 0
    private(set) var invokedCopyItemParameterSrcURL: URL?
    private(set) var invokedCopyItemParameterDstURL: URL?
    var stubbedCopyItemError: Error?

    func copyItem(srcURL: URL, dstURL: URL) throws {
        invokedCopyItemCount += 1
        invokedCopyItemParameterSrcURL = srcURL
        invokedCopyItemParameterDstURL = dstURL
        
        if let error = stubbedCopyItemError {
            throw error
        }
    }

    private(set) var invokedFileExistsCount = 0
    private(set) var invokedFileExistsParameterPath: String?
    var stubbedFileExistsResult: Bool = false

    func fileExists(path: String) -> Bool {
        invokedFileExistsCount += 1
        invokedFileExistsParameterPath = path
        
        return stubbedFileExistsResult
    }

    private(set) var invokedRemoveItemCount = 0
    private(set) var invokedRemoveItemParameterURL: URL?
    var stubbedRemoveItemError: Error?

    func removeItem(url: URL) throws {
        invokedRemoveItemCount += 1
        invokedRemoveItemParameterURL = url
        
        if let error = stubbedRemoveItemError {
            throw error
        }
    }
}

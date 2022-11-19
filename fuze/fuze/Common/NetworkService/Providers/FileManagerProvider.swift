import Foundation

protocol FileManagerProviderLogic {
    func appendingPathComponent(_ pathComponent: String, isDirectory: Bool) -> URL
    func copyItem(srcURL: URL, dstURL: URL) throws
    func fileExists(path: String) -> Bool
    func removeItem(url: URL) throws
}

struct FileManagerProvider: FileManagerProviderLogic {
    func appendingPathComponent(_ pathComponent: String, isDirectory: Bool) -> URL {
        FileManager.default.temporaryDirectory.appendingPathComponent(pathComponent, isDirectory: isDirectory)
    }
    
    func copyItem(srcURL: URL, dstURL: URL) throws {
        try FileManager.default.copyItem(at: srcURL, to: dstURL)
    }
    
    func fileExists(path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }
    
    func removeItem(url: URL) throws {
        try FileManager.default.removeItem(at: url)
    }
}

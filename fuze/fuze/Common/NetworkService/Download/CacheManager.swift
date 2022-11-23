import Foundation

protocol CacheManagerLogic {
    func put(data: URL, url: URL) throws
    func get(url: URL) throws -> Data
}

final class CacheManager: CacheManagerLogic {
    private var memoryCache: [String: URL] = [:]
    private let fileManager: FileManagerProviderLogic

    init(fileManager: FileManagerProviderLogic) {
        self.fileManager = fileManager
    }

    func put(data: URL, url: URL) throws {
        let file = fileManager.appendingPathComponent(url.lastPathComponent, isDirectory: false)

        do {
            if fileManager.fileExists(path: file.path) {
                try fileManager.removeItem(url: file)
            }

         //   memoryCache[file.path] = data

            try fileManager.copyItem(srcURL: data, dstURL: file)
        }
    }

    func get(url: URL) throws -> Data  {
        let file = fileManager.appendingPathComponent(url.lastPathComponent, isDirectory: false)
        return try Data(contentsOf: file)
//        if let memoryData = memoryCache[file.path] {
//            return try Data(contentsOf: memoryData)
//        } else {
//            return try Data(contentsOf: file)
//        }
    }
}

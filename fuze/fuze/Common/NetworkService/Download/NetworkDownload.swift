import Foundation

protocol NetworkDownloadLogic {
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkDownload {
    static let shared: NetworkDownload = NetworkDownloadBuilder.build()
    private let session: NetworkProviderLogic
    private let cacheManager: CacheManagerLogic

    init(
        session: NetworkProviderLogic,
        cacheManager: CacheManagerLogic
    ) {
        self.session = session
        self.cacheManager = cacheManager
    }

    private func download(url: URL, completion: @escaping (Error?) -> Void) {
        let task = session.downloadTask(url: url) { [weak self] dataURL, _, error in
            guard let self = self else { return }

            if let error = error {
                return completion(error)
            }

            do {
                if let dataURL = dataURL {
                    try self.cacheManager.put(data: dataURL, url: url)
                }

                completion(nil)
            } catch {
                completion(error)
            }
        }

        task?.resume()
    }
}

extension NetworkDownload: NetworkDownloadLogic {
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let data = try cacheManager.get(url: url)
            completion(.success(data))
        } catch {
            download(url: url) { [weak self] error in
                guard let self = self else { return }
                do {
                    let data = try self.cacheManager.get(url: url)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

//import Foundation
//
//protocol NetworkDownloadLogic {
//    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
//}
//
//final class NetworkDownload {
//    static let shared = NetworkDownload(session: NetworkProvider(), fileManagerProvdider: FileManagerProvider())
//
//    private let session: NetworkProviderLogic
//    private let fileManagerProvdider: FileManagerProviderLogic
//
//    init(
//        session: NetworkProviderLogic,
//        fileManagerProvdider: FileManagerProviderLogic
//    ) {
//        self.session = session
//        self.fileManagerProvdider = fileManagerProvdider
//    }
//
//    private func download(url: URL, file: URL, completion: @escaping (Error?) -> Void) {
//        let task = session.downloadTask(url: url) { [weak self] dataURL, _, error in
//            guard let self = self else { return }
//            if let error = error {
//                return completion(error)
//            }
//
//            do {
//                if self.fileManagerProvdider.fileExists(path: file.path) {
//                    try self.fileManagerProvdider.removeItem(url: file)
//                }
//
//                if let dataURL = dataURL {
//                    try self.fileManagerProvdider.copyItem(srcURL: dataURL, dstURL: file)
//                }
//
//                completion(nil)
//            } catch {
//                completion(error)
//            }
//        }
//
//        task?.resume()
//    }
//}
//
//extension NetworkDownload: NetworkDownloadLogic {
//    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
//        let cachedFile = fileManagerProvdider.appendingPathComponent(url.lastPathComponent, isDirectory: false)
//
//        do {
//            let data = try Data(contentsOf: cachedFile)
//            completion(.success(data))
//        } catch {
//            download(url: url, file: cachedFile) { error in
//                do {
//                    let data = try Data(contentsOf: cachedFile)
//                    completion(.success(data))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
//}

import Foundation

protocol NetworkDownloadLogic {
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkDownload {
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

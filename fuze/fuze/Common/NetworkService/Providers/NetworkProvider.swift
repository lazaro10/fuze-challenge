import Foundation

protocol NetworkProviderLogic {
    func dataTask(
        request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask?
    
    func downloadTask(
        url: URL,
        completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void
    ) -> URLSessionDownloadTask?
}

struct NetworkProvider: NetworkProviderLogic {
    func dataTask(
        request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask? {
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    }
    
    func downloadTask(
        url: URL,
        completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void
    ) -> URLSessionDownloadTask? {
        URLSession.shared.downloadTask(with: url, completionHandler: completionHandler)
    }
}

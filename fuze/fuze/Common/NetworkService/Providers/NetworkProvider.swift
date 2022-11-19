import Foundation

protocol NetworkProviderLogic {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask?
}

struct NetworkProvider: NetworkProviderLogic {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask? {
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    }
}

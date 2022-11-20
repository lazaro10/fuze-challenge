import Foundation

protocol NetworkRequest {
    var baseURL: ApiProvider { get }
    var path: String { get }
    var method: NetworkServiceMethod { get }
    var queryParameters: [String: String] { get }
    var headers: [String: String] { get }
}

extension NetworkRequest {
    var baseURL: ApiProvider { .pandaScore }
    var queryParameters: [String: String] { [:] }
    var headers: [String: String] { [:] }
}

enum NetworkRequestError: Error, Equatable {
    case invalidPath
    case invalidURL
}

extension NetworkRequest {
    func toRequest(baseURL: URL, token: (key: String, value: String)) throws -> URLRequest {
        guard var urlPathComponent = URLComponents(string: path) else {
            throw NetworkRequestError.invalidPath
        }

        urlPathComponent.queryItems = queryParameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        urlPathComponent.queryItems?.append(URLQueryItem(name: token.key, value: token.value))
        
        guard let url = urlPathComponent.url(relativeTo: baseURL) else {
            throw NetworkRequestError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}

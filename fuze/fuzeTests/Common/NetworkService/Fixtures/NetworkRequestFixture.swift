import XCTest
@testable import fuze

struct Request: NetworkRequest {
    var baseURL: ApiProvider
    var path: String
    var method: NetworkServiceMethod
    var queryParameters: [String: String]
    var bodyParameters: [String: Any]?
    var headers: [String: String]
}

extension Request {
    static func fixture(
        baseURL: ApiProvider = .pandaScore,
        path: String = "/path",
        method: NetworkServiceMethod = .get,
        queryParameters: [String: String] = ["queryName": "queryValue"],
        bodyParameters: [String: Any] = ["bodyName": "bodyValue"],
        headers: [String: String] = ["headerName": "headerValue"]
    ) -> Request {
         Request(
            baseURL: baseURL,
            path: path,
            method: method,
            queryParameters: queryParameters,
            bodyParameters: bodyParameters,
            headers: headers
         )
    }
}

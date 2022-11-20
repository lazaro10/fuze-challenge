import XCTest
@testable import fuze

struct Request: NetworkRequest {
    var baseURL: ApiProvider
    var path: String
    var method: NetworkServiceMethod
    var parameters: [String : String]
    var headers: [String: String]
}

extension Request {
    static func fixture(
        baseURL: ApiProvider = .pandaScore,
        path: String = "/path",
        method: NetworkServiceMethod = .get,
        parameters: [String: String] = ["paramName": "paramValue"],
        headers: [String: String] = ["headerName": "headerValue"]
    ) -> Request {
         Request(
            baseURL: baseURL,
            path: path,
            method: method,
            parameters: parameters,
            headers: headers
         )
    }
}

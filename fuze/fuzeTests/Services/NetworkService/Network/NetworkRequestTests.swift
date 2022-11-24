import XCTest
@testable import fuze

final class NetworkRequestTests: XCTestCase {
    func test_toRequest_givenValidParameters_shouldCreateTheCorrectRequest() throws {
        let sut = Request.fixture()

        let baseURL = try XCTUnwrap(URL(string: "https://moises.ai"))
        let request = try sut.toRequest(baseURL: baseURL)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://moises.ai/path?paramName=paramValue")
        
        let expectedHTTPHeaders = ["headerName": "headerValue"]
        XCTAssertEqual(request.allHTTPHeaderFields, expectedHTTPHeaders)
    }
}

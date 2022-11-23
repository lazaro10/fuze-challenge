import XCTest
@testable import fuze

final class NetworkRequestTests: XCTestCase {
    func test_toRequest_givenValidParameters_shouldCreateTheCorrectRequest() throws {
        let sut = Request.fixture()

        let baseURL = try XCTUnwrap(URL(string: "https://moises.ai"))
        let request = try sut.toRequest(baseURL: baseURL, token: (key: "token", value: "u8y7t6hj"))
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://moises.ai/path?paramName=paramValue&token=u8y7t6hj")
        
        let expectedHTTPHeaders = ["headerName": "headerValue"]
        XCTAssertEqual(request.allHTTPHeaderFields, expectedHTTPHeaders)
    }
    
    func test_toRequest_givenInvalidPath_shouldThrowInvalidPathError() throws {
        let sut = Request.fixture(path: "%#$$fff")
        let baseURL = try XCTUnwrap(URL(string: "https://moises.ai"))
        
        XCTAssertThrowsError(try sut.toRequest(baseURL: baseURL, token: (key: "token", value: "i9yt6r5jkhj"))) { error in
            XCTAssertEqual(error as? NetworkRequestError, .invalidPath)
        }
    }
}

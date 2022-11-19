import XCTest
@testable import fuze

final class NetworkRequestTests: XCTestCase {
    func test_toRequest_givenValidParameters_shouldCreateTheCorrectRequest() throws {
        let sut = Request.fixture()

        let baseURL = try XCTUnwrap(URL(string: "https://moises.ai"))
        let request = try sut.toRequest(baseURL: baseURL)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://moises.ai/path?queryName=queryValue")
        
        let expectedHTTPHeaders = ["headerName": "headerValue"]
        XCTAssertEqual(request.allHTTPHeaderFields, expectedHTTPHeaders)
        
        let httpBody = try XCTUnwrap(request.httpBody)
        let httpBodyString = String(decoding: httpBody, as: UTF8.self)
        
        XCTAssertEqual(httpBodyString, "{\"bodyName\":\"bodyValue\"}")
    }
    
    func test_toRequest_givenInvalidPath_shouldThrowInvalidPathError() throws {
        let sut = Request.fixture(path: "%#$$fff")
        let baseURL = try XCTUnwrap(URL(string: "https://moises.ai"))
        
        XCTAssertThrowsError(try sut.toRequest(baseURL: baseURL)) { error in
            XCTAssertEqual(error as? NetworkRequestError, .invalidPath)
        }
    }
    
    func test_toRequest_givenInvalidURL_shouldThrowInvalidURLError() throws {
        let sut = Request.fixture()
        let baseURL = try XCTUnwrap(URL(string: "--------------------00000----------"))
        
        XCTAssertThrowsError(try sut.toRequest(baseURL: baseURL)) { error in
            XCTAssertEqual(error as? NetworkRequestError, .invalidURL)
        }
    }
    
    func test_toRequest_givenInvalidBodyParameters_shouldThrowInvalidBodyParametersError() throws {
        let sut = Request.fixture(bodyParameters: ["0-0-0$$$$": 98989, "p0p0p0": String("s333")])
        let baseURL = try XCTUnwrap(URL(string: "https://moises.ai"))
        
        XCTAssertThrowsError(try sut.toRequest(baseURL: baseURL)) { error in
            XCTAssertEqual(error as? NetworkRequestError, .invalidBodyParameters)
        }
    }
}

import XCTest
@testable import fuze

final class NetworkTests: XCTestCase {
    let sessionSpy = NetworkProviderSpy()
    let deserializationSpy = NetworkDeserializationSpy()
    let urlProviderSpy = BaseURLProviderSpy()
    let accessTokenProviderSpy = AccessTokenProviderSpy()

    lazy var sut = Network(
        session: sessionSpy,
        deserialization: deserializationSpy,
        urlProvider: urlProviderSpy,
        accessTokenProvider: accessTokenProviderSpy
    )

    func test_request_givenSuccess_shouldCompletionWithSuccess() throws {
        let json = ""

        let url = try XCTUnwrap(URL(string: "https://moises.ai"))

        sessionSpy.stubbedDataTaskCompletionHandlerResult = (
            Data(json.utf8),
            HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1", headerFields: [:]),
            nil
        )

        deserializationSpy.stubbedDecodeResult = ResponseModel.fixture()
        urlProviderSpy.stubbedGetURLResult = url
        accessTokenProviderSpy.stubbedGetAccessTokenResult = (key: "token", value: "l54o4k")

        var resultRequest: Result<ResponseModel, Error>?

        sut.request(Request.fixture()) { (result: Result<ResponseModel, Error>) in
            resultRequest = result
        }

        switch resultRequest {
        case .success(let object):
            XCTAssertEqual(sessionSpy.invokedDataTaskCount, 1)
            XCTAssertEqual(sessionSpy.invokedDataTaskParameterRequest?.url?.absoluteString, "https://moises.ai/path?paramName=paramValue&token=l54o4k")
            XCTAssertEqual(accessTokenProviderSpy.invokedGetAccessTokenCount, 1)
            XCTAssertEqual(accessTokenProviderSpy.invokedGetAccessTokenParameterApi, .pandaScore)
            XCTAssertEqual(urlProviderSpy.invokedGetURLCount, 1)
            XCTAssertEqual(urlProviderSpy.invokedGetURLParameterApi, .pandaScore)
            XCTAssertEqual(deserializationSpy.invokedDecodeCount, 1)
            XCTAssertNotNil(deserializationSpy.invokedDecodeParameterData)
            XCTAssertEqual(object.firstParam, "fuze")
            XCTAssertEqual(object.secondParam, 456)
        default:
            XCTFail("Expected to be success")
        }
    }
    
    func test_request_givenHasError_shouldCompletionFeilureRequest() throws {
        sessionSpy.stubbedDataTaskCompletionHandlerResult = (nil, nil, ErrorDummy.error)

        deserializationSpy.stubbedDecodeResult = ResponseModel.fixture()
        urlProviderSpy.stubbedGetURLResult = try XCTUnwrap(URL(string: "https://moises.ai"))
        accessTokenProviderSpy.stubbedGetAccessTokenResult = (key: "token", value: "l54o4k")

        var resultRequest: Result<ResponseModel, Error>?

        sut.request(Request.fixture()) { (result: Result<ResponseModel, Error>) in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(sessionSpy.invokedDataTaskCount, 1)
            XCTAssertEqual(accessTokenProviderSpy.invokedGetAccessTokenCount, 1)
            XCTAssertEqual(accessTokenProviderSpy.invokedGetAccessTokenParameterApi, .pandaScore)
            XCTAssertEqual(urlProviderSpy.invokedGetURLCount, 1)
            XCTAssertEqual(urlProviderSpy.invokedGetURLParameterApi, .pandaScore)
            XCTAssertEqual(deserializationSpy.invokedDecodeCount, 0)
            XCTAssertEqual(error as? NetworkError, .failureRequest(error: ErrorDummy.error))
            break
        default:
            XCTFail("Expected to be failure")
        }
    }
 
    func test_request_givenInvalidResponse_shouldCompletionAFeilureResponse() throws {
        let url = try XCTUnwrap(URL(string: "https://moises.ai"))

        sessionSpy.stubbedDataTaskCompletionHandlerResult = (
            nil,
            HTTPURLResponse(url: url, statusCode: 500, httpVersion: "1", headerFields: [:]),
            nil
        )

        deserializationSpy.stubbedDecodeResult = ResponseModel.fixture()
        urlProviderSpy.stubbedGetURLResult = url
        accessTokenProviderSpy.stubbedGetAccessTokenResult = (key: "token", value: "l54o4k")

        var resultRequest: Result<ResponseModel, Error>?

        sut.request(Request.fixture()) { (result: Result<ResponseModel, Error>) in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(sessionSpy.invokedDataTaskCount, 1)
            XCTAssertEqual(accessTokenProviderSpy.invokedGetAccessTokenCount, 1)
            XCTAssertEqual(accessTokenProviderSpy.invokedGetAccessTokenParameterApi, .pandaScore)
            XCTAssertEqual(urlProviderSpy.invokedGetURLCount, 1)
            XCTAssertEqual(urlProviderSpy.invokedGetURLParameterApi, .pandaScore)
            XCTAssertEqual(deserializationSpy.invokedDecodeCount, 0)
            XCTAssertEqual(error as? NetworkError, .failureResponse)
            break
        default:
            XCTFail("Expected to be failure")
        }
    }
    
}

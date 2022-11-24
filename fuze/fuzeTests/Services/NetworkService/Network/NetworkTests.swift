import XCTest
@testable import fuze

final class NetworkTests: XCTestCase {
    let sessionSpy = NetworkProviderSpy()
    let deserializationSpy = NetworkDeserializationSpy()
    let configurationSpy = AppConfigurationProviderSpy()

    lazy var sut = Network(session: sessionSpy, deserialization: deserializationSpy, configuration: configurationSpy)

    func test_request_givenSuccess_shouldCompletionWithSuccess() throws {
        let json = ""

        let url = try XCTUnwrap(URL(string: "https://moises.ai"))

        sessionSpy.stubbedDataTaskCompletionHandlerResult = (
            Data(json.utf8),
            HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1", headerFields: [:]),
            nil
        )

        deserializationSpy.stubbedDecodeResult = ResponseModel.fixture()
        configurationSpy.stubbedBaseURLResult = url

        var resultRequest: Result<ResponseModel, Error>?

        sut.request(Request.fixture()) { (result: Result<ResponseModel, Error>) in
            resultRequest = result
        }

        switch resultRequest {
        case .success(let object):
            XCTAssertEqual(sessionSpy.invokedDataTaskCount, 1)
            XCTAssertEqual(sessionSpy.invokedDataTaskParameterRequest?.url?.absoluteString, "https://moises.ai/path?paramName=paramValue")
            XCTAssertEqual(configurationSpy.invokedBaseURLCount, 1)
            XCTAssertEqual(configurationSpy.invokedBaseURLParameterConfiguration, .pandaScore)
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
        configurationSpy.stubbedBaseURLResult = try XCTUnwrap(URL(string: "https://moises.ai"))

        var resultRequest: Result<ResponseModel, Error>?

        sut.request(Request.fixture()) { (result: Result<ResponseModel, Error>) in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(sessionSpy.invokedDataTaskCount, 1)
            XCTAssertEqual(configurationSpy.invokedBaseURLCount, 1)
            XCTAssertEqual(configurationSpy.invokedBaseURLParameterConfiguration, .pandaScore)
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
        configurationSpy.stubbedBaseURLResult = url

        var resultRequest: Result<ResponseModel, Error>?

        sut.request(Request.fixture()) { (result: Result<ResponseModel, Error>) in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(sessionSpy.invokedDataTaskCount, 1)
            XCTAssertEqual(configurationSpy.invokedBaseURLCount, 1)
            XCTAssertEqual(configurationSpy.invokedBaseURLParameterConfiguration, .pandaScore)
            XCTAssertEqual(deserializationSpy.invokedDecodeCount, 0)
            XCTAssertEqual(error as? NetworkError, .failureResponse)
            break
        default:
            XCTFail("Expected to be failure")
        }
    }
    
}

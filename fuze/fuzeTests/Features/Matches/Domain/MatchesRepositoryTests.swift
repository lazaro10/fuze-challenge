import XCTest
@testable import fuze

final class MatchesRepositoryTests: XCTestCase {
    private let networkSpy = NetworkSpy()
    lazy var sut = MatchesRepository(network: networkSpy)

    func test_fetchRunningMatches_givenSuccess_shouldCompleteSuccess() {
        let successStubbed: Result<[MatchesResponse], Error> = .success([MatchesResponse.fixture()])
        networkSpy.stubbedRequestCompletionResult = successStubbed

        var resultRequest: Result<[MatchesResponse], Error>?

        sut.fetchRunningMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .success(let response):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(response.count, 1)
        default:
            XCTFail("Expected to be success")
        }
    }

    func test_fetchRunningMatches_givenFailure_shouldCompleteError() {
        let failureStubbed: Result<[MatchesResponse], Error> = .failure(NetworkErrorDummy.dummyError)
        networkSpy.stubbedRequestCompletionResult = failureStubbed

        var resultRequest: Result<[MatchesResponse], Error>?

        sut.fetchRunningMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(error as? NetworkErrorDummy, .dummyError)
        default:
            XCTFail("Expected to be failure")
        }
    }

    func test_fetchMatches_givenSuccess_shouldCompleteSuccess() {
        let successStubbed: Result<[MatchesResponse], Error> = .success([MatchesResponse.fixture()])
        networkSpy.stubbedRequestCompletionResult = successStubbed

        var resultRequest: Result<[MatchesResponse], Error>?

        sut.fetchMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .success(let response):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(response.count, 1)
        default:
            XCTFail("Expected to be success")
        }
    }

    func test_fetchMatches_givenFailure_shouldCompleteError() {
        let failureStubbed: Result<[MatchesResponse], Error> = .failure(NetworkErrorDummy.dummyError)
        networkSpy.stubbedRequestCompletionResult = failureStubbed

        var resultRequest: Result<[MatchesResponse], Error>?

        sut.fetchMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(error as? NetworkErrorDummy, .dummyError)
        default:
            XCTFail("Expected to be failure")
        }
    }
}

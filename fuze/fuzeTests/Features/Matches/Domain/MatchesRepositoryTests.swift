import XCTest
@testable import fuze

final class MatchesRepositoryTests: XCTestCase {
    private let networkSpy = NetworkSpy()
    lazy var sut = MatchesRepository(network: networkSpy)

    func test_fetchRunningMatches_givenSuccess_shouldCompleteSuccess() {
        let successStubbed: Result<[MatchModel], Error> = .success([MatchModel.fixture()])
        networkSpy.stubbedRequestCompletionResult = successStubbed

        var resultRequest: Result<[MatchModel], Error>?

        sut.fetchRunningMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .success(let matches):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(matches.count, 1)
        default:
            XCTFail("Expected to be success")
        }
    }

    func test_fetchRunningMatches_givenFailure_shouldCompleteError() {
        let failureStubbed: Result<[MatchModel], Error> = .failure(ErrorDummy.error)
        networkSpy.stubbedRequestCompletionResult = failureStubbed

        var resultRequest: Result<[MatchModel], Error>?

        sut.fetchRunningMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(error as? ErrorDummy, .error)
        default:
            XCTFail("Expected to be failure")
        }
    }

    func test_fetchUpcomingMatches_givenSuccess_shouldCompleteSuccess() {
        let successStubbed: Result<[MatchModel], Error> = .success([MatchModel.fixture()])
        networkSpy.stubbedRequestCompletionResult = successStubbed

        var resultRequest: Result<[MatchModel], Error>?

        sut.fetchUpcomingMatches(page: 1) { result in
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

    func test_fetchUpcomingMatches_givenFailure_shouldCompleteError() {
        let failureStubbed: Result<[MatchModel], Error> = .failure(ErrorDummy.error)
        networkSpy.stubbedRequestCompletionResult = failureStubbed

        var resultRequest: Result<[MatchModel], Error>?

        sut.fetchUpcomingMatches(page: 1) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .failure(let error):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(error as? ErrorDummy, .error)
        default:
            XCTFail("Expected to be failure")
        }
    }
}

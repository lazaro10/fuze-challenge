import XCTest
@testable import fuze

final class PlayersRepositoryTests: XCTestCase {
    private let networkSpy = NetworkSpy()
    private lazy var sut = PlayersRepository(network: networkSpy)

    func test_fetchPlayers_givenSuccess_shouldCompleteSuccess() {
        let successStubbed: Result<[PlayerModel], Error> = .success([.fixture()])
        networkSpy.stubbedRequestCompletionResult = successStubbed

        var resultRequest: Result<[PlayerModel], Error>?

        sut.fetchPlayers(page: 23, teamId: 4444) { result in
            resultRequest = result
        }

        switch resultRequest {
        case .success(let players):
            XCTAssertEqual(networkSpy.invokedRequestCount, 1)
            XCTAssertNotNil(networkSpy.invokedRequestParameterRequest)
            XCTAssertEqual(players.count, 1)
        default:
            XCTFail("Expected to be success")
        }
    }

    func test_fetchPlayers_givenFailure_shouldCompleteError() {
        let failureStubbed: Result<[PlayerModel], Error> = .failure(ErrorDummy.error)
        networkSpy.stubbedRequestCompletionResult = failureStubbed

        var resultRequest: Result<[PlayerModel], Error>?

        sut.fetchPlayers(page: 2, teamId: 982) { result in
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

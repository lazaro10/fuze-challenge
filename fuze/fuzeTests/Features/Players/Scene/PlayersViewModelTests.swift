import XCTest
@testable import fuze

final class PlayersViewModelTests: XCTestCase {
    private let repositorySpy = PlayersRepositorySpy()
    private let converterSpy = PlayersConverterSpy()
    private let displaySpy = PlayersViewControllerDisplaySpy()

    private lazy var sut: PlayersViewModel = {
        let sut = PlayersViewModel(teamId: 263, alignment: .left, repository: repositorySpy, converter: converterSpy)
        sut.display = displaySpy

        return sut
    }()

    func test_fetchPlayers_shouldFetchPlayers() {
        sut.fetchPlayers()

        XCTAssertEqual(repositorySpy.invokedFetchPlayersCount, 1)
        XCTAssertEqual(repositorySpy.invokedFetchPlayersParameterPage, 1)
        XCTAssertEqual(repositorySpy.invokedFetchPlayersParameterTeamId, 263)
    }

    func test_fetchPlayers_givenSuccess_shouldDisplayPlayers() {
        repositorySpy.stubbedFetchPlayersCompletionResult = .success([.fixture()])

        sut.fetchPlayers()

        XCTAssertEqual(sut.players.count, 1)
        XCTAssertEqual(sut.page, 2)
        XCTAssertTrue(sut.isContinuePagination)
        XCTAssertEqual(displaySpy.invokedDisplayPlayersCount, 1)
    }

    func test_fetchPlayers_givenSuccess_givenPlayersIsEmpty_shouldNotifyPlayersAreFinished() {
        repositorySpy.stubbedFetchPlayersCompletionResult = .success([])

        sut.fetchPlayers()

        XCTAssertEqual(displaySpy.invokedNotifyPlayersAreFinishedCount, 1)
    }

    func test_fetchPlayers_givenFailure_shouldIsContinuePaginationFalse() {
        repositorySpy.stubbedFetchPlayersCompletionResult = .failure(ErrorDummy.error)

        sut.fetchPlayers()

        XCTAssertFalse(sut.isContinuePagination)
    }

    func test_fetchPlayers_givenFailure_shouldNotifyPlayersAreFinished() {
        repositorySpy.stubbedFetchPlayersCompletionResult = .failure(ErrorDummy.error)

        sut.fetchPlayers()

        XCTAssertEqual(displaySpy.invokedNotifyPlayersAreFinishedCount, 1)
    }

    func test_refreshPlayers_shouldSetInititalStateAndFetchPlayers() {
        sut.refreshPlayers()

        XCTAssertEqual(sut.page, 1)
        XCTAssertFalse(sut.isContinuePagination)
        XCTAssertEqual(sut.players.count, 0)
        XCTAssertEqual(repositorySpy.invokedFetchPlayersCount, 1)
    }

    func test_fetchMorePlayers_givenIsContinuePagination_shouldFetchPlayers() {
        sut.fetchMorePlayers()

        XCTAssertEqual(repositorySpy.invokedFetchPlayersCount, 1)
    }
}

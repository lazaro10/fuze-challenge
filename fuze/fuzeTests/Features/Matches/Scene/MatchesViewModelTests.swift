import XCTest
@testable import fuze

final class MatchesViewModelTests: XCTestCase {
    private let matchesRepositorySpy = MatchesRepositorySpy()
    private let displaySpy = MatchesViewControllerDisplaySpy()

    lazy var sut: MatchesViewModel = {
        let viewModel = MatchesViewModel(repository: matchesRepositorySpy)
        viewModel.display = displaySpy

        return viewModel
    }()

    func test_fetchMatches_givenRunningMatchesSuccess_givenMatchesIsEmpty_shouldShouldCallMatchesUpcome() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([])

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 1)
        XCTAssertFalse(sut.isContinueRunningPagination)
        XCTAssertEqual(sut.runningMachesPage, 2)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
    }

    func test_fetchMatches_givenRunningMatchesSuccess_givenHave10Matches_shouldDisplayContentState() {
        let matches = [MatchModel](repeating: .fixture(), count: 10)
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success(matches)

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 1)
        XCTAssertTrue(sut.isContinueRunningPagination)
        XCTAssertEqual(sut.runningMachesPage, 2)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)

        let viewModels = [MatchViewModel](repeating: .fixture(), count: 10)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .content(viewModels: viewModels))
    }

    func test_fetchMatches_givenRunningMatchesSuccess_giveHaveLessThan10Matches_shouldShouldCallMatchesUpcome() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([.fixture()])

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 1)
        XCTAssertFalse(sut.isContinueRunningPagination)
        XCTAssertEqual(sut.runningMachesPage, 2)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
    }

    func test_fetchMatches_givenFailure_shouldShouldCallMatchesUpcome() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 1)
        XCTAssertFalse(sut.isContinueRunningPagination)
        XCTAssertEqual(sut.runningMachesPage, 1)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
    }

    func test_fetchMatches_givenCallMatchesUpcome_givenSuccess_givenMatchesIsEmpty_shouldDisplayEmptyState() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([])
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success([])

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesParameterPage, 1)
        XCTAssertFalse(sut.isContinueUpcomePagination)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .empty)
    }

    func test_fetchMatches_givenCallMatchesUpcome_givenSuccess_shouldDisplayContentState() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([])
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success([.fixture()])

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesParameterPage, 1)
        XCTAssertFalse(sut.isContinueRunningPagination)
        XCTAssertTrue(sut.isContinueUpcomePagination)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .content(viewModels: [.fixture()]))
    }

    func test_fetchMatches_givenCallMatchesUpcome_givenFailure_givenMatchIsEmpry_shouldDisplayErrorState() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([])
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .failure(ErrorDummy.error)

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesParameterPage, 1)
        XCTAssertFalse(sut.isContinueRunningPagination)
        XCTAssertFalse(sut.isContinueUpcomePagination)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .error)
    }

    func test_fetchMoreMatches_givenIsContinueRunningPaginationTrue_shouldFetchRunningMatches() {
        let matches = [MatchModel](repeating: .fixture(), count: 10)
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success(matches)
        sut.fetchMatches()

        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([.fixture()])
        sut.fetchMoreMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 2)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 2)
    }

    func test_fetchMoreMatches_givenIsContinueRunningPaginationFalse_shouldFetchUpcomeMatches() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([])
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success([.fixture()])
        sut.fetchMatches()

        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success([.fixture()])
        sut.fetchMoreMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 2)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesParameterPage, 2)
    }
}

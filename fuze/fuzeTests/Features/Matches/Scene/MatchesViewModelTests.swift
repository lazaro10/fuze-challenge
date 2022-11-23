import XCTest
@testable import fuze

final class MatchesViewModelTests: XCTestCase {
    private let matchesRepositorySpy = MatchesRepositorySpy()
    private let displaySpy = MatchesViewControllerDisplaySpy()
    private let converterSpy = MatchesConverterSpy()

    lazy var sut: MatchesViewModel = {
        let viewModel = MatchesViewModel(repository: matchesRepositorySpy, converter: converterSpy)
        viewModel.display = displaySpy

        return viewModel
    }()

    func test_fetchMatches_shouldFetchRunningMatches() {
        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesParameterPage, 1)
    }

    func test_fetchMatches_givenRunningMatchesSuccess_shouldAddAPage() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([.fixture()])

        sut.fetchMatches()

        XCTAssertEqual(sut.runningMachesPage, 2)
    }

    func test_fetchMatches_givenRunningMatchesSuccess_givenMatchesLessThan10_shouldShouldCallMatchesUpcome() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success([])

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
    }

    func test_fetchMatches_givenRunningMatchesSuccess_givenMatchesEqualTo10_shouldDisplayContentState() {
        let matches = [MatchModel](repeating: .fixture(), count: 10)
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .success(matches)

        let viewModels = [MatchViewModel](repeating: .fixture(), count: 10)
        converterSpy.stubbedConvertResult = viewModels

        sut.fetchMatches()

        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .content(viewModels: viewModels))
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
        XCTAssertEqual(converterSpy.invokedConvertCount, 1)
        XCTAssertEqual(sut.matches.count, 10)
        XCTAssertTrue(sut.isContinueRunningPagination)
    }

    func test_fetchMatches_givenRunningMatchesFailure_shouldShouldCallMatchesUpcome() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
    }

    func test_fetchMatches_givenFetchUpcomeMatches_shouldFetchUpcomeMatches() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)

        sut.fetchMatches()

        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesCount, 1)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchUpcomingMatchesParameterPage, 1)
    }

    func test_fetchMatches_givenFetchUpcomeMatchesSuccess_shouldAddAPage() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success([.fixture()])

        sut.fetchMatches()

        XCTAssertEqual(sut.upcomeMachesPage, 2)
    }

    func test_fetchMatches_givenFetchUpcomeMatchesSuccessEmpty_givenMatchesLessThan10_shouldDisplayEmptyState() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success([])

        sut.fetchMatches()

        XCTAssertFalse(sut.isContinueUpcomePagination)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .empty)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
    }


    func test_fetchMatches_givenFetchUpcomeMatchesSuccess_givenMatchesEqualTo10_shouldDisplayContentState() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)

        let matches = [MatchModel](repeating: .fixture(), count: 10)
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .success(matches)

        let viewModels = [MatchViewModel](repeating: .fixture(), count: 10)
        converterSpy.stubbedConvertResult = viewModels

        sut.fetchMatches()

        XCTAssertTrue(sut.isContinueUpcomePagination)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .content(viewModels: viewModels))
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
        XCTAssertEqual(sut.matches.count, 10)
    }

    func test_fetchMatches_givenFetchUpcomeMatchesFailure_givenMatchesIsEmpty_shouldDisplayErrorState() {
        matchesRepositorySpy.stubbedFetchRunningMatchesCompletionResult = .failure(ErrorDummy.error)
        matchesRepositorySpy.stubbedFetchUpcomingMatchesCompletionResult = .failure(ErrorDummy.error)

        sut.fetchMatches()

        XCTAssertFalse(sut.isContinueUpcomePagination)
        XCTAssertEqual(displaySpy.invokedDisplayStateParameterState, .error)
        XCTAssertEqual(displaySpy.invokedDisplayStateCount, 2)
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
    }

    func test_refreshMatches_shouldSetInitialStateAndFetchRunningMatches() {
        sut.refreshMatches()

        XCTAssertEqual(sut.runningMachesPage, 1)
        XCTAssertTrue(sut.isContinueRunningPagination)
        XCTAssertEqual(sut.upcomeMachesPage, 1)
        XCTAssertTrue(sut.isContinueUpcomePagination)
        XCTAssertEqual(sut.matches.count, 0)
        XCTAssertEqual(matchesRepositorySpy.invokedFetchRunningMatchesCount, 1)
    }
}

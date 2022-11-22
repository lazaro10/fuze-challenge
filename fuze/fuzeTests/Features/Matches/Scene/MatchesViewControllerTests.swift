import XCTest
@testable import fuze

final class MatchesViewControllerTests: XCTestCase {
    let viewModelSpy = MatchesViewModeSpy()
    let contentViewSpy = MatchesViewSpy()
    let coordinatorSpy = MatchesCoordinatorSpy()

    lazy var sut = MatchesViewController(
        viewModel: viewModelSpy,
        contentView: contentViewSpy,
        coordinator: coordinatorSpy
    )

    func test_viewDidLoad_givenCalled_shouldSetDelegateAndFetchMatches() {
        sut.viewDidLoad()

        XCTAssertEqual(contentViewSpy.invokedDelegateSetterCount, 1)
        XCTAssertEqual(viewModelSpy.invokedFetchMatchesCount, 1)
    }

    func test_displayState_givenContentState_shouldChangeStateToContent() {
        sut.displayState(.content(viewModels: [.fixture()]))

        XCTAssertEqual(contentViewSpy.invokedChangeStateCount, 1)
        XCTAssertEqual(contentViewSpy.invokedChangeStateParameterState, .content(viewModels: [.fixture()]))
    }

    func test_displayState_givenLoadingState_shouldChangeStateToLoading() {
        sut.displayState(.loading)

        XCTAssertEqual(contentViewSpy.invokedChangeStateCount, 1)
        XCTAssertEqual(contentViewSpy.invokedChangeStateParameterState, .loading)
    }

    func test_displayState_givenEmptyState_shouldChangeStateToEmpty() {
        sut.displayState(.empty)

        XCTAssertEqual(contentViewSpy.invokedChangeStateCount, 1)
        XCTAssertEqual(contentViewSpy.invokedChangeStateParameterState, .empty)
    }

    func test_displayState_givenErrorState_shouldChangeStateToError() {
        sut.displayState(.error)

        XCTAssertEqual(contentViewSpy.invokedChangeStateCount, 1)
        XCTAssertEqual(contentViewSpy.invokedChangeStateParameterState, .error)
    }

    func test_matchesViewDidSelectMatch_whenCalled_shouldShowMatchDetail() {
        sut.matchesViewDidSelectMatch(viewModel: .fixture())

        XCTAssertEqual(coordinatorSpy.invokedShowMatchDetailCount, 1)
        XCTAssertEqual(coordinatorSpy.invokedShowMatchDetailParameterViewModel?.id, 20)
    }

    func test_matchesViewDidScrollEnded_whenCalled_shouldFetchMoreMatches() {
        sut.matchesViewDidScrollEnded()

        XCTAssertEqual(viewModelSpy.invokedFetchMoreMatchesCount, 1)
    }

    func test_matchesViewDidPullToRefresh_whenCalled_shouldRefreshMatches() {
        sut.matchesViewDidPullToRefresh()

        XCTAssertEqual(viewModelSpy.invokedRefreshMatchesCount, 1)
    }
}

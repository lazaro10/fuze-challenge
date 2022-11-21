import XCTest
@testable import fuze

final class MatchesViewControllerTests: XCTestCase {
    let viewModelSpy = MatchesViewModeSpy()
    let contentViewSpy = MatchesViewSpy()

    lazy var sut = MatchesViewController(viewModel: viewModelSpy, contentView: contentViewSpy)

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

    func test_matchesViewDidTableViewScrollEnded_givenCalled_shouldFetchMoreMatches() {
        sut.matchesViewDidTableViewScrollEnded()

        XCTAssertEqual(viewModelSpy.invokedFetchMoreMatchesCount, 1)
    }
}

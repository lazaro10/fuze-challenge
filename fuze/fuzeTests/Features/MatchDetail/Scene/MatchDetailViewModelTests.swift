import XCTest
@testable import fuze

final class MatchDetailViewModelTests: XCTestCase {
    private let displaySpy = MatchDetailViewControllerDisplaySpy()

    lazy var sut: MatchDetailViewModel = {
        let view = MatchDetailViewModel(matchViewModel: .fixture())
        view.display = displaySpy

        return view
    }()

    func test_prepareLayout_shouldDisplayMatch() {
        displaySpy.displayMatch(.fixture())

        XCTAssertEqual(displaySpy.invokedDisplayMatchCount, 1)
        XCTAssertEqual(displaySpy.invokedDisplayMatchParameterViewModel, .fixture())
    }
}


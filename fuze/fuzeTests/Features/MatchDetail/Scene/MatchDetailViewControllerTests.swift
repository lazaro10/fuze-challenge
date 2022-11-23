import XCTest
@testable import fuze

final class MatchDetailViewControllerTests: XCTestCase {
    private let viewModelSpy = MatchDetailViewModelSpy()
    private let contentViewSpy = MatchDetailViewSpy()

    private lazy var sut = MatchDetailViewController(viewModel: viewModelSpy, contentView: contentViewSpy)

    func test_viewDidLoad_whenCalled_shouldPrepareLayout() {
        sut.viewDidLoad()

        XCTAssertEqual(viewModelSpy.invokedPrepareLayoutCount, 1)
    }

    func test_displayMatch_whenCalled_shouldSetMatchInView() {
        sut.displayMatch(.fixture())

        XCTAssertEqual(contentViewSpy.invokedSetMatchCount, 1)
    }
}

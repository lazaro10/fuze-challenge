import XCTest
@testable import fuze

final class MatchesCoordinatorTests: XCTestCase {
    private let nagivationControllerSpy = NavigationControllerSpy()
    private lazy var sut = MatchesCoordinator(navigationController: nagivationControllerSpy)

    func test_start_whenCalled_shouldSetupNavigationController() {
        sut.start()

        XCTAssertTrue(nagivationControllerSpy.navigationBar.prefersLargeTitles)
        XCTAssertNotNil(nagivationControllerSpy.navigationBar.backgroundImage(for: .default))
        XCTAssertNotNil(nagivationControllerSpy.navigationBar.shadowImage)
        XCTAssertEqual(nagivationControllerSpy.navigationBar.tintColor, .primaryWhite)
    }

    func test_start_whenCalled_shouldPushMatchesViewController() {
        var expectedViewController: UIViewController?
        nagivationControllerSpy.pushViewControllerHandler = { viewController in
            expectedViewController = viewController
        }

        sut.start()

        XCTAssertTrue(expectedViewController is MatchesViewController)
    }

    func test_showMatchDetail_whenCalled_shouldPushMatchDetail() {
        var expectedViewController: UIViewController?
        nagivationControllerSpy.pushViewControllerHandler = { viewController in
            expectedViewController = viewController
        }

        sut.showMatchDetail(matchViewModel: .fixture())

        XCTAssertTrue(expectedViewController is MatchDetailViewController)
    }
}

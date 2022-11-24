import iOSSnapshotTestCase
@testable import fuze

final class MatchesViewSnapshotTests: FBSnapshotTestCase {
    private let sut = MatchesView()

    override func setUp() {
        super.setUp()

        recordMode = false
    }

    func test_view_givenStateContent_shouldCorrectLayout() {

        var viewModels = [MatchViewModel](repeating: .fixture(matchTime: "NOW", matchTimeViewColor: .primaryRed), count: 2)
        viewModels.append(contentsOf: [.fixture(), .fixture()])

        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.content(viewModels: viewModels))
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }

    func test_view_givenStateLoading_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.loading)
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }

    func test_view_givenStateEmpty_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.empty)
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }

    func test_view_givenStateIsError_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.error)
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }
}

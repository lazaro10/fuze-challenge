import iOSSnapshotTestCase
@testable import fuze

final class MatchDetailViewSnapshotTests: FBSnapshotTestCase {
    private let sut = MatchDetailView()

    override func setUp() {
        super.setUp()

        recordMode = false
    }

    func test_view_defaultState_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut)

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }

    func test_view_givenSetMatch_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.setMatch(.fixture())
            self.sut.changeState(.content)
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }
}

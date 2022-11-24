import iOSSnapshotTestCase
@testable import fuze

final class PlayersViewSnapshotTests: FBSnapshotTestCase {
    private let sut = PlayersView()

    override func setUp() {
        super.setUp()

        recordMode = false
    }

    func test_view_givenAlignmentLeft_shouldCorrectLayout() {
        let viewModels = [PlayerViewModel](repeating: .fixture(alignment: .left), count: 5)

        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.updatePlayers(viewModels: viewModels)
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }

    func test_view_givenAlignmentRight_shouldCorrectLayout() {
        let viewModels = [PlayerViewModel](repeating: .fixture(alignment: .right), count: 5)

        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.updatePlayers(viewModels: viewModels)
        }

        viewControllerSnapshot.viewDidLoad()
        FBSnapshotVerifyView(sut)
    }
}


import SnapshotTesting
import XCTest
@testable import fuze

final class PlayersViewSnapshotTests: XCTestCase {
    private let sut = PlayersView()

    override func setUp() {
        super.setUp()

        isRecording = false
    }

    func test_view_givenAlignmentLeft_shouldCorrectLayout() {
        let viewModels = [PlayerViewModel](repeating: .fixture(alignment: .left), count: 5)

        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.updatePlayers(viewModels: viewModels)
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }

    func test_view_givenAlignmentRight_shouldCorrectLayout() {
        let viewModels = [PlayerViewModel](repeating: .fixture(alignment: .right), count: 5)

        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.updatePlayers(viewModels: viewModels)
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }
}


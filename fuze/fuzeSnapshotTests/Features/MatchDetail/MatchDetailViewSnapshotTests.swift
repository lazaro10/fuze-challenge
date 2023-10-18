import SnapshotTesting
import XCTest
@testable import fuze

final class MatchDetailViewSnapshotTests: XCTestCase {
    private let sut = MatchDetailView()

    override func setUp() {
        super.setUp()

        isRecording = true
    }

    func test_view_defaultState_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut)

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }

    func test_view_givenSetMatch_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.setMatch(.fixture())
            self.sut.changeState(.content)
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }
}

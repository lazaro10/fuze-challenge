import SnapshotTesting
import XCTest
@testable import fuze

final class MatchesViewSnapshotTests: XCTestCase {
    private let sut = MatchesView()

    override func setUp() {
        super.setUp()
        
        isRecording = false
    }

    func test_view_givenStateContent_shouldCorrectLayout() {
        var viewModels = [MatchViewModel](repeating: .fixture(matchTime: "NOW", matchTimeViewColor: .primaryRed), count: 2)
        viewModels.append(contentsOf: [.fixture(), .fixture()])

        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.content(viewModels: viewModels))
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }

    func test_view_givenStateLoading_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.loading)
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }

    func test_view_givenStateEmpty_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.empty)
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }

    func test_view_givenStateIsError_shouldCorrectLayout() {
        let viewControllerSnapshot = ViewControllerSnapshot(customView: sut) {
            self.sut.changeState(.error)
        }

        assertSnapshots(of: viewControllerSnapshot, as: [.image])
    }
}

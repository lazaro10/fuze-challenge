import XCTest
@testable import fuze

final class PlayersViewControllerTests: XCTestCase {
    private let viewModelSpy = PlayersViewModelSpy()
    private let contentViewSpy = PlayersViewSpy()

    private lazy var sut = PlayersViewController(viewModel: viewModelSpy, contentView: contentViewSpy)

    override func setUp() {
        super.setUp()

        DispatchQueueTestingOverrides.overriddenAsyncHandler = { function in
            function()
        }
    }

    func test_viewDidLoad_whenCalled_shouldSetDelegateAndFetchPlayers() {
        sut.viewDidLoad()

        XCTAssertEqual(contentViewSpy.invokedDelegateSetterCount, 1)
        XCTAssertEqual(viewModelSpy.invokedFetchPlayersCount, 1)
    }

    func test_displayPlayers_whenCalled_shouldUpdatePlayersAndLoadedPlayersHandle() {
        sut.displayPlayers([.fixture()])

        XCTAssertEqual(contentViewSpy.invokedUpdatePlayersCount, 1)
    }

    func test_notifyPlayersAreFinished_whenCalled_shouldPlayersAreFinished() {
        sut.notifyPlayersAreFinished()

        XCTAssertEqual(contentViewSpy.invokedPlayersAreFinishedCount, 1)
    }

    func test_playersViewDidScrollEnded_whenCalled_shouldFetchMorePlayers() {
        sut.playersViewDidScrollEnded()

        XCTAssertEqual(viewModelSpy.invokedFetchMorePlayersCount, 1)
    }

    func test_playersViewDidPullToRefresh_whenCalled_shouldRefreshPlayers() {
        sut.playersViewDidPullToRefresh()

        XCTAssertEqual(viewModelSpy.invokedRefreshPlayersCount, 1)
    }
}

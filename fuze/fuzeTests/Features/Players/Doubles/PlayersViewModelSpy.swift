@testable import fuze
import Foundation

final class PlayersViewModelSpy: PlayersViewModelLogic {
    private(set) var invokedFetchPlayersCount = 0

    func fetchPlayers() {
        invokedFetchPlayersCount += 1
    }

    private(set) var invokedRefreshPlayersCount = 0

    func refreshPlayers() {
        invokedRefreshPlayersCount += 1
    }

    private(set) var invokedFetchMorePlayersCount = 0

    func fetchMorePlayers() {
        invokedFetchMorePlayersCount += 1
    }
}

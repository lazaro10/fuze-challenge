@testable import fuze
import Foundation

final class PlayersViewControllerDisplaySpy: PlayersViewControllerDisplayble {
    private(set) var invokedDisplayPlayersCount = 0
    private(set) var invokedDisplayPlayersParameterViewModels: [PlayerViewModel] = []

    func displayPlayers(_ viewModels: [PlayerViewModel]) {
        invokedDisplayPlayersCount += 1
        invokedDisplayPlayersParameterViewModels = viewModels
    }

    private(set) var invokedNotifyPlayersAreFinishedCount = 0

    func notifyPlayersAreFinished() {
        invokedNotifyPlayersAreFinishedCount += 1
    }
}

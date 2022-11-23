@testable import fuze
import Foundation
import UIKit

final class PlayersViewSpy: UIView, PlayersViewProtocol {
    private(set) var invokedDelegateSetterCount = 0
    private(set) var invokedDelegate: PlayersViewDelegate?
    private(set) var invokedDelegateGetterCount = 0
    var stubbedDelegate: PlayersViewDelegate?

    var delegate: PlayersViewDelegate? {
        get {
            invokedDelegateGetterCount += 1
            return stubbedDelegate
        }
        set {
            invokedDelegateSetterCount += 1
            invokedDelegate = newValue
        }
    }

    private(set) var invokedUpdatePlayersCount = 0
    private(set) var invokedUpdatePlayersParameterViewModels: [PlayerViewModel] = []

    func updatePlayers(viewModels: [PlayerViewModel]) {
        invokedUpdatePlayersCount += 1
        invokedUpdatePlayersParameterViewModels = viewModels
    }

    private(set) var invokedPlayersAreFinishedCount = 0

    func playersAreFinished() {
        invokedPlayersAreFinishedCount += 1
    }
}

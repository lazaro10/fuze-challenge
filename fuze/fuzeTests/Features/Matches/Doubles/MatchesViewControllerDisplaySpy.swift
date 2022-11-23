@testable import fuze
import Foundation

final class MatchesViewControllerDisplaySpy: MatchesViewControllerDisplayble {
    private(set) var invokedDisplayStateCount = 0
    private(set) var invokedDisplayStateParameterState: MatchesView.State?

    func displayState(_ state: MatchesView.State) {
        invokedDisplayStateCount += 1
        invokedDisplayStateParameterState = state
    }

    private(set) var invokedNotifyPlayersAreFinishedCount = 0

    func notifyPlayersAreFinished() {
        invokedNotifyPlayersAreFinishedCount += 1
    }

    private(set) var invokedDisplayMatchDetailCount = 0
    private(set) var invokedDisplayMatchDetailParameterMatchViewModel: MatchViewModel?

    func displayMatchDetail(matchViewModel: MatchViewModel) {
        invokedDisplayMatchDetailCount += 1
        invokedDisplayMatchDetailParameterMatchViewModel = matchViewModel
    }
}

extension MatchesView.State: Equatable {
    public static func == (lhs: MatchesView.State, rhs: MatchesView.State) -> Bool {
        switch (lhs, rhs) {
        case let (.content(lhsViewModels), .content(rhsViewModels)):
            return lhsViewModels.first?.id == rhsViewModels.first?.id &&
            lhsViewModels.last?.id == rhsViewModels.last?.id &&
            lhsViewModels.count == rhsViewModels.count
        default:
            return true
        }
    }
}

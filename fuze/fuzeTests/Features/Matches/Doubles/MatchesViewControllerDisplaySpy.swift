@testable import fuze
import Foundation

final class MatchesViewControllerDisplaySpy: MatchesViewControllerDisplayble {
    var invokedDisplayStateCount = 0
    var invokedDisplayStateParameterState: MatchesView.State?

    func displayState(_ state: MatchesView.State) {
        invokedDisplayStateCount += 1
        invokedDisplayStateParameterState = state
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

@testable import fuze
import Foundation

final class MatchDetailViewControllerDisplaySpy: MatchDetailViewControllerDisplayble {
    private(set) var invokedDisplayMatchCount = 0
    private(set) var invokedDisplayMatchParameterViewModel: MatchViewModel?

    func displayMatch(_ viewModel: MatchViewModel) {
        invokedDisplayMatchCount += 1
        invokedDisplayMatchParameterViewModel = viewModel
    }
}

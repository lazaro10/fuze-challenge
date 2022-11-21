@testable import fuze
import Foundation

final class MatchesCoordinatorSpy: MatchesCoordinatorLogic {
    private(set) var invokedShowMatchDetailCount = 0
    private(set) var invokedShowMatchDetailParameterViewModel: MatchViewModel?

    func showMatchDetail(viewModel: MatchViewModel) {
        invokedShowMatchDetailCount += 1
        invokedShowMatchDetailParameterViewModel = viewModel
    }
}

@testable import fuze
import Foundation

final class MatchesCoordinatorSpy: MatchesCoordinating {
    private(set) var invokedShowMatchDetailCount = 0
    private(set) var invokedShowMatchDetailParameterMatchViewModel: MatchViewModel?

    func showMatchDetail(matchViewModel: MatchViewModel) {
        invokedShowMatchDetailCount += 1
        invokedShowMatchDetailParameterMatchViewModel = matchViewModel
    }
}

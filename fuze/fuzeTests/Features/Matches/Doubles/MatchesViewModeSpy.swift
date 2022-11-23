@testable import fuze
import Foundation

final class MatchesViewModeSpy: MatchesViewModelLogic {
    private(set) var invokedFetchMatchesCount = 0

    func fetchMatches() {
        invokedFetchMatchesCount += 1
    }

    private(set) var invokedFetchMoreMatchesCount = 0

    func fetchMoreMatches() {
        invokedFetchMoreMatchesCount += 1
    }

    private(set) var invokedRefreshMatchesCount = 0

    func refreshMatches() {
        invokedRefreshMatchesCount += 1
    }

    var invokedSelectMatchCount = 0
    var invokedSelectMatchParameterIndex: Int?

    func selectMatch(index: Int) {
        invokedSelectMatchCount += 1
        invokedSelectMatchParameterIndex = index
    }
}

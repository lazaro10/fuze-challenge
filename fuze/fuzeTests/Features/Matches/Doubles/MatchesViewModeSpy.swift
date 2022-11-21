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
}

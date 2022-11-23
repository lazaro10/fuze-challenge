@testable import fuze
import Foundation

final class MatchDetailViewModelSpy: MatchDetailViewModelLogic {
    private(set) var invokedPrepareLayoutCount = 0

    func prepareLayout() {
        invokedPrepareLayoutCount += 1
    }
}

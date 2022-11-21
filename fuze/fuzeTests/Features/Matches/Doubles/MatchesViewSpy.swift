@testable import fuze
import UIKit
import Foundation

final class MatchesViewSpy: UIView, MatchesViewLogic {
    private(set) var invokedDelegateSetterCount = 0
    private(set) var invokedDelegate: MatchesViewDelegate?
    private(set) var invokedDelegateGetterCount = 0
    var stubbedDelegate: MatchesViewDelegate?

    var delegate: MatchesViewDelegate? {
        get {
            invokedDelegateGetterCount += 1
            return stubbedDelegate
        }

        set {
            invokedDelegateSetterCount += 1
            invokedDelegate = newValue
        }
    }

    private(set) var invokedChangeStateCount = 0
    private(set) var invokedChangeStateParameterState: MatchesView.State?

    func changeState(_ state: MatchesView.State) {
        invokedChangeStateCount += 1
        invokedChangeStateParameterState = state
    }
}

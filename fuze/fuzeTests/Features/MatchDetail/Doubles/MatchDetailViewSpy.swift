@testable import fuze
import Foundation
import UIKit

final class MatchDetailViewSpy: UIView, MatchDetailViewLogic {
    private(set) var invokedSetMatchCount = 0
    private(set) var invokedSetMatchParameterViewModel: MatchViewModel?

    func setMatch(_ viewModel: MatchViewModel) {
        invokedSetMatchCount += 1
        invokedSetMatchParameterViewModel = viewModel
    }
}

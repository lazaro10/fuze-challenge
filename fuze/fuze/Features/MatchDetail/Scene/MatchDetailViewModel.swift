protocol MatchDetailViewModelLogic {
    func prepareLayout()
}

final class MatchDetailViewModel {
    weak var display: MatchDetailViewControllerDisplayble?

    private let matchViewModel: MatchViewModel

    init(matchViewModel: MatchViewModel) {
        self.matchViewModel = matchViewModel
    }
}

extension MatchDetailViewModel: MatchDetailViewModelLogic {
    func prepareLayout() {
        display?.displayMatch(matchViewModel)
    }
}

import UIKit

protocol MatchesViewControllerDisplayble: AnyObject {
    func displayState(_ state: MatchesView.State)
    func displayMatchDetail(matchViewModel: MatchViewModel)
}

final class MatchesViewController: UIViewController {
    private let viewModel: MatchesViewModelLogic
    private let contentView: MatchesViewLogic
    private let coordinator: MatchesCoordinatorLogic

    init(
        viewModel: MatchesViewModelLogic,
        contentView: MatchesViewLogic,
        coordinator: MatchesCoordinatorLogic
    ) {
        self.viewModel = viewModel
        self.contentView = contentView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.matches
        contentView.delegate = self
        viewModel.fetchMatches()
    }
}

extension MatchesViewController: MatchesViewControllerDisplayble {
    func displayState(_ state: MatchesView.State) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.changeState(state)
        }
    }

    func displayMatchDetail(matchViewModel: MatchViewModel) {
        coordinator.showMatchDetail(matchViewModel: matchViewModel)
    }
}

extension MatchesViewController: MatchesViewDelegate {
    func matchesViewDidSelectMatch(index: Int) {
        viewModel.selectMatch(index: index)
    }

    func matchesViewDidScrollEnded() {
        viewModel.fetchMoreMatches()
    }

    func matchesViewDidPullToRefresh() {
        viewModel.refreshMatches()
    }
}

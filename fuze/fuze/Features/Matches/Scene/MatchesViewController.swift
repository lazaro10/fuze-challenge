import UIKit

protocol MatchesViewControllerDisplayble: AnyObject {
    func displayState(_ state: MatchesView.State)
    func notifyPlayersAreFinished()
    func displayMatchDetail(matchViewModel: MatchViewModel)
}

final class MatchesViewController: UIViewController {
    private let viewModel: MatchesViewModelLogic
    private let contentView: MatchesViewProtocol
    private let coordinator: MatchesCoordinating

    init(
        viewModel: MatchesViewModelLogic,
        contentView: MatchesViewProtocol,
        coordinator: MatchesCoordinating
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

        contentView.delegate = self
        viewModel.fetchMatches()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = Strings.matches
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        title = ""
    }
}

extension MatchesViewController: MatchesViewControllerDisplayble {
    func displayState(_ state: MatchesView.State) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.changeState(state)
        }
    }

    func notifyPlayersAreFinished() {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.matchesAreFinished()
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

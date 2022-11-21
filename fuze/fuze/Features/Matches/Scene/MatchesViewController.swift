import UIKit

protocol MatchesViewControllerDisplayble: AnyObject {
    func displayState(_ state: MatchesView.State)
}

final class MatchesViewController: UIViewController {
    private let viewModel: MatchesViewModelLogic
    private let contentView: MatchesViewLogic

    init(viewModel: MatchesViewModelLogic, contentView: MatchesViewLogic) {
        self.viewModel = viewModel
        self.contentView = contentView
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
}

extension MatchesViewController: MatchesViewControllerDisplayble {
    func displayState(_ state: MatchesView.State) {
        contentView.changeState(state)
    }
}

extension MatchesViewController: MatchesViewDelegate {
    func matchesViewDidTableViewScrollEnded() {
        viewModel.fetchMoreMatches()
    }
}

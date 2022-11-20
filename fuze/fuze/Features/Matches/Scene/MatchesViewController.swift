import UIKit

protocol MatchesViewControllerDisplayble: AnyObject {
    func displayMatchViewModels(viewModels: [MatchViewModel])
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

        viewModel.fetchMatches()
    }
}

extension MatchesViewController: MatchesViewControllerDisplayble {
    func displayMatchViewModels(viewModels: [MatchViewModel]) {
        contentView.matchViewModels = viewModels
    }
}

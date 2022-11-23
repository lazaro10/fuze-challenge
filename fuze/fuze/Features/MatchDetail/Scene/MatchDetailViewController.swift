import UIKit

protocol MatchDetailViewControllerDisplayble: AnyObject {
    func displayMatch(_ viewModel: MatchViewModel)
}

final class MatchDetailViewController: UIViewController {
    private let viewModel: MatchDetailViewModelLogic
    private let contentView: MatchDetailViewLogic

    init(viewModel: MatchDetailViewModelLogic, contentView: MatchDetailViewLogic) {
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

        viewModel.prepareLayout()
    }
}

extension MatchDetailViewController: MatchDetailViewControllerDisplayble {
    func displayMatch(_ viewModel: MatchViewModel) {
        contentView.setMatch(viewModel)
    }
}

import UIKit

protocol PlayersViewControllerDisplayble: AnyObject {
    func displayPlayers(_ viewModels: [PlayerViewModel])
}

final class PlayersViewController: UIViewController {
    private let viewModel: PlayersViewModelLogic
    private let contentView: PlayersViewLogic

    init(viewModel: PlayersViewModelLogic, contentView: PlayersViewLogic) {
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
        viewModel.fetchPlayers()
    }
}

extension PlayersViewController: PlayersViewControllerDisplayble {
    func displayPlayers(_ viewModels: [PlayerViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.updatePlayers(viewModels: viewModels)
        }
    }
}

extension PlayersViewController: PlayersViewDelegate {
    func playersViewDidScrollEnded() {
        viewModel.fetchMorePlayers()
    }

    func playersViewDidPullToRefresh() {
        viewModel.refreshPlayers()
    }
}

import UIKit

final class MatchDetailViewController: UIViewController {
    private let contentView: MatchDetailViewLogic
    private let coordinator: MatchesCoordinatorLogic
    private let viewModel: MatchViewModel

    init(
        contentView: MatchDetailViewLogic,
        coordinator: MatchesCoordinatorLogic,
        viewModel: MatchViewModel
    ) {
        self.contentView = contentView
        self.coordinator = coordinator
        self.viewModel = viewModel
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
        let left = PlayersViewModel(imageURL: nil, nickname: "Artorias", name: "Lázaro", side: .left)
        let right = PlayersViewModel(imageURL: nil, nickname: "Artorias", name: "Lázaro", side: .right)
        contentView.changeState(.content(
            matchViewModel: viewModel,
            leftPlayersViewModels: [left, left, left, left, left, left],
            rightPlayersViewModels: [right, right, right, right, right])
        )
    }
}

import UIKit

final class MatchDetailViewController: UIViewController {
    private let contentView: MatchDetailViewLogic
    private let viewModel: MatchViewModel

    init(
        contentView: MatchDetailViewLogic,
        viewModel: MatchViewModel
    ) {
        self.contentView = contentView
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

    }
}

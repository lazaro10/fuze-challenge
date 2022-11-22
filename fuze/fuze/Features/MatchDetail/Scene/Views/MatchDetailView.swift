import UIKit

protocol MatchDetailViewLogic: UIView {
    func changeState(_ state: MatchDetailView.State)
}

final class MatchDetailView: UIView {
    enum State {
        case content(matchViewModel: MatchViewModel, leftPlayersViewModels: [PlayersViewModel], rightPlayersViewModels: [PlayersViewModel])
        case loading
    }

    private let headerView = MatchDetailHeaderView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 13
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    }()

    private let loadingView = LoadingView()

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(headerView, constraints: [
            headerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: -24),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension MatchDetailView: MatchDetailViewLogic {
    func changeState(_ state: State) {
        switch state {
        case let .content(matchViewModel, leftPlayersViewModels, rightPlayersViewModels):
            headerView.isHidden = false
            loadingView.isHidden = true
            headerView.setup(viewModel: matchViewModel)
        case .loading:
            headerView.isHidden = true
            loadingView.isHidden = false
        }
    }
}

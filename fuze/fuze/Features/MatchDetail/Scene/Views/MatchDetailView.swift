import UIKit

protocol MatchDetailViewLogic: UIView {
    func setMatch(_ viewModel: MatchViewModel)
}

final class MatchDetailView: UIView {
    private enum State {
        case content
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
        changeState(.loading)
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

        addSubview(loadingView, constraints: [
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }

    private func changeState(_ state: State) {
        switch state {
        case .content:
            headerView.isHidden = false
            stackView.isHidden = false
            loadingView.isHidden = true
        case .loading:
            headerView.isHidden = true
            stackView.isHidden = true
            loadingView.isHidden = false
        }
    }
}

extension MatchDetailView: MatchDetailViewLogic {
    func setMatch(_ viewModel: MatchViewModel) {
        headerView.setup(viewModel: viewModel)

        let leftPlayersViewController = PlayersBuilder.build(teamId: viewModel.confrontationViewModel.leftOpponentId, alignment: .left)
        let rightPlayersViewController = PlayersBuilder.build(teamId: viewModel.confrontationViewModel.rightOpponentId, alignment: .right)

        stackView.addArrangedSubview(leftPlayersViewController.view)
        stackView.addArrangedSubview(rightPlayersViewController.view)

        rightPlayersViewController.loadedPlayersHandle = { [weak self] in
            self?.changeState(.content)
        }
    }
}

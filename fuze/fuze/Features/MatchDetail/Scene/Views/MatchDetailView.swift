import UIKit

protocol MatchDetailViewLogic: UIView {
    func changeState(_ state: MatchDetailView.State)
}

final class MatchDetailView: UIView {
    enum State {
        case content(matchViewModel: MatchViewModel, playersViewModels: [PlayersViewModel])
        case loading
    }

    private var playersViewModels: [PlayersViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let headerView = MatchDetailHeaderView()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerReusableCell(PlayersTableViewCell.self)
        tableView.backgroundColor = .primaryBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self

        return tableView
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

        addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension MatchDetailView: MatchDetailViewLogic {
    func changeState(_ state: State) {
        switch state {
        case let .content(matchViewModel, playersViewModels):
            headerView.isHidden = false
            tableView.isHidden = false
            loadingView.isHidden = true
            headerView.setup(viewModel: matchViewModel)
            self.playersViewModels = playersViewModels
        case .loading:
            headerView.isHidden = true
            tableView.isHidden = true
            loadingView.isHidden = false
        }
    }
}

extension MatchDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playersViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchTableViewCell: PlayersTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        matchTableViewCell.setup(playersViewModels[indexPath.row])

        return matchTableViewCell
    }
}

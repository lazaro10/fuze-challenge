import UIKit

protocol PlayersViewLogic: UIView {
    var delegate: PlayersViewDelegate? { get set }
    func updatePlayers(viewModels: [PlayerViewModel])
}

protocol PlayersViewDelegate: AnyObject {
    func playersViewDidScrollEnded()
    func playersViewDidPullToRefresh()
}

final class PlayersView: UIView {
    private var playerViewModels: [PlayerViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerReusableCell(PlayerTableViewCell.self)
        tableView.backgroundColor = .primaryBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self

        return tableView
    }()

    var delegate: PlayersViewDelegate?

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension PlayersView: PlayersViewLogic {
    func updatePlayers(viewModels: [PlayerViewModel]) {
        playerViewModels = viewModels
    }
}

extension PlayersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerTableViewCell: PlayerTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        playerTableViewCell.setup(playerViewModels[indexPath.row])

        return playerTableViewCell
    }
}

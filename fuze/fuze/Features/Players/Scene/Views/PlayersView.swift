import UIKit

protocol PlayersViewLogic: UIView {
    var delegate: PlayersViewDelegate? { get set }
    func updatePlayers(viewModels: [PlayerViewModel])
    func playersAreFinished()
}

protocol PlayersViewDelegate: AnyObject {
    func playersViewDidScrollEnded()
    func playersViewDidPullToRefresh()
}

final class PlayersView: UIView {
    private lazy var tableViewProvider = PageableTableViewProvider<PlayerTableViewCell, PlayerViewModel>(tableView: tableView, delegate: self)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .primaryBackground
        
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
        tableViewProvider.viewModels = viewModels
    }

    func playersAreFinished() {
        tableViewProvider.isPaginationFinished = true
    }
}

extension PlayersView: TableViewProviderDelegate {
    func tableViewProviderDidScrollEnded() {
        delegate?.playersViewDidScrollEnded()
    }

    func tableViewProviderDidPullToRefresh() {
        delegate?.playersViewDidPullToRefresh()
    }
}

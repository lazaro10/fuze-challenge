import UIKit

protocol MatchesTableViewDataSourceDelegate: AnyObject {
    func matchesTableViewDidSelectMatch(viewModel: MatchViewModel)
    func matchesTableViewDidScrollEnded()
    func matchesTableViewDidPullToRefresh()
}

final class MatchesTableViewDataSource: NSObject {
    var matchViewModels: [MatchViewModel] = [] {
        didSet {
            refreshControl.endRefreshing()
            tableView?.reloadData()
        }
    }

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        return refreshControl
    }()

    private weak var tableView: UITableView?
    private weak var delegate: MatchesTableViewDataSourceDelegate?

    init(tableView: UITableView, delegate: MatchesTableViewDataSourceDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()

        setupTableView()
    }

    private func setupTableView() {
        tableView?.registerReusableCell(MatchTableViewCell.self)
        tableView?.backgroundColor = .primaryBackground
        tableView?.separatorStyle = .none
        tableView?.refreshControl = refreshControl
        tableView?.delegate = self
        tableView?.dataSource = self
    }

    @objc private func refresh() {
        delegate?.matchesTableViewDidPullToRefresh()
    }
}

extension MatchesTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.matchesTableViewDidSelectMatch(viewModel: matchViewModels[indexPath.row])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard offsetY > 0, let tableViewHeight = tableView?.contentSize.height else { return }

        let contentSize = tableViewHeight  - 50
        let scrollHeight = scrollView.frame.size.height

        if offsetY > contentSize - scrollHeight {
            delegate?.matchesTableViewDidScrollEnded()
        }
    }
}

extension MatchesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matchViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchTableViewCell: MatchTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let viewModel = matchViewModels[indexPath.row]
        matchTableViewCell.setup(viewModel)

        return matchTableViewCell
    }
}

import UIKit

protocol MatchesTableViewDataSourceDelegate: AnyObject {
    func matchesTableViewDidSelectMatch(index: Int)
    func matchesTableViewDidScrollEnded()
    func matchesTableViewDidPullToRefresh()
}

final class MatchesTableViewDataSource: NSObject {
    var matchViewModels: [MatchViewModel] = [] {
        didSet {
            pullRefreshControl.endRefreshing()
            hideFooterActivityIndicatorView()
            tableView?.reloadData()
        }
    }

    private lazy var pullRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        return refreshControl
    }()

    private lazy var footerActivityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.frame = CGRect(x: 0, y: 0, width: tableView?.bounds.width ?? 0, height: 44)

        return indicator
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
        tableView?.refreshControl = pullRefreshControl
        tableView?.tableFooterView = footerActivityIndicatorView
        tableView?.delegate = self
        tableView?.dataSource = self
    }

    @objc private func refresh() {
        delegate?.matchesTableViewDidPullToRefresh()
    }

    private func showFooterActivityIndicatorView() {
        footerActivityIndicatorView.startAnimating()
        footerActivityIndicatorView.isHidden = false
    }

    private func hideFooterActivityIndicatorView() {
        footerActivityIndicatorView.stopAnimating()
        footerActivityIndicatorView.isHidden = true
    }
}

extension MatchesTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.matchesTableViewDidSelectMatch(index: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard offsetY > 0, let tableViewHeight = tableView?.contentSize.height else { return }

        let contentSize = tableViewHeight  - 50
        let scrollHeight = scrollView.frame.size.height

        if offsetY > contentSize - scrollHeight {
            delegate?.matchesTableViewDidScrollEnded()
            showFooterActivityIndicatorView()
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

import UIKit

protocol TableViewProviderDelegate: AnyObject {
    func tableViewProviderDidSelectCell(index: Int)
    func tableViewProviderDidScrollEnded()
    func tableViewProviderDidPullToRefresh()
}

extension TableViewProviderDelegate {
    func tableViewProviderDidSelectCell(index: Int) {}
}

final class PageableTableViewProvider<TableViewCell: UITableViewCell, ViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource where TableViewCell: Reusable {

    var viewModels: [ViewModel] = [] {
        didSet {
            pullRefreshControl.endRefreshing()
            hideFooterActivityIndicatorView()
            tableView?.reloadData()
        }
    }

    var isPaginationFinished = false

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
    private weak var delegate: TableViewProviderDelegate?

    init(tableView: UITableView, delegate: TableViewProviderDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()

        setupTableView()
    }

    private func setupTableView() {
        tableView?.registerReusableCell(TableViewCell.self)
        tableView?.showsVerticalScrollIndicator = false
        tableView?.separatorStyle = .none
        tableView?.refreshControl = pullRefreshControl
        tableView?.tableFooterView = footerActivityIndicatorView
        tableView?.delegate = self
        tableView?.dataSource = self
    }

    @objc private func refresh() {
        delegate?.tableViewProviderDidPullToRefresh()
        isPaginationFinished = false
    }

    private func showFooterActivityIndicatorView() {
        footerActivityIndicatorView.startAnimating()
        footerActivityIndicatorView.isHidden = false
    }

    private func hideFooterActivityIndicatorView() {
        footerActivityIndicatorView.stopAnimating()
        footerActivityIndicatorView.isHidden = true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableViewProviderDidSelectCell(index: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard offsetY > 0, let tableViewHeight = tableView?.contentSize.height else { return }

        let contentSize = tableViewHeight  - 50
        let scrollHeight = scrollView.frame.size.height

        if offsetY > contentSize - scrollHeight && !isPaginationFinished {
            delegate?.tableViewProviderDidScrollEnded()
            showFooterActivityIndicatorView()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchTableViewCell: TableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let viewModel = viewModels[indexPath.row]
        matchTableViewCell.setup(viewModel)

        return matchTableViewCell
    }
}

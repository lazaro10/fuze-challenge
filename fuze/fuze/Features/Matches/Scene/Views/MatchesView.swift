import UIKit

protocol MatchesViewProtocol: UIView {
    var delegate: MatchesViewDelegate? { get set }
    func changeState(_ state: MatchesView.State)
    func matchesAreFinished()
}

protocol MatchesViewDelegate: AnyObject {
    func matchesViewDidSelectMatch(index: Int)
    func matchesViewDidScrollEnded()
    func matchesViewDidPullToRefresh()
}

final class MatchesView: UIView {
    enum State {
        case content(viewModels: [MatchViewModel])
        case loading
        case empty
        case error
    }


    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryBackground

        return view
    }()

    private lazy var tableViewProvider = PageableTableViewProvider<MatchTableViewCell, MatchViewModel>(tableView: tableView, delegate: self)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .primaryBackground

        return tableView
    }()
    
    private let loadinView = LoadingView()
    private let emptyStateView = EmptyStateView(message: Strings.matchNotFound)
    private let errorView = ErrorView(message: Strings.matchesNotLoaded)

    weak var delegate: MatchesViewDelegate?

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(topLineView, constraints: [
            topLineView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            topLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: topLineView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(loadinView, constraints: [
            loadinView.topAnchor.constraint(equalTo: topAnchor),
            loadinView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadinView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadinView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(emptyStateView, constraints: [
            emptyStateView.topAnchor.constraint(equalTo: topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(errorView, constraints: [
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension MatchesView: MatchesViewProtocol {
    func changeState(_ state: MatchesView.State) {
        switch state {
        case .content(let viewModels):
            tableView.isHidden = false
            loadinView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = true
            tableViewProvider.viewModels = viewModels
        case .loading:
            tableView.isHidden = true
            loadinView.isHidden = false
            emptyStateView.isHidden = true
            errorView.isHidden = true
        case .empty:
            tableView.isHidden = true
            loadinView.isHidden = true
            emptyStateView.isHidden = false
            errorView.isHidden = true
        case .error:
            tableView.isHidden = true
            loadinView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = false
        }
    }

    func matchesAreFinished() {
        tableViewProvider.isPaginationFinished = true
    }
}

extension MatchesView: TableViewProviderDelegate {
    func tableViewProviderDidSelectCell(index: Int) {
        delegate?.matchesViewDidSelectMatch(index: index)
    }

    func tableViewProviderDidScrollEnded() {
        delegate?.matchesViewDidScrollEnded()
    }

    func tableViewProviderDidPullToRefresh() {
        delegate?.matchesViewDidPullToRefresh()
    }
}

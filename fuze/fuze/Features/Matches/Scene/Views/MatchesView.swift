import UIKit

protocol MatchesViewLogic: UIView {
    func changeState(_ state: MatchesView.State)
    var delegate: MatchesViewDelegate? { get set }
}

protocol MatchesViewDelegate: AnyObject {
    func matchesViewDidSelectMatch(viewModel: MatchViewModel)
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

    private lazy var tableViewDataSource = MatchesTableViewDataSource(tableView: tableView, delegate: self)

    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryBackground

        return view
    }()

    private let tableView = UITableView()
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

extension MatchesView: MatchesViewLogic {
    func changeState(_ state: MatchesView.State) {
        switch state {
        case .content(let viewModels):
            tableView.isHidden = false
            loadinView.isHidden = true
            emptyStateView.isHidden = true
            errorView.isHidden = true
            tableViewDataSource.matchViewModels = viewModels
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
}

extension MatchesView: MatchesTableViewDataSourceDelegate {
    func matchesTableViewDidSelectMatch(viewModel: MatchViewModel) {
        delegate?.matchesViewDidSelectMatch(viewModel: viewModel)
    }

    func matchesTableViewDidScrollEnded() {
        delegate?.matchesViewDidScrollEnded()
    }

    func matchesTableViewDidPullToRefresh() {
        delegate?.matchesViewDidPullToRefresh()
    }
}

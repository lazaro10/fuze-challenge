import UIKit

protocol MatchesViewLogic: UIView {
    func changeState(_ state: MatchesView.State)
    var delegate: MatchesViewDelegate? { get set }
}

protocol MatchesViewDelegate: AnyObject {
    func matchesViewDidTableViewScrollEnded()
}

final class MatchesView: UIView {
    enum State {
        case content(viewModels: [MatchViewModel])
        case loading
        case empty
        case error
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerReusableCell(MatchTableViewCell.self)
        tableView.backgroundColor = .primaryBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    private let loadinView = LoadingView()
    private let emptyStateView = EmptyStateView(message: Strings.matchNotFound)
    private let errorView = ErrorView(message: Strings.matchesNotLoaded)

    private var matchViewModels: [MatchViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

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
        addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
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
            matchViewModels = viewModels
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

extension MatchesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard offsetY > 0 else { return }

        let contentSize = tableView.contentSize.height - 50
        let scrollHeight = scrollView.frame.size.height

        if offsetY > contentSize - scrollHeight {
            delegate?.matchesViewDidTableViewScrollEnded()
        }
    }
}

extension MatchesView: UITableViewDataSource {
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

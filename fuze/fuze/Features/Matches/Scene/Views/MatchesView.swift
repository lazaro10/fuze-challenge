import UIKit

protocol MatchesViewLogic: UIView {
    var matchViewModels: [MatchViewModel] { get set }
    var delegate: MatchesViewDelegate? { get set }
}

protocol MatchesViewDelegate: AnyObject {
    func matchesViewDidTableViewScrollEnded()
}

final class MatchesView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.matches
        label.font = .robotoMeidum(size: 32)

        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerReusableCell(MatchTableViewCell.self)
        tableView.backgroundColor = .primaryBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    var matchViewModels: [MatchViewModel] = [] {
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
        addSubview(titleLabel, constraints: [
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        ])

        addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension MatchesView: MatchesViewLogic {

}

extension MatchesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
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

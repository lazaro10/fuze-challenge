import UIKit

protocol MatchDetailViewLogic: UIView {
    func changeState(_ state: MatchDetailView.State)
}

final class MatchDetailView: UIView {
    enum State {
        case content(matchViewModel: MatchViewModel)
        case loading
        case error
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

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
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension MatchDetailView: MatchDetailViewLogic {
    func changeState(_ state: State) {
        switch state {
        case .content(let viewModel):
            titleLabel.text = viewModel.leagueSerie
        case .loading:
            break
        case .error:
            break
        }
    }
}

import UIKit

final class MatchDetailHeaderView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()

    private let confrontationView = ConfrontationOpponentsView()

    private let matchTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 12)
        label.textAlignment = .center

        return label
    }()

    init() {
        super.init(frame: .zero)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(viewModel: MatchViewModel) {
        titleLabel.text = viewModel.leagueSerie
        confrontationView.setup(viewModel: viewModel.confrontationViewModel)
        matchTimeLabel.text = viewModel.matchTime
    }

    private func setupConstraints() {
        addSubview(titleLabel, constraints: [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        addSubview(confrontationView, constraints: [
            confrontationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            confrontationView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        addSubview(matchTimeLabel, constraints: [
            matchTimeLabel.topAnchor.constraint(equalTo: confrontationView.bottomAnchor, constant: 20),
            matchTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            matchTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            matchTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

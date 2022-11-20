import UIKit

struct MatcheViewModel {
    let matchTime: String
    let isRunning: Bool
    let confrontationViewModel: ConfrontationOpponentsViewModel
    let leagueImageURL: URL?
    let leagueSerie: String
}

final class MatcheTableViewCell: UITableViewCell, Reusable {
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true

        return view
    }()

    private let matcheTimeView: UIView = {
        let view = UIView()

        return view
    }()

    private let matcheTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 8)

        return label
    }()

    private let confrontationView = ConfrontationOpponentsView()

    private let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryGrey

        return view
    }()

    private let leagueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .placeholderCircleSmall
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let leagueSerieLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 8)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupConstraint()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ viewModel: MatcheViewModel) {
        matcheTimeLabel.text = viewModel.matchTime
        confrontationView.setup(viewModel: viewModel.confrontationViewModel)
        leagueSerieLabel.text = viewModel.leagueSerie
    }

    private func setupConstraint() {
        contentView.addSubview(backGroundView, constraints: [
            backGroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backGroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backGroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            backGroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        backGroundView.addSubview(matcheTimeView, constraints: [
            matcheTimeView.topAnchor.constraint(equalTo: backGroundView.topAnchor),
            matcheTimeView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor),
            matcheTimeView.heightAnchor.constraint(equalToConstant: 25)
        ])

        matcheTimeView.addSubview(matcheTimeLabel, constraints: [
            matcheTimeLabel.centerYAnchor.constraint(equalTo: matcheTimeView.centerYAnchor),
            matcheTimeLabel.leadingAnchor.constraint(equalTo: matcheTimeView.leadingAnchor, constant: 8),
            matcheTimeLabel.trailingAnchor.constraint(equalTo: matcheTimeView.trailingAnchor, constant: -8)
        ])

        backGroundView.addSubview(confrontationView, constraints: [
            confrontationView.topAnchor.constraint(equalTo: matcheTimeView.bottomAnchor, constant: 18),
            confrontationView.centerXAnchor.constraint(equalTo: backGroundView.centerXAnchor)
        ])

        backGroundView.addSubview(separatorLineView, constraints: [
            separatorLineView.topAnchor.constraint(equalTo: confrontationView.bottomAnchor, constant: 18),
            separatorLineView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        backGroundView.addSubview(leagueImageView, constraints: [
            leagueImageView.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 8),
            leagueImageView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 16),
            leagueImageView.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor, constant: -8),
            leagueImageView.widthAnchor.constraint(equalToConstant: 16),
            leagueImageView.heightAnchor.constraint(equalToConstant: 16)
        ])

        backGroundView.addSubview(leagueSerieLabel, constraints: [
            leagueSerieLabel.leadingAnchor.constraint(equalTo: leagueImageView.trailingAnchor, constant: 8),
            leagueSerieLabel.centerYAnchor.constraint(equalTo: leagueImageView.centerYAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
        selectionStyle = .none
    }
}

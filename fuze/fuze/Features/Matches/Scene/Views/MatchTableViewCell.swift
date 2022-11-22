import UIKit

struct MatchViewModel {
    let id: Int
    let matchTime: String
    let matchTimeViewColor: UIColor?
    let confrontationViewModel: ConfrontationOpponentsViewModel
    let leagueImageURL: URL?
    let leagueSerie: String
}

final class MatchTableViewCell: UITableViewCell, Reusable {
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true

        return view
    }()

    private let matchTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.clipsToBounds = true

        return view
    }()

    private let matchTimeLabel: UILabel = {
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

        setupConstraints()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ viewModel: MatchViewModel) {
        matchTimeLabel.text = viewModel.matchTime
        matchTimeView.backgroundColor = viewModel.matchTimeViewColor
        confrontationView.setup(viewModel: viewModel.confrontationViewModel)
        leagueSerieLabel.text = viewModel.leagueSerie
        leagueImageView.setImage(viewModel.leagueImageURL, placeholder: .placeholderCircleSmall)
    }

    private func setupConstraints() {
        contentView.addSubview(backGroundView, constraints: [
            backGroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backGroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backGroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            backGroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        backGroundView.addSubview(matchTimeView, constraints: [
            matchTimeView.topAnchor.constraint(equalTo: backGroundView.topAnchor),
            matchTimeView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor),
            matchTimeView.heightAnchor.constraint(equalToConstant: 25)
        ])

        matchTimeView.addSubview(matchTimeLabel, constraints: [
            matchTimeLabel.centerYAnchor.constraint(equalTo: matchTimeView.centerYAnchor),
            matchTimeLabel.leadingAnchor.constraint(equalTo: matchTimeView.leadingAnchor, constant: 8),
            matchTimeLabel.trailingAnchor.constraint(equalTo: matchTimeView.trailingAnchor, constant: -8)
        ])

        backGroundView.addSubview(confrontationView, constraints: [
            confrontationView.topAnchor.constraint(equalTo: matchTimeView.bottomAnchor, constant: 18),
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

import UIKit
import Kingfisher

struct MatchViewModel: Equatable {
    let id: Int
    let matchTime: String
    let matchTimeViewColor: UIColor?
    let confrontationViewModel: ConfrontationOpponentsViewModel
    let leagueImageURL: URL?
    let leagueSerie: String
}

final class MatchTableViewCell: UITableViewCell, Reusable {
    private let matchBackgroundView: UIView = {
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

    func setup<ViewModel>(_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? MatchViewModel else { return }
        
        matchTimeLabel.text = viewModel.matchTime
        matchTimeView.backgroundColor = viewModel.matchTimeViewColor
        confrontationView.setup(viewModel: viewModel.confrontationViewModel)
        leagueSerieLabel.text = viewModel.leagueSerie
        leagueImageView.kf.setImage(with: viewModel.leagueImageURL, placeholder: UIImage.placeholderCircleSmall)
    }

    private func setupConstraints() {
        contentView.addSubview(matchBackgroundView, constraints: [
            matchBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            matchBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            matchBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            matchBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        matchBackgroundView.addSubview(matchTimeView, constraints: [
            matchTimeView.topAnchor.constraint(equalTo: matchBackgroundView.topAnchor),
            matchTimeView.trailingAnchor.constraint(equalTo: matchBackgroundView.trailingAnchor),
            matchTimeView.heightAnchor.constraint(equalToConstant: 25)
        ])

        matchTimeView.addSubview(matchTimeLabel, constraints: [
            matchTimeLabel.centerYAnchor.constraint(equalTo: matchTimeView.centerYAnchor),
            matchTimeLabel.leadingAnchor.constraint(equalTo: matchTimeView.leadingAnchor, constant: 8),
            matchTimeLabel.trailingAnchor.constraint(equalTo: matchTimeView.trailingAnchor, constant: -8)
        ])

        matchBackgroundView.addSubview(confrontationView, constraints: [
            confrontationView.topAnchor.constraint(equalTo: matchTimeView.bottomAnchor, constant: 18),
            confrontationView.centerXAnchor.constraint(equalTo: matchBackgroundView.centerXAnchor)
        ])

        matchBackgroundView.addSubview(separatorLineView, constraints: [
            separatorLineView.topAnchor.constraint(equalTo: confrontationView.bottomAnchor, constant: 18),
            separatorLineView.leadingAnchor.constraint(equalTo: matchBackgroundView.leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: matchBackgroundView.trailingAnchor),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        matchBackgroundView.addSubview(leagueImageView, constraints: [
            leagueImageView.topAnchor.constraint(equalTo: separatorLineView.bottomAnchor, constant: 8),
            leagueImageView.leadingAnchor.constraint(equalTo: matchBackgroundView.leadingAnchor, constant: 16),
            leagueImageView.bottomAnchor.constraint(equalTo: matchBackgroundView.bottomAnchor, constant: -8),
            leagueImageView.widthAnchor.constraint(equalToConstant: 16),
            leagueImageView.heightAnchor.constraint(equalToConstant: 16)
        ])

        matchBackgroundView.addSubview(leagueSerieLabel, constraints: [
            leagueSerieLabel.leadingAnchor.constraint(equalTo: leagueImageView.trailingAnchor, constant: 8),
            leagueSerieLabel.centerYAnchor.constraint(equalTo: leagueImageView.centerYAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
        selectionStyle = .none
    }
}

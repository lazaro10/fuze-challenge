import UIKit

struct PlayersViewModel {
    let firstPlayerImageURL: URL?
    let firstPlayerNickname: String
    let firstPlayerName: String
    let scondPlayerImageURL: URL?
    let secondPlayerNickname: String
    let secondPlayerName: String
}

final class PlayersTableViewCell: UITableViewCell, Reusable {
    private let firstPlayerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true

        return view
    }()

    private let firstPlayerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let firstPlayerNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 14)
        label.textAlignment = .right

        return label
    }()

    private let firstPlayerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 12)
        label.textColor = .primaryBlue
        label.textAlignment = .right

        return label
    }()

    private let secondPlayerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        return view
    }()

    private let secondPlayerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let secondPlayerNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 14)

        return label
    }()

    private let secondPlayerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 12)
        label.textColor = .primaryBlue

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

    func setup(_ viewModel: PlayersViewModel) {
        firstPlayerImageView.setImage(viewModel.firstPlayerImageURL, placeholder: .placeholderRounded)
        firstPlayerNicknameLabel.text = viewModel.firstPlayerNickname
        firstPlayerNameLabel.text = viewModel.firstPlayerName
        secondPlayerImageView.setImage(viewModel.scondPlayerImageURL, placeholder: .placeholderRounded)
        secondPlayerNicknameLabel.text = viewModel.secondPlayerNickname
        secondPlayerNameLabel.text = viewModel.secondPlayerName
    }

    private func setupConstraints() {
        contentView.addSubview(firstPlayerBackgroundView, constraints: [
            firstPlayerBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            firstPlayerBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -6),
            firstPlayerBackgroundView.heightAnchor.constraint(equalToConstant: 58),
            firstPlayerBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            firstPlayerBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        contentView.addSubview(firstPlayerImageView, constraints: [
            firstPlayerImageView.topAnchor.constraint(equalTo: firstPlayerBackgroundView.topAnchor, constant: -4),
            firstPlayerImageView.trailingAnchor.constraint(equalTo: firstPlayerBackgroundView.trailingAnchor, constant: -12),
            firstPlayerImageView.heightAnchor.constraint(equalToConstant: 48),
            firstPlayerImageView.widthAnchor.constraint(equalToConstant: 48)
        ])

        firstPlayerBackgroundView.addSubview(firstPlayerNicknameLabel, constraints: [
            firstPlayerNicknameLabel.topAnchor.constraint(equalTo: firstPlayerBackgroundView.topAnchor, constant: 16),
            firstPlayerNicknameLabel.trailingAnchor.constraint(equalTo: firstPlayerImageView.leadingAnchor, constant: -16),
            firstPlayerNicknameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])

        firstPlayerBackgroundView.addSubview(firstPlayerNameLabel, constraints: [
            firstPlayerNameLabel.topAnchor.constraint(equalTo: firstPlayerNicknameLabel.bottomAnchor),
            firstPlayerNameLabel.trailingAnchor.constraint(equalTo: firstPlayerImageView.leadingAnchor, constant: -16),
            firstPlayerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])

        contentView.addSubview(secondPlayerBackgroundView, constraints: [
            secondPlayerBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            secondPlayerBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 6),
            secondPlayerBackgroundView.heightAnchor.constraint(equalToConstant: 58),
            secondPlayerBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            secondPlayerBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        contentView.addSubview(secondPlayerImageView, constraints: [
            secondPlayerImageView.topAnchor.constraint(equalTo: secondPlayerBackgroundView.topAnchor, constant: -4),
            secondPlayerImageView.leadingAnchor.constraint(equalTo: secondPlayerBackgroundView.leadingAnchor, constant: 12),
            secondPlayerImageView.heightAnchor.constraint(equalToConstant: 48),
            secondPlayerImageView.widthAnchor.constraint(equalToConstant: 48)
        ])

        firstPlayerBackgroundView.addSubview(firstPlayerNicknameLabel, constraints: [
            firstPlayerNicknameLabel.topAnchor.constraint(equalTo: firstPlayerBackgroundView.topAnchor, constant: 16),
            firstPlayerNicknameLabel.trailingAnchor.constraint(equalTo: firstPlayerImageView.leadingAnchor, constant: -16),
            firstPlayerNicknameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])

        secondPlayerBackgroundView.addSubview(secondPlayerNicknameLabel, constraints: [
            secondPlayerNicknameLabel.topAnchor.constraint(equalTo: secondPlayerBackgroundView.topAnchor, constant: 16),
            secondPlayerNicknameLabel.leadingAnchor.constraint(equalTo: secondPlayerImageView.trailingAnchor, constant: 16),
            secondPlayerNicknameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        secondPlayerBackgroundView.addSubview(secondPlayerNameLabel, constraints: [
            secondPlayerNameLabel.topAnchor.constraint(equalTo: secondPlayerNicknameLabel.bottomAnchor),
            secondPlayerNameLabel.leadingAnchor.constraint(equalTo: secondPlayerImageView.trailingAnchor, constant: 16),
            secondPlayerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
        selectionStyle = .none
    }
}

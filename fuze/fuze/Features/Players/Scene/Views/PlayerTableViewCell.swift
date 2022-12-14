import UIKit
import Kingfisher

struct PlayerViewModel: Equatable {
    let imageURL: URL?
    let nickname: String
    let name: String
    let alignment: PlayersAligment
}

final class PlayerTableViewCell: UITableViewCell, Reusable {
    private let playerBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .secondaryBackground

        return view
    }()

    private let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .placeholderRounded

        return imageView
    }()

    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoBold(size: 14)

        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoRegular(size: 12)
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

    func setup<ViewModel>(_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? PlayerViewModel else { return }

        playerImageView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage.placeholderRounded)
        nicknameLabel.text = viewModel.nickname
        nameLabel.text = viewModel.name

        switch viewModel.alignment {
        case .left:
            setupViewsLeftSide()
            setupConstraintsLeftSide()
        case .right:
            setupViewsRightSide()
            setupConstraintsRightSide()
        }
    }

    private func setupViewsLeftSide() {
        playerBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        nicknameLabel.textAlignment = .right
        nameLabel.textAlignment = .right
    }

    private func setupViewsRightSide() {
        playerBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        nicknameLabel.textAlignment = .left
        nameLabel.textAlignment = .left
    }


    private func setupConstraints() {
        contentView.addSubview(playerBackgroundView, constraints: [
            playerBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            playerBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playerBackgroundView.heightAnchor.constraint(equalToConstant: 58),
            playerBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            playerBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func setupConstraintsLeftSide() {
        contentView.addSubview(playerImageView, constraints: [
            playerImageView.topAnchor.constraint(equalTo: playerBackgroundView.topAnchor, constant: -4),
            playerImageView.trailingAnchor.constraint(equalTo: playerBackgroundView.trailingAnchor, constant: -12),
            playerImageView.heightAnchor.constraint(equalToConstant: 48),
            playerImageView.widthAnchor.constraint(equalToConstant: 48)
        ])

        playerBackgroundView.addSubview(nicknameLabel, constraints: [
            nicknameLabel.topAnchor.constraint(equalTo: playerBackgroundView.topAnchor, constant: 16),
            nicknameLabel.trailingAnchor.constraint(equalTo: playerImageView.leadingAnchor, constant: -16),
            nicknameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])

        playerBackgroundView.addSubview(nameLabel, constraints: [
            nameLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: playerImageView.leadingAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }

    private func setupConstraintsRightSide() {
        contentView.addSubview(playerImageView, constraints: [
            playerImageView.topAnchor.constraint(equalTo: playerBackgroundView.topAnchor, constant: -4),
            playerImageView.leadingAnchor.constraint(equalTo: playerBackgroundView.leadingAnchor, constant: 12),
            playerImageView.heightAnchor.constraint(equalToConstant: 48),
            playerImageView.widthAnchor.constraint(equalToConstant: 48)
        ])

        playerBackgroundView.addSubview(nicknameLabel, constraints: [
            nicknameLabel.topAnchor.constraint(equalTo: playerBackgroundView.topAnchor, constant: 16),
            nicknameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            nicknameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        playerBackgroundView.addSubview(nameLabel, constraints: [
            nameLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
        selectionStyle = .none
    }
}

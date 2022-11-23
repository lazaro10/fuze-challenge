import UIKit

struct ConfrontationOpponentsViewModel {
    let leftOpponentImageURL: URL?
    let rightOpponentImageURL: URL?
    let leftOpponentName: String
    let rightOpponentName: String
    let leftOpponentId: Int
    let rightOpponentId: Int
}

final class ConfrontationOpponentsView: UIView {
    private let leftOpponentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let leftOpponentLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 10)
        label.textAlignment = .center

        return label
    }()

    private let versusLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 12)
        label.textColor = .secondaryGrey
        label.textAlignment = .center
        label.text = "VS"

        return label
    }()

    private let rightOpponentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let rightOpponentLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 10)
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

    func setup(viewModel: ConfrontationOpponentsViewModel) {
        leftOpponentImageView.setImage(viewModel.leftOpponentImageURL, placeholder: .placeholderCircle)
        rightOpponentImageView.setImage(viewModel.rightOpponentImageURL, placeholder: .placeholderCircle)
        leftOpponentLabel.text = viewModel.leftOpponentName
        rightOpponentLabel.text = viewModel.rightOpponentName
    }

    private func setupConstraints() {
        addSubview(versusLabel, constraints: [
            versusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            versusLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addSubview(leftOpponentLabel, constraints: [
            leftOpponentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftOpponentLabel.trailingAnchor.constraint(equalTo: versusLabel.leadingAnchor, constant: -20),
            leftOpponentLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            leftOpponentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(leftOpponentImageView, constraints: [
            leftOpponentImageView.topAnchor.constraint(equalTo: topAnchor),
            leftOpponentImageView.bottomAnchor.constraint(equalTo: leftOpponentLabel.topAnchor, constant: -10),
            leftOpponentImageView.centerXAnchor.constraint(equalTo: leftOpponentLabel.centerXAnchor),
            leftOpponentImageView.widthAnchor.constraint(equalToConstant: 60),
            leftOpponentImageView.heightAnchor.constraint(equalToConstant: 60)
        ])

        addSubview(rightOpponentLabel, constraints: [
            rightOpponentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightOpponentLabel.leadingAnchor.constraint(equalTo: versusLabel.trailingAnchor, constant: 20),
            rightOpponentLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            rightOpponentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(rightOpponentImageView, constraints: [
            rightOpponentImageView.topAnchor.constraint(equalTo: topAnchor),
            rightOpponentImageView.bottomAnchor.constraint(equalTo: rightOpponentLabel.topAnchor, constant: -10),
            rightOpponentImageView.centerXAnchor.constraint(equalTo: rightOpponentLabel.centerXAnchor),
            rightOpponentImageView.widthAnchor.constraint(equalToConstant: 60),
            rightOpponentImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

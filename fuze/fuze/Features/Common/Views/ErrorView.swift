import UIKit

final class ErrorView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMeidum(size: 14)
        label.textColor = .secondaryGrey
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "😥"
        label.font = .robotoMeidum(size: 40)
        label.textAlignment = .center

        return label
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.tryAgain, for: .normal)
        button.setTitleColor(.primaryRed, for: .normal)
        button.setTitleColor(.secondaryRed, for: .highlighted)
        button.titleLabel?.font = .robotoMeidum(size: 16)

        return button
    }()

    init(message: String) {
        super.init(frame: .zero)

        setupMessage(message)
        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMessage(_ message: String) {
        messageLabel.text = message
    }

    private func setupConstraints() {
        addSubview(messageLabel, constraints: [
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30)
        ])

        addSubview(emojiLabel, constraints: [
            emojiLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        addSubview(tryAgainButton, constraints: [
            tryAgainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            tryAgainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 40),
            tryAgainButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -16)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

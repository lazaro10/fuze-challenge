import UIKit

final class LoadingView: UIView {
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large

        return indicator
    }()
    
    override var isHidden: Bool {
        didSet {
            isHidden ? indicatorView.stopAnimating() : indicatorView.startAnimating()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupConstraints()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(indicatorView, constraints: [
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

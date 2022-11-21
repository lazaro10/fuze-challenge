import UIKit

protocol MatchDetailViewLogic: UIView {

}

final class MatchDetailView: UIView {
    init() {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        backgroundColor = .primaryBackground
    }
}

extension MatchDetailView: MatchDetailViewLogic {

}

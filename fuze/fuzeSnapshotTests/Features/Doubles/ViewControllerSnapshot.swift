import UIKit
@testable import fuze

final class ViewControllerSnapshot: UIViewController {
    private let customView: UIView
    private let handle: (() -> Void)?

    init(customView: UIView, handle: (() -> Void)? = nil) {
        self.customView = customView
        self.handle = handle

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCustomView()
        handle?()
    }

    private func setupCustomView() {
        view.addSubview(customView, constraints: [
            customView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

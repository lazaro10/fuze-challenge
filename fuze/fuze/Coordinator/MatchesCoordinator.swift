import UIKit

protocol MatchesCoordinatorLogic {
    func showMatchDetail(viewModel: MatchViewModel)
}

final class MatchesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = .primaryWhite

        let viewController = MatchesBuilder.build(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MatchesCoordinator: MatchesCoordinatorLogic {
    func showMatchDetail(viewModel: MatchViewModel) {
        let detailViewController = MatchDetailBuilder.build(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

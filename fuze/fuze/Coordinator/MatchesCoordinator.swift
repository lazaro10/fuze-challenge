import UIKit

protocol MatchesCoordinating {
    func showMatchDetail(matchViewModel: MatchViewModel)
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

extension MatchesCoordinator: MatchesCoordinating {
    func showMatchDetail(matchViewModel: MatchViewModel) {
        let detailViewController = MatchDetailBuilder.build(viewModel: matchViewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

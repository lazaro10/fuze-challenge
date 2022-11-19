import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MatchesBuilder.build()
        navigationController.pushViewController(viewController, animated: true)
    }
}

@testable import fuze
import UIKit

final class NavigationControllerSpy: UINavigationController {
    var pushViewControllerHandler: ((UIViewController) -> Void)?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerHandler?(viewController)
    }
}

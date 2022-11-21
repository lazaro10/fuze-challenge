import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MatchesCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()

        coordinator = MatchesCoordinator(navigationController: navigationController)
        coordinator?.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

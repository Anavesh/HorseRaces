import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupWindow(for: windowScene)
    }
    
    // MARK: - Window Configuration
    private func setupWindow(for windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createMainTabBarController()
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Tab Bar Setup
    private func createMainTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        configureTabBarAppearance(tabBarController.tabBar)
        
        tabBarController.viewControllers = [
            createRaceViewController(),
            createHistoryViewController()
        ]
        
        return tabBarController
    }
    
    private func configureTabBarAppearance(_ tabBar: UITabBar) {
        tabBar.backgroundColor = .secondarySystemBackground
        tabBar.tintColor = .systemIndigo
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    // MARK: - View Controllers Factory
    private func createRaceViewController() -> UIViewController {
        let controller = RaceViewController()
        return wrapInNavigation(
            controller: controller,
            title: "Race",
            icon: .init(systemName: "flag.checkered")
        )
    }
    
    private func createHistoryViewController() -> UIViewController {
        let controller = RaceHistoryViewController()
        return wrapInNavigation(
            controller: controller,
            title: "History",
            icon: .init(systemName: "clock")
        )
    }
    
    // MARK: - Navigation Controller Helper
    private func wrapInNavigation(
        controller: UIViewController,
        title: String,
        icon: UIImage?
    ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem = UITabBarItem(title: title, image: icon, selectedImage: nil)
        navController.navigationBar.prefersLargeTitles = true
        controller.navigationItem.title = title
        return navController
    }

    // MARK: - Scene Lifecycle (оставлены только используемые методы)
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

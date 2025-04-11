//
//  SceneDelegate.swift
//  HorseRaces
//
//  Created by Naira on 10.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9176470588, blue: 1, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.9215686275, green: 0.9176470588, blue: 1, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 0.9529411765, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 1, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
        
        let raceVC = createNavController(for: RaceViewController(), title: "Race", tag: 0)
        let raceHistoryVC = createNavController(for: RaceHistoryViewController(), title: "History", tag: 1)
        
        tabBarController.viewControllers = [raceVC, raceHistoryVC]
        return tabBarController
    }
    
    private func createNavController(
        for rootViewController: UIViewController,
        title: String,
        tag: Int
    ) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem = UITabBarItem(
            title: title,
            image: nil,
            tag: tag
        )
        
        navController.navigationBar.tintColor = .systemBlue
        return navController
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene){}

}


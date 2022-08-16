//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Максим Ялынычев on 21.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func createFeedViewController() -> UINavigationController{
        let feedViewController = FeedViewController()
        feedViewController.title = "FeeD"
        feedViewController.tabBarItem = UITabBarItem(title: "FeeD", image: UIImage(systemName: "doc.text"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    
    func createProfileViewController() -> UINavigationController{
        let profileViewController = LogInViewController()
        profileViewController.title = "Log In"
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image:UIImage(systemName:"person.crop.circle"), tag:1)
        
    return UINavigationController(rootViewController: profileViewController)
        
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .white
        tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
        return tabBarController
    }
}


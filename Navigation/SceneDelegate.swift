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
    
    private enum TabItemType {
        case feed
        case profile
        
        var title: String {
            switch self {
            case.feed:
                return "FeeD"
            case.profile:
                return "Log In"
            }
        }
        
        var tebBarItem: UITabBarItem{
            switch self {
            case.feed:
                return UITabBarItem(
                    title: "FeeD", image: UIImage(systemName: "doc.text"), tag: 0
                    )
            case.profile:
                return UITabBarItem(title: "Profile", image: UIImage(systemName:"person.crop.circle"), tag: 1)
                
            }
        }
    }
    
    private func createNavController(for tabItemType: TabItemType) ->
    UINavigationController {
        let viewController: UIViewController
        switch tabItemType{
        case.feed:
            viewController = FeedViewController()
        case.profile:
            viewController = LogInViewController()
        }
        viewController.title = tabItemType.title
        viewController.tabBarItem = tabItemType.tebBarItem
        return UINavigationController(rootViewController:viewController)
    }
    
   private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .white
       tabBarController.viewControllers = [self.createNavController(for: .feed), self.createNavController(for: .profile)]
        return tabBarController
    }
}


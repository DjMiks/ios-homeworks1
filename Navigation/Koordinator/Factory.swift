//
//  Factory.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit

class Factory {
    
    enum List{
        case feed
        case login
    }
    
    let navigationController: UINavigationController
    let viewController: List
    
    init(navigationController: UINavigationController, viewController: List) {
        self.navigationController = navigationController
        self.viewController = viewController
        startModule()
    }
    func startModule() {
        switch viewController {
        case .feed:
            let feedCoordinator = FeedCoordinator(navigationController: navigationController)
            let controller = FeedViewController(coordinator: feedCoordinator)
            navigationController.tabBarItem = .init(title: "FeeD", image: UIImage(systemName: "doc.text"), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
            
        case .login:
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            let controller = LogInViewController(coordinator: loginCoordinator)
            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
            navigationController.tabBarItem = .init(title: "Log In", image: UIImage(systemName: "person.crop.circle"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}

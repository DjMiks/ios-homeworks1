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
            let feedKoordinator = FeedKoordinator(navigationController: navigationController)
            let controller = FeedViewController(koordinator: feedKoordinator)
            navigationController.tabBarItem = .init(title: "FeeD", image: UIImage(systemName: "doc.text"), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
            
        case .login:
            let loginKoordinator = LoginKoordinator(navigationController: navigationController)
            let controller = LogInViewController(koordinator: loginKoordinator)
            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
            navigationController.tabBarItem = .init(title: "Log In", image: UIImage(systemName: "person.crop.circle"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}

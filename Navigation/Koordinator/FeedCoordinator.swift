//
//  FeedKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit

final class FeedCoordinator {
    
    

    var navigationController: UINavigationController
    
    var output: FeedOutput?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let feedCoordinator = FeedCoordinator(navigationController: navigationController)
        let feedViewController = FeedViewController(coordinator: feedCoordinator)
        navigationController.pushViewController(feedViewController, animated: true)
    }
    
    func makePostVC() {
        let postVS = PostViewController()
        navigationController.pushViewController(postVS, animated: true)
    }

}

extension FeedCoordinator: FeedOutput {
    func showPost() {
        makePostVC()
    }
}

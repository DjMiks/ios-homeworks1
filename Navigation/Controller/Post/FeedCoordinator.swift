//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 25.01.2023.
//

import UIKit

final class FeedCoordinator: AppCoordinator {
    
    var transitionHandler: UINavigationController
    var output: FeedOutput?
    
    var childs: [AppCoordinator] = []
    let feedAssembly = Assembly()
    

    
    init(transitionHandler: UINavigationController) {
        self.transitionHandler = transitionHandler
    }
    
    func makeFeedVC() {
        let feedVC = feedAssembly.createFeedVC()
        feedVC.output = self
        feedVC.tabBarItem.title = "FeeD"
        feedVC.tabBarItem.image = UIImage(systemName: "doc.text")
        transitionHandler.pushViewController(feedVC, animated: true)
    }
    
    func makePostVC() {
        let postVS = PostViewController()
        transitionHandler.pushViewController(postVS, animated: true)
    }

}

extension FeedCoordinator: FeedOutput {
    func showPost() {
        makePostVC()
    }
}

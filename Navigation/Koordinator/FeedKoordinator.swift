//
//  FeedKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit

class FeedKoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let feedKoordinator = FeedKoordinator(navigationController: navigationController)
        let feedViewController = FeedViewController(koordinator: feedKoordinator)
        navigationController.pushViewController(feedViewController, animated: true)
    }
}

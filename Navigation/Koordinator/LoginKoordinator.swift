//
//  LoginKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//
import Foundation
import UIKit

class LoginKoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let loginKoordinator = LoginKoordinator(navigationController: navigationController)
        let loginViewController = LogInViewController(koordinator: loginKoordinator)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}

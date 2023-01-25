//
//  LoginKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//
import Foundation
import UIKit

class LoginCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        let loginViewController = LogInViewController(coordinator: loginCoordinator)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}

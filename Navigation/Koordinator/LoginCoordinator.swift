//
//  LoginKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//
import Foundation
import UIKit

final class LoginCoordinator {
        
    var navigationController: UINavigationController
    
    var output: ProfileOutput?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        let loginViewController = LogInViewController(coordinator: loginCoordinator)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func toPhotosVC() {
        let nextViewController = PhotosViewController()
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(
            nextViewController, animated: true
            )
    }
}

extension LoginCoordinator: ProfileOutput {
    func showPhotos() {
        toPhotosVC()
    }
}

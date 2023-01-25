//
//  TabBarKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    private let feedVC = Factory(navigationController: UINavigationController(), viewController: .feed)
    private let loginVC = Factory(navigationController: UINavigationController(), viewController: .login)
   

    override func viewDidLoad() {
        super.viewDidLoad()

        setControllers()
    }

    func setControllers() {
        viewControllers = [feedVC.navigationController, loginVC.navigationController]
    }
}

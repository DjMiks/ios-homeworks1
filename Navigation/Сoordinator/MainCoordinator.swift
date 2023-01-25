//
//  MainKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit


protocol MainCoordinator {
    func startApplication() -> UIViewController
}

class MainCoordinatorImp: MainCoordinator {
    func startApplication() -> UIViewController {
        return TabBarController()
    }
}

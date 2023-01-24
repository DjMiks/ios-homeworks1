//
//  MainKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit


protocol MainKoordinator {
    func startApplication() -> UIViewController
}

class MainKoordinatorImp: MainKoordinator {
    func startApplication() -> UIViewController {
        return TabBarController()
    }
}

//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 25.01.2023.
//

import Foundation
import UIKit

protocol AppCoordinator {
    
    var childs: [AppCoordinator] { get set }
}

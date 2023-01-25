//
//  MainKoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation
import UIKit

final class Assembly {
    
    func createFeedVC() -> FeedViewController {
        let feedVC = FeedViewController()
        return feedVC
    }
    
    func createProfileVC() -> ProfileViewController {
        let profileVC = ProfileViewController()
        return profileVC
    }
    

}

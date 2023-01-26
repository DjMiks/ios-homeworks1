//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Максим Ялынычев on 25.01.2023.
//

 import UIKit

final class ProfileCoordinator: AppCoordinator, FeedOutput {
    func showPost() {
    }
    
    
    var transitionHandler: UINavigationController
    var output: ProfileOutput?
    
    var childs: [AppCoordinator] = []
    let profileAssembly = Assembly()
    
    
    
    init(transitionHandler: UINavigationController) {
        self.transitionHandler = transitionHandler
    }
    
    func makeProfileVC() {
        let profileVC = profileAssembly.createProfileVC()
        profileVC.output = self
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        transitionHandler.pushViewController(profileVC, animated: true)
    }
}
   

    


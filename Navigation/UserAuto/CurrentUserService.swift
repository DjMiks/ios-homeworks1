//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.10.2022.
//

import Foundation
import UIKit


 final class CurrentUserService: UserService {
    
     let currentUser = User(login: "StandUp", fullName: "StandUP", avatar: UIImage(named: "standup")!, status: "Welcome to the profile StandUp.")
    
     let password: String = "standup"
    
    func loginCheck (login: String) -> User? {
        login == currentUser.login ? currentUser : nil

    //  ранее использовал
        
//    func loginCheck (login: String) -> User? {
//        let user = currentUser
//        if login == user.login {
//            return user
//        } else {
//            return nil
//        }
//    }

    }
}
    



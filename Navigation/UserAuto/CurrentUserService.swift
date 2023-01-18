//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.10.2022.
//

import Foundation
import UIKit


class CurrentUserService: UserService {
    
    public var currentUser = User(login: "StandUp", fullName: "StandUP", avatar: UIImage(named: "standup")!, status: "gud")
    
    public var password: String = "standup"
    
    func loginCheck (login: String) -> User? {
        let user = currentUser
        if login == user.login {
            return user
        } else {
            return nil
        }
    }

}



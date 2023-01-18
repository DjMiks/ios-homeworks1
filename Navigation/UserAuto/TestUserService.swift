//
//  TestUserService.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.10.2022.
//

import Foundation
import UIKit


class TestUserService: UserService {
    
    let testUser = User(login: "test", fullName: "Test", avatar: UIImage(named: "logo_vk")!, status: "Test profil")
    
    let password: String = "test"
      
    
    func loginCheck(login: String) -> User? {
        let user = testUser
        if login == user.login{
            return user
        } else {
            return nil
        }
    }
}

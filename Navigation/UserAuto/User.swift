//
//  User.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.10.2022.
//

import UIKit

  protocol UserService {
    
     func loginCheck(login: String) -> User?
}

public class User {
    
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}


//enum Choice {
//    case combat
//    case test
//
//    var inistance: User {
//        switch self {
//        case.combat:
//            return User(login: "combat", fullName: "Ruslan", avatar: UIImage(named: "Belyu"), status: "Have a nice day, Ruslan")
//        case.test:
//            return User(login: "test", fullName: "Test_User", avatar: UIImage(named: "logo_vk"), status: "Testing")
//        }
//    }
    


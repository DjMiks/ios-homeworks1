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


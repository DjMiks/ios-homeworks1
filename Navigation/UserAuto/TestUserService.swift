//
//  TestUserService.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.10.2022.
//

import Foundation


class TestUserService: UserService {
    
    let user = Choice.test.inistance
    
    func loginCheck(login: String) -> User? {
        if login == user.login{
            return user
        } else {
            return nil
        }
    }
}

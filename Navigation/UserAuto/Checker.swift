//
//  Checker.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.01.2023.
//

import Foundation

class Checker {
     
    static let service = Checker()
    private init() {}
    
    private let login: String = "Stand"
    private let password: String = "stand"
    
    func check (inputedLogin: String, inputedPass: String) -> Bool {
     //   можно без них
        //   let login = login
    //    let pass = password
        
        return inputedLogin == login && inputedPass == password ? true : false
    }
    
}

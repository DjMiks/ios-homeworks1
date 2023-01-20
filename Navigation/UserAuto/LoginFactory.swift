//
//  LoginFactory.swift
//  Navigation
//
//  Created by Максим Ялынычев on 19.01.2023.
//

import UIKit


protocol LoginFactory {
    func makeLoginInspector () -> LoginInspector
}

    struct MyLoginFactory: LoginFactory {
        func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
        }
        
    }



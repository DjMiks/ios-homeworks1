//
//  AuthorizationServise.swift
//  Navigation
//
//  Created by Максим Ялынычев on 25.04.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationServise {
    
    var isAuth: Bool?
    private let context = LAContext()

    
    func authorizeIfPossible(_ authorisationFinished: @escaping (Bool) -> Void) {

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "check bio") { success, error in
            if success {
                self.isAuth = true
            } else {
                self.isAuth = false
            }
            authorisationFinished(self.isAuth ?? false)
        }
    }
}


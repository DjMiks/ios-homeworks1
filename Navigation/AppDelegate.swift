//
//  AppDelegate.swift
//  Navigation
//
//  Created by Максим Ялынычев on 21.06.2022.
//

import UIKit
import FirebaseCore
import Firebase

 @main

class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
            print("Log out")
        } catch {
            print (error)
        }
    }


}


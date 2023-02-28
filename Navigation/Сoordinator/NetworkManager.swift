//
//  NetworkManager.swift
//  Navigation
//
//  Created by Максим Ялынычев on 09.02.2023.
//

import Foundation
import FirebaseAuth


enum AppConfiguration: String, CaseIterable {
    
    case firstStringURL = "https://swapi.dev/api/people/8"
    case secondStringURL = "https://swapi.dev/api/starships/3"
    case thirdStringURL = "https://swapi.dev/api/planets/5"
}

var appConfiguration: AppConfiguration?

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {
                
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: URL(string: configuration.rawValue)!) { data, response, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let resp = response as? HTTPURLResponse else {
                            print("Network error")
                            return
                        }

                        if resp.statusCode != 200 {
                            print ("Error, statuse code is \(resp.statusCode)")
                            
                            return
                        }
            /*
            if (respose as! HTTPURLResponse).statusCode != 200 {
                print ("Error, statuse code is \((respose as! HTTPURLResponse).statusCode)")
                return
            */
            
            guard let data else {
                print("No data")
                return
            }
            do {
                let answer = try JSONSerialization.jsonObject(with: data)
                print(answer)
//                print("===============")
//                print("\(resp.allHeaderFields)")
//                print("===============")
//                print("\(resp.statusCode)")
                return
                
                // error - The Internet connection appears to be offline.
                
            } catch {
                print (error.localizedDescription.debugDescription)
            }
        }
        task.resume()
    }
}

//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.01.2023.
//

import Foundation

class FeedModel {
    
    let secretWord: String = "Snow"
    
    func check (word: String) -> Bool {
     
        let input = word
        
        return secretWord == input ? true : false
    }
}

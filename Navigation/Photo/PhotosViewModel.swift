//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Максим Ялынычев on 02.03.2023.
//

import Foundation
import UIKit

final class PhotosViewModel {
    var imagesArray: [UIImage]
    
    var images: [UIImage]? {
        didSet {
            self.imageChanged?(self)
        }
    }
    
    init(model: [UIImage]) {
        self.imagesArray = model
    }
    
    var imageChanged: ((PhotosViewModel) -> ())?
    
    func makeArray() {
        images = imagesArray
    }
}

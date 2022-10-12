//
//  AllPhotos.swift
//  Navigation
//
//  Created by Максим Ялынычев on 23.08.2022.
//

import UIKit

struct AllPhotos {
    let photoImage: String
}

extension AllPhotos {
    static func myPhotos() ->[AllPhotos] {
        [
            AllPhotos(photoImage: "1"),
            AllPhotos(photoImage: "2"),
            AllPhotos(photoImage: "3"),
            AllPhotos(photoImage: "4"),
            AllPhotos(photoImage: "5"),
            AllPhotos(photoImage: "6"),
            AllPhotos(photoImage: "7"),
            AllPhotos(photoImage: "8"),
            AllPhotos(photoImage: "9"),
            AllPhotos(photoImage: "10"),
            AllPhotos(photoImage: "11"),
            AllPhotos(photoImage: "12"),
            AllPhotos(photoImage: "13"),
            AllPhotos(photoImage: "14"),
            AllPhotos(photoImage: "15")
        ]

    }
}

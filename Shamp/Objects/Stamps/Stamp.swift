//
//  Stamp.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Stamp {
    let id: Int
    let artistID: Int
    let artistEmail: String
    let categoryID: Int
    let categoryName: String
    let status: Bool
    let name: String
    let shortDescription: String
    let price: Int
    let imagePath: URL
    let isPrivate: Bool
    let rating: Int?
    let blackAndWhite: String?
    let negative: String?
    
    // MARK: - Initializer
    init?(id: Int, artistID: Int, artistEmail: String, categoryID: Int, categoryName: String, status: Bool, name: String, shortDescription: String, price: Int, imagePath: URL, isPrivate: Bool, rating: Int?, blackAndWhite: String?, negative: String?) {
        self.id = id
        self.artistID = artistID
        self.artistEmail = artistEmail
        self.categoryID = categoryID
        self.categoryName = categoryName
        self.status = status
        self.name = name
        self.shortDescription = shortDescription
        self.price = price
        self.imagePath = imagePath
        self.isPrivate = isPrivate
        self.rating = rating
        self.blackAndWhite = blackAndWhite
        self.negative = negative
    }
    
}

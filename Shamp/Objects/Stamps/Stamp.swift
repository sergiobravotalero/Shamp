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
    let name: String
    let categoryName: String
    let stampImage: URL?
    let stampLongDescription: String
    let stampShortDescription: String
    let stampName: String
    let stampPrice: String
    let artistName: String
    let artistEmail: String
    
    // MARK: - Initializer
    init?(id: Int, name: String, categoryName: String, stampImage: URL?, stampLongDescription: String, stampShortDescription: String, stampName: String, stampPrice: String, artistName: String, artistEmail: String) {
        self.id = id
        self.name = name
        self.categoryName = categoryName
        self.stampImage = stampImage
        self.stampLongDescription = stampLongDescription
        self.stampShortDescription = stampShortDescription
        self.stampName = stampName
        self.stampPrice = stampPrice
        self.artistName = artistName
        self.artistEmail = artistEmail
    }
    
}

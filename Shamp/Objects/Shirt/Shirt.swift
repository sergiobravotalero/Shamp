//
//  Shirt.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Shirt {
    let id: Int
    let name: String
    let color: String
    let sex: String
    let price: Int
    let smallImagePath: URL
    let largeImagePath: URL
    
    init?(id: Int, name: String, color: String, sex: String, price: Int, smallImagePath: URL, largeImagePath: URL) {
        self.id = id
        self.name = name
        self.color = color
        self.sex = sex
        self.price = price
        self.smallImagePath = smallImagePath
        self.largeImagePath = largeImagePath
    }
}

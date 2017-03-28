//
//  Product.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Product {
    let stampID: Int
    let shirtID: Int
    let quantity: Int
    let size: String
    let location: String
    
    init?(stampID: Int, shirtID: Int, quantity: Int, size: String, location: String) {
        self.stampID = stampID
        self.shirtID = shirtID
        self.quantity = quantity
        self.size = size
        self.location = location
    }
}

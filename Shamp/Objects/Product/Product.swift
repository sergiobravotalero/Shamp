//
//  Product.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

class Product {
    let stampID: Int
    let shirtID: Int
    let quantity: Int
    let size: String
    let location: String
    let text :String?
    let textColor: UIColor?
    let textSize: String?
    let textLocation: String?
    var imageUrl: URL
    
    init?(stampID: Int, shirtID: Int, quantity: Int, size: String, location: String, text: String?, textColor: UIColor?, textSize: String?, textLocation: String?, imageUrl: URL) {
        self.stampID = stampID
        self.shirtID = shirtID
        self.quantity = quantity
        self.size = size
        self.location = location
        self.text = text
        self.textColor = textColor
        self.textSize = textSize
        self.textLocation = textLocation
        self.imageUrl = imageUrl
    }
    
    // MARK: - Methods
    func getProductPrice() -> Int {
        guard let shirt = SessionHandler.shared.shirtsCollection.first(where: { $0.id == self.shirtID }), let stamp  = SessionHandler.shared.stampsCollection.first(where: { $0.id == self.stampID }) else { return 0 }
        let shirtPrice = shirt.price
        let stampPrice = stamp.price
        return (stampPrice * self.quantity) + (shirtPrice * self.quantity)
    }
    
    func equals(toProduct: Product) -> Bool {
        return self.stampID == toProduct.stampID && self.shirtID == toProduct.shirtID && self.quantity == toProduct.quantity && self.size == toProduct.size && self.location == toProduct.location && self.text == toProduct.text && self.textColor == toProduct.textColor && self.textSize == toProduct.textSize && self.textLocation == toProduct.textLocation && self.imageUrl == toProduct.imageUrl
    }
}

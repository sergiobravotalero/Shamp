//
//  ShoppingCart.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class ShoppingCart {
    static let shared = ShoppingCart()
    private init() {}
    
    var products = [Product]()
    
    // MARK: - Methods
    func addProductToShoppingCart(product: Product) {
        products.append(product)
    }
    
    func placeOrder(deliveryAddress: String, contactPhone: String, city: String, country: String) {
        let userID = FacebookHandler.shared.getFacebookCurrentAccessToken()
        
        var productsArray = [NSMutableDictionary]()
        for product in products {
            let dictionary = [
                "stamp_id": product.stampID,
                "shirt_id": product.shirtID,
                "quantity": product.quantity,
                "size": product.size,
                "location": product.location
            ] as NSMutableDictionary
            productsArray.append(dictionary)
        }
        
        let order = [
            "delivery_address": deliveryAddress,
            "contact_phone": contactPhone,
            "city": city,
            "country": country
        ]
        
        let orderInJson = [
            "user_id": userID,
            "products": productsArray,
            "oder": order
        ] as [String : Any]
        
        print(orderInJson)
    }
}

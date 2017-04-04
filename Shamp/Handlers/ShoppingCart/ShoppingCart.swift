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
    
    func removeProduct(product: Product) {
        if let index = products.index(where: { $0.shirtID == product.shirtID && $0.stampID == product.stampID && $0.size == product.size && $0.quantity == product.quantity && $0.location == $0.location }) {
            products.remove(at: index)
        }
    }
    
    func placeOrderWithCompletion(deliveryAddress: String, contactPhone: String, city: String, country: String, completion: @escaping(_ succeeded: Bool) -> ()) {
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
            "order": order
        ] as [String : Any]
        
        RequesterHandler().addOrderToServerWithCompletion(order: orderInJson, completion: { (succeeded) in
            completion(succeeded)
        })
    }
}

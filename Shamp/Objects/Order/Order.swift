//
//  Order.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Order {
    let deliveryAddress: String
    let contactPhone: String
    let city: String
    let country: String
    var products: [Product]
    
    init?(deliveryAddress: String, contactPhone: String, city: String, country: String, products: [Product]) {
        self.deliveryAddress = deliveryAddress
        self.contactPhone = contactPhone
        self.city = city
        self.country = country
        self.products = products
    }
    
    func compare(toOrder: Order) -> Bool{
        let productsMatch = containSameElements(self.products, toOrder.products)
        return self.deliveryAddress == toOrder.deliveryAddress && self.contactPhone == toOrder.contactPhone && self.city == toOrder.city && self.country == toOrder.country && productsMatch
    }
    
    private func containSameElements(_ array1: [Product], _ array2: [Product]) -> Bool {
        if array1.count != array2.count {
            return false
        }
        
        for index in 0...array1.count - 1 {
            if !array1[index].equals(toProduct: array2[index]) {
                return false
            }
        }
        
        return true
    }
}

//
//  User.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class User {
    let id: Int
    let city: String
    let country: String
    let cvv: String
    let email: String
    let expDate: Int
    let phoneNumber: String
    let nameCard: String
    let surname: String
    let userAddress: String
    let userCreditCard: String
    let username: String
    let didUserLoggedWithDB: Bool
    
    init?(id: Int, city: String, country: String, cvv: String, email: String, expDate: Int, phoneNumber: String, surname: String, userAddress: String, userCreditCard: String, username: String, nameCard: String, didUserLoggedWithDB: Bool) {
        self.id = id
        self.city = city
        self.country = country
        self.cvv = cvv
        self.email = email
        self.expDate = expDate
        self.phoneNumber = phoneNumber
        self.surname = surname
        self.userAddress = userAddress
        self.userCreditCard = userCreditCard
        self.username = username
        self.nameCard = nameCard
        self.didUserLoggedWithDB = didUserLoggedWithDB
    }
}

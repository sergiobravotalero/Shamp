//
//  Variability.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/21/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Variability {
    let advanceSearch: Bool
    let productRating: Bool
    let shirtText: Bool
    let messages: Bool
    let filters: Bool
    let privateStamp: Bool
    let loginSocialNetwork: Bool
    let shareSocialNetwork: Bool
    let changePassword: Bool
    let changeAddress: Bool
    let ratingsReports: Bool
    let sellReports: Bool
    
    init?(advanceSearch: Bool, productRating: Bool, shirtText: Bool, messages: Bool, filters: Bool, privateStamp: Bool, loginSocialNetwork: Bool, shareSocialNetwork: Bool, changePassword: Bool, changeAddress: Bool, ratingsReports: Bool, sellReports: Bool) {
        self.advanceSearch = advanceSearch
        self.productRating = productRating
        self.shirtText = shirtText
        self.messages = messages
        self.filters = filters
        self.privateStamp = privateStamp
        self.loginSocialNetwork = loginSocialNetwork
        self.shareSocialNetwork = shareSocialNetwork
        self.changePassword = changePassword
        self.changeAddress = changeAddress
        self.ratingsReports = ratingsReports
        self.sellReports = sellReports
    }
}

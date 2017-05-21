//
//  ParserHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class ParserHandler {
    //MARK: - Features
    func getListOfFeatures(body: NSDictionary, completion: (_ success: Bool) ->()) {
        guard let advanceSearch = body.object(forKey: "advanceSearch") as? Bool,
            let productRating = body.object(forKey: "productRating") as? Bool,
            let shirtText = body.object(forKey: "shirtText") as? Bool,
            let messages = body.object(forKey: "messages") as? Bool,
            let filters = body.object(forKey: "filters") as? Bool,
            let privateStamp = body.object(forKey: "privateStamp") as? Bool,
            let loginSocialNetwork = body.object(forKey: "loginSocialNetwork") as? Bool,
            let shareSocialNetwork = body.object(forKey: "shareSocialNetwork") as? Bool,
            let changePassword = body.object(forKey: "changePassword") as? Bool,
            let changeAddress = body.object(forKey: "changeAddress") as? Bool,
            let ratingsReports = body.object(forKey: "ratingsReports") as? Bool,
            let sellReports = body.object(forKey: "sellReports") as? Bool else {
                print("Parse of features failed")
                completion(false)
                return
        }
        
        guard let variability = Variability(
            advanceSearch: advanceSearch,
            productRating: productRating,
            shirtText: shirtText,
            messages: messages,
            filters: filters,
            privateStamp: privateStamp,
            loginSocialNetwork: loginSocialNetwork,
            shareSocialNetwork: shareSocialNetwork,
            changePassword: changePassword,
            changeAddress: changeAddress,
            ratingsReports: ratingsReports,
            sellReports: sellReports) else {
                print("Init of variability failed")
                completion(false)
                return
        }
        
        SessionHandler.shared.listOfFeatures = variability
        completion(true)
    }
    
    
    // MARK: - Stamp
    func getCollectionOfStampsWithCompletion(dictionary: NSArray, completion: () -> ()) {
    
        var stamps = [Stamp]()
        for element in dictionary {
            guard let elementDictionary = element as? NSDictionary else { continue }
            
            
            guard let status = elementDictionary.object(forKey: "stamp_status") as? Bool else { continue }
            
            if !status {
                continue
            } else {
                getCategory(dictionary: elementDictionary)
            }
            
            guard let id = elementDictionary.object(forKey: "stamp_id") as? Int else { continue }
            guard let artistID = elementDictionary.object(forKey: "user_id") as? Int else { continue }
            guard let artistEmail = elementDictionary.object(forKey: "user_email") as? String else { continue }
            guard let categoryID = elementDictionary.object(forKey: "category_id") as? Int else { continue }
            guard let categoryName = elementDictionary.object(forKey: "category_name") as? String else { continue }
            guard let stampStatus = elementDictionary.object(forKey: "stamp_status") as? Bool else { continue }
            guard let stampName = elementDictionary.object(forKey: "stamp_name") as? String else { continue }
            guard let stampShortDescription = elementDictionary.object(forKey: "stamp_short_description") as? String else { continue }
            guard let stampPrice = elementDictionary.object(forKey: "stamp_price") as? Int else { continue }
            guard let stampImagePath = elementDictionary.object(forKey: "stamp_image_path") as? String else { continue }
            
            guard let stampImage = URL(string: stampImagePath.replacingOccurrences(of: " ", with: "")) else { continue }
            
            guard let stamp = Stamp(
                id: id,
                artistID: artistID,
                artistEmail: artistEmail,
                categoryID: categoryID,
                categoryName: categoryName,
                status: stampStatus,
                name: stampName,
                shortDescription: stampShortDescription,
                price: stampPrice,
                imagePath: stampImage) else { continue }
            stamps.append(stamp)
        }
        
        SessionHandler.shared.stampsCollection = stamps
        completion()
    }
    
    // MARK: - Category and Artist
    func getCategory(dictionary: NSDictionary?) {
        guard let name = dictionary?.object(forKey: "category_name") as? String else { return }
        guard let category = Category(name: name, status: true) else { return }
        
        if !SessionHandler.shared.categoriesCollection.contains(where: { $0.name == category.name}) {
            SessionHandler.shared.categoriesCollection.append(category)
        }
        
        guard let artistEmail = dictionary?.object(forKey: "user_email") as? String else { return }
        if !SessionHandler.shared.artistsCollection.contains(where: { $0 == artistEmail }) {
            SessionHandler.shared.artistsCollection.append(artistEmail)
        }
    }
    
    
    // MARK: - Shirt
    func getCollectionOfShirtsWithCompletion(dictionary: NSArray, completion: () -> ()) {
        var shirts = [Shirt]()
        for element in dictionary {
            guard let elementDictionary = element as? NSDictionary else { continue }
            
            guard let id = elementDictionary.object(forKey: "shirt_id") as? Int else { continue }
            guard let name = elementDictionary.object(forKey: "name") as? String else { continue }
            guard let color = elementDictionary.object(forKey: "shirt_color") as? String else { continue }
            guard let gender = elementDictionary.object(forKey: "shirt_sex") as? String else { continue }
            guard let price = elementDictionary.object(forKey: "shirt_price") as? Int else { continue }
            
            guard let smallImage = elementDictionary.object(forKey: "shirt_small_image_path") as? String else { continue }
            guard let largeImage = elementDictionary.object(forKey: "shirt_large_image_path") as? String else { continue }
            
            guard let smallImageUrl = URL(string: smallImage.replacingOccurrences(of: " ", with: "")) else { return }
            guard let largeImageUrl = URL(string: largeImage.replacingOccurrences(of: " ", with: "")) else { return }
            
            
            guard let shirt = Shirt(id: id, name: name, color: color, sex: gender, price: price, smallImagePath: smallImageUrl, largeImagePath: largeImageUrl) else { continue }
            shirts.append(shirt)
        }
        
        SessionHandler.shared.shirtsCollection = shirts
        completion()
    }
    
    // MARK: - User
    
    func getUserFrom(dictionary: NSDictionary, billing: NSDictionary, completion: @escaping (_ succeeded: Bool) -> ()) {
        guard let id = billing.value(forKeyPath: "user_id.user_id") as? Int,
            let city = billing.object(forKey: "user_city") as? String,
            let country = billing.object(forKey: "user_country") as? String,
            let cvv = billing.object(forKey: "cvv") as? String,
            let expirationDate = billing.object(forKey: "expiration_date") as? Int,
            let phoneNumber = billing.object(forKey: "phone_number") as? String,
            let userAddress = billing.object(forKey: "user_address") as? String,
            let userCreditCard = billing.object(forKey: "user_credit_card") as? String,
            let nameCard = billing.object(forKey: "name_card") as? String else {
                completion(false)
                return
        }
        
        guard let email = dictionary.object(forKey: "email") as? String,
            let surname = dictionary.object(forKey: "surname") as? String,
            let username = dictionary.object(forKey: "username") as? String else {
                completion(false)
                return
        }
        
        guard let user = User(id: id, city: city, country: country, cvv: cvv, email: email, expDate: expirationDate, phoneNumber: phoneNumber, surname: surname, userAddress: userAddress, userCreditCard: userCreditCard, username: username, nameCard: nameCard) else {
            completion(false)
            return
        }
        
        SessionHandler.shared.loggedUser = user
        completion(true)
        
    }
}

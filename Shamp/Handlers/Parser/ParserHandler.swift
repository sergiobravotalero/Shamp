//
//  ParserHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class ParserHandler {
    
    // MARK: - Stamp
    func getCollectionOfStampsWithCompletion(dictionary: NSDictionary, completion: () -> ()) {
        guard let data = dictionary.object(forKey: "data") as? NSArray else {
            completion()
            return
        }
        
        var stamps = [Stamp]()
        for element in data {
            guard let elementDictionary = element as? NSDictionary else { continue }
            getCategory(dictionary: elementDictionary.object(forKey: "category") as? NSDictionary)
            
            guard let status = elementDictionary.object(forKey: "active") as? Bool else { continue }
            if !status { continue }
            
            guard let id = elementDictionary.object(forKey: "id") as? Int else { continue }
            guard let name = elementDictionary.object(forKey: "name") as? String else { continue }
            guard let categoryName = elementDictionary.value(forKeyPath: "category.name") as? String else { continue }
            guard let stampImageString = elementDictionary.object(forKey: "stampLargeImagePath") as? String else { continue }
            guard let stampLongDescription = elementDictionary.object(forKey: "stampLongDescription") as? String else { continue }
            guard let stampShortDescription = elementDictionary.object(forKey: "stampShortDescription") as? String else { continue }
            guard let stampName = elementDictionary.object(forKey: "stampName") as? String else { continue }
            guard let stampPrice = elementDictionary.object(forKey: "stampPrice") as? String else { continue }
            guard let artistName = elementDictionary.value(forKeyPath: "user.name") as? String else { continue }
            guard let artistEmail = elementDictionary.value(forKeyPath: "user.email") as? String else { continue }
            
            let stampImage = URL(string: stampImageString)
            
            guard let stamp = Stamp(
                id: id,
                name: name,
                categoryName: categoryName,
                stampImage: stampImage,
                stampLongDescription: stampLongDescription,
                stampShortDescription: stampShortDescription,
                stampName: stampName,
                stampPrice: stampPrice,
                artistName: artistName,
                artistEmail: artistEmail
                ) else { continue }
            stamps.append(stamp)
        }
        
        SessionHandler.shared.stampsCollection = stamps
        completion()
    }
    
    // MARK: - Category
    func getCategory(dictionary: NSDictionary?) {
        guard let name = dictionary?.object(forKey: "name") as? String else { return }
        guard let status = dictionary?.object(forKey: "active") as? Bool else { return }
        
        guard let category = Category(name: name, status: status) else { return }
        if !SessionHandler.shared.categoriesCollection.contains(where: { $0.name == category.name}) {
            SessionHandler.shared.categoriesCollection.append(category)
        }
    }
    
    // MARK: - Shirt
    func getCollectionOfShirtsWithCompletion(dictionary: NSDictionary, completion: () -> ()) {
        guard let data = dictionary.object(forKey: "data") as? NSArray else {
            completion()
            return
        }
        
        var shirts = [Shirt]()
        for element in data {
            guard let elementDictionary = element as? NSDictionary else { continue }
            
            guard let status = elementDictionary.object(forKey: "active") as? Bool else { continue }
            if !status { continue }
            
            guard let id = elementDictionary.object(forKey: "id") as? Int else { continue }
            guard let name = elementDictionary.object(forKey: "name") as? String else { continue }
            guard let color = elementDictionary.object(forKey: "shirtColor") as? String else { continue }
            guard let gender = elementDictionary.object(forKey: "shirtSex") as? String else { continue }
            guard let imageUrlString = elementDictionary.object(forKey: "shirtSmallImagePath") as? String else { continue }
            guard let price = elementDictionary.object(forKey: "shirtPrice") as? String else { continue }
            
            let url = URL(string: imageUrlString)
            
            guard let shirt = Shirt(id: id, status: status, name: name, color: color, gender: gender, imageUrl: url, price: price) else { continue }
            shirts.append(shirt)
        }
        
        SessionHandler.shared.shirtsCollection = shirts
        completion()
    }
    
    // MARK: - User
    
    func getUserFrom(dictionary: NSDictionary, billing: NSDictionary, completion: @escaping (_ succeeded: Bool) -> ()) {
        guard let id = billing.object(forKey: "id") as? Int,
            let city = billing.object(forKey: "userCity") as? String,
            let country = billing.object(forKey: "userCountry") as? String,
            let cvv = billing.object(forKey: "cvv") as? String,
            let expirationDate = billing.object(forKey: "expirationDate") as? String,
            let phoneNumber = billing.object(forKey: "phoneNumber") as? String,
            let userAddress = billing.object(forKey: "userAddress") as? String,
            let userCreditCard = billing.object(forKey: "userCreditCard") as? String,
            let nameCard = billing.object(forKey: "nameCard") as? String else {
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

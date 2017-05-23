//
//  ParserHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

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
            advanceSearch:          advanceSearch,
            productRating:          productRating,
            shirtText:              shirtText,
            messages:               messages,
            filters:                filters,
            privateStamp:           privateStamp,
            loginSocialNetwork:     loginSocialNetwork,
            shareSocialNetwork:     shareSocialNetwork,
            changePassword:         changePassword,
            changeAddress:          changeAddress,
            ratingsReports:         ratingsReports,
            sellReports:            sellReports) else {
                print("Init of variability failed")
                completion(false)
                return
        }
        
        SessionHandler.shared.listOfFeatures = variability
        completion(true)
    }
    
    
    // MARK: - Stamp
    func getCollectionOfStampsWithCompletion(dictionary: NSArray, privateStamps: Bool, completion: () -> ()) {
    
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
                imagePath: stampImage,
                isPrivate: privateStamps,
                rating: elementDictionary.object(forKey: "stamp_rating") as? Int,
                blackAndWhite: elementDictionary.object(forKey: "stamp_blackwhite") as? String,
                negative: elementDictionary.object(forKey: "stamp_negative") as? String
                ) else { continue }
            stamps.append(stamp)
            
            if !SessionHandler.shared.stampsCollection.contains(where: { $0.id == stamp.id }) {
                SessionHandler.shared.stampsCollection.append(stamp)
            } else if let index = SessionHandler.shared.stampsCollection.index(where: { $0.id == stamp.id }) {
                SessionHandler.shared.stampsCollection[index] = stamp
            }
            
        }
        
        SessionHandler.shared.stampsCollection.sort(by: { $0.isPrivate && !$1.isPrivate })
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
            let didUserLoggedWithDB = billing.value(forKeyPath: "user_id.base_datos") as? Bool,
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
        
        guard let user = User(id: id, city: city, country: country, cvv: cvv, email: email, expDate: expirationDate, phoneNumber: phoneNumber, surname: surname, userAddress: userAddress, userCreditCard: userCreditCard, username: username, nameCard: nameCard, didUserLoggedWithDB: didUserLoggedWithDB) else {
            completion(false)
            return
        }
        
        SessionHandler.shared.loggedUser = user
        completion(true)
        
    }
    
    // MARK: - Message
    func getCollectionOfMessages(array: NSArray, completion: () -> ()) {
        
        if array.count == 0 {
            SessionHandler.shared.messagesCollection.removeAll()
            completion()
        } else {
            for element in array {
                guard let elementDictionary = element as? NSDictionary else { continue }
                
                guard let id = elementDictionary.object(forKey: "message_id") as? Int else { continue }
                guard let from = elementDictionary.object(forKey: "message_from") as? String else { continue }
                guard let to = elementDictionary.object(forKey: "message_to") as? String else { continue }
                guard let subject = elementDictionary.object(forKey: "message_subject") as? String else { continue }
                guard let content = elementDictionary.object(forKey: "message_content") as? String else { continue }
                
                guard let message = Message(
                    id: id,
                    from: from,
                    to: to,
                    subject: subject,
                    content: content,
                    parentMessage: elementDictionary.object(forKey: "parent_message") as? Int
                    ) else { return }
                
                if let index = SessionHandler.shared.messagesCollection.index(where: { $0.compare(toMessage: message) }) {
                    SessionHandler.shared.messagesCollection[index] = message
                } else {
                    SessionHandler.shared.messagesCollection.append(message)
                }
            }
        
            completion()
        }
    }
    
    // MARK: - Orders
    func getCollectionOfOrders(body: NSArray, completion: ()->()) {
        for element in body {
            guard let dictionary = element as? NSDictionary else { continue }
            guard let orderDictionary = dictionary.object(forKey: "order") as? NSDictionary else { continue }
            guard let productsArray = dictionary.object(forKey: "products") as? NSArray else { continue }
            
            guard let order = getOrder(order: orderDictionary) else { continue }
            let products = getAllProducts(productsArray: productsArray)
            
            if products.isEmpty {
                continue
            }
            order.products = products
            
            if let index = SessionHandler.shared.orders.index(where: { $0.compare(toOrder: order) }) {
                SessionHandler.shared.orders[index] = order
            } else {
                SessionHandler.shared.orders.append(order)
            }
        }
        
        completion()
    }
    
    private func getOrder(order: NSDictionary) -> Order? {
        guard let deliveryAddress = order.object(forKey: "delivery_address") as? String,
            let contactPhone = order.object(forKey: "contact_phone") as? String,
            let city = order.object(forKey: "city") as? String,
            let country = order.object(forKey: "country") as? String else { return nil }
        let products = [Product]()
        guard let order = Order(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country, products: products) else {
            return nil
        }
        
        return order
    }
    
    private func getAllProducts(productsArray: NSArray) -> [Product] {
        var products = [Product]()
        for element in productsArray {
            guard let dictionary = element as? NSDictionary else { continue }
            
            guard let stampID = dictionary.object(forKey: "stamp_id") as? Int,
                let shirtID = dictionary.object(forKey: "shirt_id") as? Int,
                let quantity = dictionary.object(forKey: "quantity") as? Int,
                let shirtSize = dictionary.object(forKey: "shirt_size") as? String,
                let stampLocation = dictionary.object(forKey: "shirt_location") as? String,
                let stampImage = dictionary.object(forKey: "stamp_url") as? String else { continue }
            
            guard let imageURL = URL(string: stampImage.replacingOccurrences(of: " ", with: "")) else { continue }
            
            
            guard let product = Product(
                stampID: stampID,
                shirtID: shirtID,
                quantity: quantity,
                size: shirtSize,
                location: stampLocation,
                text: dictionary.object(forKey: "text") as? String,
                textColor: getColor(valueString: dictionary.object(forKey: "text_color") as? String),
                textSize: dictionary.object(forKey: "text_size") as? String,
                textLocation: stampLocation,
                imageUrl: imageURL) else { continue }
            
            products.append(product)
        }
        return products
    }
    
    private func getColor(valueString: String?) -> UIColor? {
        guard let valueString = valueString else { return nil }
        guard let intValue = Int(valueString) else { return nil }
        return UIColor(netHex: intValue)
    }
}

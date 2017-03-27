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
}

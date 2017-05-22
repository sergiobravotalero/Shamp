//
//  SessionHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class SessionHandler {
    static let shared = SessionHandler()
    private init() {}

    var listOfFeatures: Variability?
    var loggedUser: User?
    var stampsCollection = [Stamp]()
    var shirtsCollection = [Shirt]()
    var categoriesCollection = [Category]()
    var artistsCollection = [String]()
    var messagesCollection = [Message]()
    
    func removeAll() {
        listOfFeatures = nil
        loggedUser = nil
        stampsCollection.removeAll()
        shirtsCollection.removeAll()
        categoriesCollection.removeAll()
        artistsCollection.removeAll()
        messagesCollection.removeAll()
    }
}

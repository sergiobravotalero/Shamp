//
//  UserDefaiultsHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation


class UserDefaultsHandler {
    static let shared = UserDefaultsHandler()
    private init() {}
    
    let defaults = UserDefaults.standard
    
    var token: String? {
        get {
            if let value = defaults.object(forKey: "token") as? String {
                return value
            } else {
                return nil
            }
        } set (newVal) {
            defaults.set(newVal, forKey: "token")
        }
    }
    
    var userCredentials: (email: String, password: String)? {
        get {
            if let email = defaults.object(forKey: "email") as? String, let password = defaults.object(forKey: "password") as? String {
                return (email: email, password: password)
            } else {
                return nil
            }
        } set (newVal) {
            defaults.set(newVal!.email, forKey: "email")
            defaults.set(newVal!.password, forKey: "password")
        }
    }
    
    func removeAll() {
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "password")
    }
    
}

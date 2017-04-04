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
    
    var userCredentials: (username: String, password: String)? {
        get {
            if let username = defaults.object(forKey: "username") as? String, let password = defaults.object(forKey: "password") as? String {
                return (username: username, password: password)
            } else {
                return nil
            }
        } set (newVal) {
            defaults.set(newVal!.username, forKey: "username")
            defaults.set(newVal!.password, forKey: "password")
        }
    }    
}

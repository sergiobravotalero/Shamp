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
    
    var stampsCollection = [Stamp]()
    var shirtsCollection = [Shirt]()
    var categoriesCollection = [Category]()
}

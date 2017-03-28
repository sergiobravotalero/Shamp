//
//  Category.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Category {
    let name: String
    let status: Bool
    
    init?(name: String, status: Bool) {
        self.name = name
        self.status = status
    }
}

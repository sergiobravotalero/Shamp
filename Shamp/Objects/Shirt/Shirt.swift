//
//  Shirt.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Shirt {
    let id: Int
    let status: Bool
    let name: String
    let color: String
    let gender: String
    let imageUrl: URL?
    
    init?(id: Int, status: Bool, name: String, color: String, gender: String, imageUrl: URL?) {
        self.id = id
        self.status = status
        self.name = name
        self.color = color
        self.gender = gender
        self.imageUrl = imageUrl
    }
}

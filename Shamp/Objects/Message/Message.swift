//
//  Message.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

class Message {
    let id: Int
    let from: String
    let to: String
    let subject: String
    let content: String
    let parentMessage: Int?
    
    init?(id: Int, from: String, to: String, subject: String, content: String, parentMessage: Int?) {
        self.id = id
        self.from = from
        self.to = to
        self.subject = subject
        self.content = content
        self.parentMessage = parentMessage
    }
    
    func compare(toMessage: Message) -> Bool {
        return self.from == toMessage.from && self.to == toMessage.to && self.subject == toMessage.subject && self.content == toMessage.content && self.parentMessage == toMessage.parentMessage
    }
}

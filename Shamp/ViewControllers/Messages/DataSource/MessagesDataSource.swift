//
//  MessagesDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

class MessagesDataSource: NSObject, UITableViewDataSource {
    
    var messageController: MessagesViewController!
    var messages = [Message]()
    
    // MARK: - Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        cell.configureCell(message: message)
        cell.delegate = messageController
        return cell
    }
}

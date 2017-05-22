//
//  MessageCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import FCAlertView

extension MessagesViewController: MessageTableViewCellDelegate {
    
    func userTappedReplyButton(message: Message) {
        let alert = FCAlertView()
        
        alert.addTextField(withPlaceholder: "Enter your message", andTextReturn: { (text) in
            
        })
        
        alert.addButton("Cancel", withActionBlock: nil)
        
        alert.doneActionBlock({ (action) in
            guard let text = alert.textField.text else { return }

            RequesterHandler().replyMessage(message: message, content: text, completion: { (result) in
                if result {
                    AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: nil, message: "Message Sent")
                    self.refreshTableView(message: message)
                } else {
                    AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Sorry", message: "There was an error sending your message. Try again.")
                }
            })
        })
        
        alert.firstButtonTitleColor = UIColor.signatureYellow()
        alert.doneButtonTitleColor = UIColor.signatureYellow()
        
        alert.showAlert(withTitle: "New message", withSubtitle: "Reply to artist \(message.from)", withCustomImage: #imageLiteral(resourceName: "Andes Logo"), withDoneButtonTitle: "Send", andButtons: nil)
    }
    
    func refreshTableView(message: Message) {
        if let index = dataSource.messages.index(where: { $0.compare(toMessage: message) }) {
            dataSource.messages.remove(at: index)
            
            if !dataSource.messages.isEmpty {
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            } else {
                tableView.reloadData()
            }
        }
    }
}

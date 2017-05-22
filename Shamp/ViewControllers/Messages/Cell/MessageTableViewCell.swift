//
//  MessageTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

protocol MessageTableViewCellDelegate {
    func userTappedReplyButton(message: Message)
}

class MessageTableViewCell: UITableViewCell {

    var message: Message!
    var delegate: MessageTableViewCellDelegate?
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Method
    
    func configureCell(message: Message) {
        
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        borderView.layer.borderWidth = 0.7
        borderView.layer.borderColor = UIColor.black.cgColor
        
        fromLabel.text = message.from
        contentLabel.text = message.content
        self.message = message
    }
    
    @IBAction func replyButtonTapped(_ sender: Any) {
        delegate?.userTappedReplyButton(message: message)
    }
    
}

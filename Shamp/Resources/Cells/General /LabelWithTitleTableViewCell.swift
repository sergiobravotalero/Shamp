//
//  LabelWithTitleTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/28/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class LabelWithTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Method
    func configureCell(title: String, placeholder: String) {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        titleLabel.text = title
        textField.placeholder = placeholder
        
        if title == "Contact Phone" || title == "Phone Number" || title == "Expiration Date" || title == "Card Number" || title == "CVV"{
            textField.keyboardType = .numberPad
        } else if title == "Email"{
            textField.keyboardType = .emailAddress
        } else {
            textField.keyboardType = .default
        }
        
        if title == "Password" || title == "Confirm Password" {
            textField.isSecureTextEntry = true
        } else {
            textField.isSecureTextEntry = false
        }
    }
    
}

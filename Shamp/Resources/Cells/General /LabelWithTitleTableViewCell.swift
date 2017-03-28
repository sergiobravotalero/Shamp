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
        
        textField.keyboardType = title == "Contact Phone" ? .numberPad : .default
    }
    
}

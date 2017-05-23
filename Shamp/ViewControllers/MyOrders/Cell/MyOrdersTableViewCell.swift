//
//  MyOrdersTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func configureCell(title: String, value: String) {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        leftTextLabel.text = title
        rightTextLabel.text = value
    }
}

//
//  CellWithArrowTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class CellWithArrowTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Method
    func configureCell(name: String) {
        selectionStyle = .none
        nameLabel.text = name
    }
}

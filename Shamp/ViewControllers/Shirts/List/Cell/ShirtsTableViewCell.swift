//
//  ShirtsTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import Kingfisher

protocol ShirtCellDelegate {
    func userDidSelectShirt(shirt: Shirt)
}

class ShirtsTableViewCell: UITableViewCell {
    
    var currentShirt: Shirt!
    var delegate: ShirtCellDelegate?

    @IBOutlet weak var shirtImage: UIImageView!
   
    @IBOutlet weak var shirtNameLabel: UILabel!
    @IBOutlet weak var shirtColorLabel: UILabel!
    @IBOutlet weak var shirtGenderLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Method
    func configureCell(shirt: Shirt) {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        currentShirt = shirt
        
        shirtNameLabel.text = shirt.name
        shirtColorLabel.text = shirt.color
        shirtGenderLabel.text = shirt.gender
        
        
        if let url = shirt.imageUrl {
            shirtImage.kf.setImage(with: url)
        }
    }
    // MARK: - IBAction
    @IBAction func selectThisShirtTapped(_ sender: Any) {
        delegate?.userDidSelectShirt(shirt: currentShirt)
    }
}

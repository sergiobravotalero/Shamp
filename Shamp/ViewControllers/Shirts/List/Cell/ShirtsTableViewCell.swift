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

    @IBOutlet weak var borderView: UIView!
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
        
        borderView.layer.borderWidth = 0.7
        borderView.layer.borderColor = UIColor.black.cgColor
        
        currentShirt = shirt
        
        shirtNameLabel.text = shirt.name
        shirtColorLabel.text = shirt.color
        shirtGenderLabel.text = shirt.sex
        
        shirtImage.kf.setImage(with: shirt.largeImagePath)
    }
    // MARK: - IBAction
    @IBAction func selectThisShirtTapped(_ sender: Any) {
        delegate?.userDidSelectShirt(shirt: currentShirt)
    }
}

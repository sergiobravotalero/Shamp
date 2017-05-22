//
//  StampTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import Kingfisher

protocol StampCellDelegate {
    func userDidSelectStamp(stamp: Stamp)
}

class StampTableViewCell: UITableViewCell {
    
    var stamp: Stamp!
    var delegate: StampCellDelegate?
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var stampImage: UIImageView!
    @IBOutlet weak var stampNameLabel: UILabel!
    @IBOutlet weak var stampDescriptionLabel: UILabel!
    @IBOutlet weak var stampPriceLabel: UILabel!
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func configureCell(stamp: Stamp) {
        self.stamp = stamp
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        borderView.layer.borderWidth = 0.7
        borderView.layer.borderColor = UIColor.black.cgColor
        
        artistNameLabel.text = stamp.artistEmail
        stampNameLabel.text = stamp.name
        stampDescriptionLabel.text = stamp.shortDescription
        stampPriceLabel.text = "$\(stamp.price)"
        
        stampImage.kf.setImage(with: stamp.imagePath)
        
        if let rating = stamp.rating {
            starImage.isHidden = false
            rateLabel.isHidden = false
            
            rateLabel.text = "\(rating)"
        } else {
            starImage.isHidden = true
            rateLabel.isHidden = true
        }
    }
    
    // MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        delegate?.userDidSelectStamp(stamp: stamp)
    }
}

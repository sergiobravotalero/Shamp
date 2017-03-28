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
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var stampImage: UIImageView!
    @IBOutlet weak var stampNameLabel: UILabel!
    @IBOutlet weak var stampDescriptionLabel: UILabel!
    @IBOutlet weak var stampPriceLabel: UILabel!
    
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
        
        artistNameLabel.text = stamp.artistName
        stampNameLabel.text = stamp.stampName
        stampDescriptionLabel.text = stamp.stampLongDescription
        stampPriceLabel.text = "$" + stamp.stampPrice
        
        if let url = stamp.stampImage {
            stampImage.kf.setImage(with: url)
        }
    }
    
    // MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        delegate?.userDidSelectStamp(stamp: stamp)
    }
}

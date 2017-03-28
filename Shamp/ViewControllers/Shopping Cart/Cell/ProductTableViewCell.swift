//
//  ProductTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    var currentProduct: Product!
    
    @IBOutlet weak var stampImage: UIImageView!
    @IBOutlet weak var shirtImage: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func configureCell(product: Product) {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        currentProduct = product
        
        quantityLabel.text = "\(product.quantity)"
        locationLabel.text = product.location
        priceLabel.text = "$25.000"
        
        setupImages(stampID: product.stampID, shirtID: product.shirtID)
    }
    
    private func setupImages(stampID: Int, shirtID: Int) {
        if let stamp = SessionHandler.shared.stampsCollection.first(where: { $0.id == stampID }) {
            if let url = stamp.stampImage {
                stampImage.kf.setImage(with: url)
            }
        }
        
        if let shirt = SessionHandler.shared.shirtsCollection.first(where: { $0.id == shirtID }) {
            if let url = shirt.imageUrl {
                shirtImage.kf.setImage(with: url)
            }
        }
        
        stampImage.layer.borderColor = UIColor.black.cgColor
        stampImage.layer.borderWidth = 1.5
        
        shirtImage.layer.borderColor = UIColor.black.cgColor
        shirtImage.layer.borderWidth = 1.5
    }
    
    // MARK: - IBAction
    @IBAction func remoevPoructButtonTapped(_ sender: Any) {
        print(currentProduct.location)
    }
}

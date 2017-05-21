//
//  ProductTableViewCell.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import Kingfisher
import Toucan

protocol ProductCellDelegate {
    func productWasRemoved()
}

class ProductTableViewCell: UITableViewCell {

    var delegate: ProductCellDelegate?
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
        priceLabel.text = "$\(product.getProductPrice())"
        
        setupImages(stampID: product.stampID, shirtID: product.shirtID)
    }
    
    private func setupImages(stampID: Int, shirtID: Int) {
        if let stamp = SessionHandler.shared.stampsCollection.first(where: { $0.id == stampID }) {
            KingfisherManager.shared.retrieveImage(with: stamp.imagePath, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                if let image = image {
                    let editedImage = Toucan(image: image).maskWithEllipse(borderWidth: 10.0, borderColor: UIColor.black).image
                    self.stampImage.image = editedImage
                }
            })
        }
        
        if let shirt = SessionHandler.shared.shirtsCollection.first(where: { $0.id == shirtID }) {
            KingfisherManager.shared.retrieveImage(with: shirt.largeImagePath, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                if let image = image {
                    self.shirtImage.image = Toucan(image: image).maskWithEllipse(borderWidth: 10.0, borderColor: UIColor.black).image
                }
            })
        }
        
    }
    
    // MARK: - IBAction
    @IBAction func remoevPoructButtonTapped(_ sender: Any) {
        ShoppingCart.shared.removeProduct(product: currentProduct)
        delegate?.productWasRemoved()
    }
}

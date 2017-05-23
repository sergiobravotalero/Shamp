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
    
    @IBOutlet weak var borderLayer: UIView!
    
    // TEXT Constraints
    @IBOutlet var textConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var textLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textLabelHeightGreaterThanConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var customizedTextLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontColorLabel: UILabel!
    @IBOutlet weak var textLocationLabel: UILabel!
    
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
        
        borderLayer.layer.borderWidth = 0.7
        borderLayer.layer.borderColor = UIColor.black.cgColor
        
        stampImage.layer.borderWidth = 1
        stampImage.layer.borderColor = UIColor.black.cgColor
        
        shirtImage.layer.borderWidth = 1
        shirtImage.layer.borderColor = UIColor.black.cgColor
        
        currentProduct = product
        
        quantityLabel.text = "\(product.quantity)"
        locationLabel.text = product.location
        priceLabel.text = "$\(product.getProductPrice())"
        
        setupImages(stampUrl: product.imageUrl, shirtID: product.shirtID)
        
        
        if let shirtText = SessionHandler.shared.listOfFeatures?.shirtText, shirtText{
            guard let customizedText = product.text, let size = product.textSize, let color = product.textColor, let textLocation = product.textLocation else {
                
                textLabelHeightGreaterThanConstraint.isActive = false
                textLabelHeightConstraint.isActive = true
                
                textLabelHeightConstraint.constant = 0
                for constraint in textConstraints {
                    constraint.constant = 0
                }
                
                return
            }
            
            textLabelHeightGreaterThanConstraint.isActive = true
            textLabelHeightConstraint.isActive = false
            
            customizedTextLabel.text = customizedText
            fontSizeLabel.text = size
            fontColorLabel.backgroundColor = color
            textLocationLabel.text = textLocation
            
        } else {
            textLabelHeightGreaterThanConstraint.isActive = false
            textLabelHeightConstraint.isActive = true
            
            textLabelHeightConstraint.constant = 0
            
            for constraint in textConstraints {
                constraint.constant = 0
            }
        }
    }
    
    private func setupImages(stampUrl: URL, shirtID: Int) {
        
        KingfisherManager.shared.retrieveImage(with: stampUrl, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
            if let image = image {
                self.stampImage.image = image
            }
        })
        
        if let shirt = SessionHandler.shared.shirtsCollection.first(where: { $0.id == shirtID }) {
            KingfisherManager.shared.retrieveImage(with: shirt.largeImagePath, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                if let image = image {
                    self.shirtImage.image = image
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

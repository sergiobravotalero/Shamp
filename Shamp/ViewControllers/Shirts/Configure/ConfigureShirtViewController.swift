//
//  ConfigureShirtViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class ConfigureShirtViewController: UIViewController {

    var shirt: Shirt!
    var stamp: Stamp!
    
    var selectedShirtSize: String?
    var selectedLocation: String?
    
    var shirtSizes = ["X-Small", "Small", "Medium", "Large", "X-Large"]
    var location = ["Chest", "Back", "Left Shoulder", "Right Shoulder"]
    
    let pickerView = UIPickerView()
    
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Methods
    private func setupController() {
        setupNavigationBar()
        setupPickerView()
        
        sizeTextField.tag = 0
        locationTextField.tag = 1
        
        sizeTextField.delegate = self
        locationTextField.delegate = self
    }

    private func setupNavigationBar() {
        title = "Configure The Shirt"
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back Arrow"), style: .plain, target: self, action: #selector(backButtonTapped(sender:)))
        backButton.tintColor = UIColor.signatureGray()
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonTapped(sender:UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: - IBAction
    
    
    @IBAction func placeOrderTapped(_ sender: Any) {
        guard let selectedShirtSize = selectedShirtSize, let selectedLocation = selectedLocation, let quantity = quantityTextField.text else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all fields in order to add to cart")
            return
        }
        
        guard let quantityNumber = Int(quantity) else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Ooops", message: "Something went wrong. Please try again.")
            return
        }
        
        if quantityNumber <= 0 {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "The quantity of shirts has to be greater than zero")
            return
        }
        
        guard let product = Product(stampID: stamp.id, shirtID: shirt.id, quantity: quantityNumber, size: selectedShirtSize, location: selectedLocation) else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Ooops", message: "Something went wrong. Please try again.")
            return
        }
        
        ShoppingCart.shared.addProductToShoppingCart(product: product)
        navigationController?.popToRootViewController(animated: true)
    }
}

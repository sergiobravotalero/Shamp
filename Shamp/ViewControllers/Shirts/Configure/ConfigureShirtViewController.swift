//
//  ConfigureShirtViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import ChromaColorPicker

class ConfigureShirtViewController: UIViewController, ChromaColorPickerDelegate {

    var shirt: Shirt!
    var stamp: Stamp!
    
    var selectedShirtSize: String?
    var selectedLocation: String?
    var selectedFontSize: String?
    var selectedFontLocation: String?
    
    var shirtSizes = ["X-Small", "Small", "Medium", "Large", "X-Large"]
    var location = ["Chest", "Back", "Left Shoulder", "Right Shoulder"]
    var fontSizes = ["Small", "Medium", "Big"]
    
    let pickerView = UIPickerView()
    
    @IBOutlet weak var selectedColorLabel: UILabel!
    
    @IBOutlet weak var cutomizedTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var fontSizeTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var fontLocation: UITextField!
    
    @IBOutlet var viewsOfShirtText: [UIView]!
    
    @IBOutlet weak var colorPickerView: UIView!
    
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
        locationTextField.tag = 2
        fontSizeTextField.tag = 4
        fontLocation.tag = 6
        
        sizeTextField.delegate = self
        locationTextField.delegate = self
        fontSizeTextField.delegate = self
        fontLocation.delegate = self
        
        if let shirtText = SessionHandler.shared.listOfFeatures?.shirtText, shirtText {
            print("Shirt Text enabled")
        } else {
            for view in viewsOfShirtText {
                view.removeFromSuperview()
            }
        }
    }

    private func setupNavigationBar() {
        title = "Configure The Shirt"
        
        navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back Arrow"), style: .plain, target: self, action: #selector(backButtonTapped(sender:)))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addButtonTapped(sender:)))
        addButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = addButton
        
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func backButtonTapped(sender:UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addButtonTapped(sender: UIBarButtonItem){
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
        
        if let shirtText = SessionHandler.shared.listOfFeatures?.shirtText, shirtText {
            guard let customizedText = cutomizedTextField.text, let selectedFontSize = selectedFontSize, let selectedColor = selectedColorLabel.backgroundColor, let fontLocation = fontLocation.text else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all fields in order to add to cart")
                return
            }
            
            if customizedText.replacingOccurrences(of: " ", with: "") == "" {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all fields in order to add to cart")
                return
            }
            
            if selectedColor == UIColor.clear || selectedColor == UIColor.white {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Please select a different color")
                return
            }
            
            guard let product = Product(stampID: stamp.id, shirtID: shirt.id, quantity: quantityNumber, size: selectedShirtSize, location: selectedLocation, text: customizedText, textColor: selectedColor, textSize: selectedFontSize, textLocation: fontLocation, imageUrl: stamp.imagePath) else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Ooops", message: "Something went wrong. Please try again.")
                return
            }
            
            checkIfWantsToApplyFilter(product: product)
        } else {
            guard let product = Product(stampID: stamp.id, shirtID: shirt.id, quantity: quantityNumber, size: selectedShirtSize, location: selectedLocation, text: nil, textColor: nil, textSize: nil, textLocation: nil, imageUrl: stamp.imagePath) else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Ooops", message: "Something went wrong. Please try again.")
                return
            }
            
            checkIfWantsToApplyFilter(product: product)
        }
    }
    
    func checkIfWantsToApplyFilter(product: Product) {
        guard let filters = SessionHandler.shared.listOfFeatures?.filters, filters else {
            addOrderToShoppingCart(product: product)
            return
        }
        
        guard let blackAndWhite = stamp.blackAndWhite, let negative = stamp.negative else {
            addOrderToShoppingCart(product: product)
            return
        }
        
        guard let blackAndWhiteUrl = URL(string: blackAndWhite), let negativeUrl = URL(string: negative) else {
            addOrderToShoppingCart(product: product)
            return
        }
        
        // Present Alert Controller
        let alertController = UIAlertController(title: "Hey!", message: "Do you want to add a filter to the selected stamp?", preferredStyle: .alert)
        
        let noFilterAction = UIAlertAction(title: "No filter", style: .default, handler: { (action) in
            self.addOrderToShoppingCart(product: product)
        })
        alertController.addAction(noFilterAction)
        
        let blackAndWhiteFilter = UIAlertAction(title: "Black and White", style: .default, handler: { (action) in
            product.imageUrl = blackAndWhiteUrl
            self.addOrderToShoppingCart(product: product)
        })
        alertController.addAction(blackAndWhiteFilter)
        
        let negativeFilter = UIAlertAction(title: "Negative", style: .default, handler: { (action) in
            product.imageUrl = negativeUrl
            self.addOrderToShoppingCart(product: product)
        })
        alertController.addAction(negativeFilter)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        alertController.view.tintColor = UIColor.signatureYellow()
        present(alertController, animated: true, completion: {
            alertController.view.tintColor = UIColor.signatureYellow()
        })
    }
    
    func addOrderToShoppingCart(product: Product) {
        
        
        let alertController = UIAlertController(title: nil, message: "Your product was added to your shopping cart.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: nil, message: "Your product was added to your shopping cart.")
            ShoppingCart.shared.addProductToShoppingCart(product: product)
            self.navigationController?.popToRootViewController(animated: true)
        })
        alertController.addAction(okAction)
        
        alertController.view.tintColor = UIColor.signatureYellow()
        present(alertController, animated: true, completion: {
            alertController.view.tintColor = UIColor.signatureYellow()
        })
    }

    // MARK: - IBAction
    @IBAction func chooseColorTapped(_ sender: Any) {
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self //ChromaColorPickerDelegate
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 3
        neatColorPicker.hexLabel.textColor = UIColor.white
        neatColorPicker.center = colorPickerView.center
        colorPickerView.addSubview(neatColorPicker)
        colorPickerView.isHidden = false
    }
    
    // MARK:  Delegate
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        selectedColorLabel.backgroundColor = color
        colorPickerView.isHidden = true
    }
}

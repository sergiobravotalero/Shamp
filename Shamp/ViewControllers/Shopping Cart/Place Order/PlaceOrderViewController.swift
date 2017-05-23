//
//  PlaceOrderViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/28/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import SVProgressHUD
import LocalAuthentication
import FCAlertView

class PlaceOrderViewController: UIViewController {

    var deliveryAddress: String?
    var contactPhone: String?
    var city: String?
    var country: String?
    
    let authenticationContext = LAContext()
    let dataSource = PlaceOrderDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    // MARK: - Methods
    private func setupController() {
        setupTable()
        setupNavigationBar()
    }
    
    private func setupTable() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(UINib(nibName: "LabelWithTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelWithTitleTableViewCell")
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "Place Order"
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back Arrow"), style: .plain, target: self, action: #selector(backButtonTapped(sender:)))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonTapped(sender:UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func proceedToPay(callback: @escaping(_ result: Bool) -> ()) {
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Allow to be charged to your credit card", reply: { (success, error) in
            if success {
                callback(true)
                return
            } else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Error", message: "Your authentication failed")
                callback(false)
            }
        })
    }
    
    func payWithoutFingerprint(result: @escaping(_ result: Bool) -> ()) {
        let alertController = UIAlertController(title: "Place Order", message: "Confir your card cvv to proceed", preferredStyle: .alert)
        
        let payAction = UIAlertAction(title: "Pay", style: .destructive, handler: {
            alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            guard let cvvText = firstTextField.text else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Error", message: "Somwthing went wrong. Please try again.")
                result(false)
                return
            }
            
            guard let cvv = SessionHandler.shared.loggedUser?.cvv else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Error", message: "Somwthing went wrong. Please try again.")
                result(false)
                return
            }
            
            if cvvText == cvv {
                result(true)
                return
            } else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "The security code does not match to the one of your card")
                result(false)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter your card cvv"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(payAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor.red
        
        self.present(alertController, animated: true, completion: {
            alertController.view.tintColor = UIColor.red
        })

    }
    
    func placerOrder(deliveryAddress: String, contactPhone: String, city: String, country: String) {
        SVProgressHUD.show()
        ShoppingCart.shared.placeOrderWithCompletion(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country, completion: { (succeeded) in
            SVProgressHUD.dismiss()
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    
    // MARK: - IBAction
    @IBAction func placeOrderButtonTapped(_ sender: Any) {
        for index in 0...3 {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! LabelWithTitleTableViewCell
            
            guard let inputText = cell.textField.text else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all fields")
                return
            }
            
            if inputText == "" {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Blank fields are not allowed")
                return
            }
            
            switch index {
            case 0:
                deliveryAddress = inputText
            case 1:
                contactPhone = inputText
            case 2:
                city = inputText
            case 3:
                country = inputText
            default:
                break
            }
        }
        
        guard let deliveryAddress = deliveryAddress, let contactPhone = contactPhone, let city = city, let country = country else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Oooops", message: "Something went wrong. Please try again.")
            return }
        
        confirmPay(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country)
    }
    
    func confirmPay(deliveryAddress: String, contactPhone: String, city: String, country: String) {
        let alert = FCAlertView()
//        alert.makeAlertTypeWarning()
        
        alert.addButton("Cancel", withActionBlock: nil)
        
        alert.doneActionBlock({ (action) in
            self.payWithOption(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country)
        })
        
        alert.firstButtonTitleColor = UIColor.signatureYellow()
        alert.secondButtonTitleColor = UIColor.signatureYellow()
        
        alert.showAlert(withTitle: "Confirm the order", withSubtitle: "Are you sure you want to submit the order?", withCustomImage: nil, withDoneButtonTitle: "Submit", andButtons: nil)
    }
    
    func payWithOption(deliveryAddress: String, contactPhone: String, city: String, country: String) {
        var error:NSError?
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            payWithoutFingerprint(result: { (result) in
                self.placerOrder(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country)
            })
            return
        }
        
        proceedToPay(callback: { (succeeded) in
            self.placerOrder(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country)
        })
    }
}

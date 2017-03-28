//
//  PlaceOrderViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/28/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import SVProgressHUD

class PlaceOrderViewController: UIViewController {

    var deliveryAddress: String?
    var contactPhone: String?
    var city: String?
    var country: String?
    
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
        backButton.tintColor = UIColor.signatureGray()
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonTapped(sender:UIBarButtonItem) {
        let _ = self.navigationController?.popViewController(animated: true)
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
        
        SVProgressHUD.show()
        ShoppingCart.shared.placeOrderWithCompletion(deliveryAddress: deliveryAddress, contactPhone: contactPhone, city: city, country: country, completion: { (succeeded) in
            SVProgressHUD.dismiss()
            self.dismiss(animated: true, completion: nil)
        })
        
    }
}

//
//  SignUpViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    var isAttemptingFacebook = false
    var personalInfo: [String?] = ["","","","","","","", "", ""]
    var crediCardInfo: [String?] = ["","","",""]
    
    let dataSource = SignUpDataSource()

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Methods
    private func setupController () {
        setupTable()
    }
    
    private func setupTable() {
        dataSource.signupController = self
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(UINib(nibName: "LabelWithTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelWithTitleTableViewCell")
    }
    
    // MARK: - IBAction
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if personalInfo.contains(where: { $0 == "" }) {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all fields")
            return
        }
        
        if personalInfo[1] != personalInfo[2] {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Passwords don't match")
            return
        }
        
        if crediCardInfo.contains(where: { $0 == "" }) {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all fields")
            return
        }
        
        if crediCardInfo[1]?.characters.count != 16 {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Credit Card must haave 16 numbers")
            return
        }
        
        if crediCardInfo[2]?.characters.count != 5 {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Expiration Date are four numbers MM/YY")
            return
        }
        
        if !crediCardInfo[2]!.contains("/") {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Expiration Date format is MM/YY")
            return
        }
        
        if crediCardInfo[3]?.characters.count != 3 {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "CVV must be three numbers")
            return
        }
        
        let date = crediCardInfo[2]!
        let dateComponents = date.components(separatedBy: "/")
        let expirationDate = "01/\(dateComponents[0])/\(dateComponents[1])"
        
        let parameters = [
            "password": personalInfo[1]!,
            "username": personalInfo[0]!,
            "email": personalInfo[3]!,
            "surname": personalInfo[4]!,
            "city": personalInfo[5]!,
            "country": personalInfo[5]!,
            "phone_number": personalInfo[7]!,
            "user_address": personalInfo[8]!,
            
            "name_card": crediCardInfo[0]!,
            "user_credit_card": crediCardInfo[1]!,
            "expiration_date": expirationDate,
            "cvv": crediCardInfo[3]!,
            "base_datos": isAttemptingFacebook
        ] as! [String : Any]
        
        SVProgressHUD.show()
        RequesterHandler().registerUserInDbWith(parameters: parameters, callback: { (succeeded) in
            if succeeded {
                ViewControllersHandler().changeRootViewController(withName: "Home", window: self.view.window)
            } else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Ooops", message: "Something went wrong. Try Again.")
            }
            SVProgressHUD.dismiss()
        })
    }


}

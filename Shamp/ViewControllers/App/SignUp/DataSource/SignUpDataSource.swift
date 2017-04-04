//
//  SignUpDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

private enum PersonalInfo: Int {
    case UserName, Password, ConfirmPassword, Email, Surname, City, Country, PhoneNumber, UserAddress
    
    static let names = [
        UserName: "Username",
        Password: "Password",
        ConfirmPassword: "Confirm Password",
        Email: "Email",
        Surname: "Surname",
        City: "City",
        Country: "Country",
        PhoneNumber: "Phone Number",
        UserAddress: "User Address"
    ]
    
    static let placeholder = [
        UserName: "Enter your username",
        Password: "Type your password",
        ConfirmPassword: "Confirm your password",
        Email: "Enter your email",
        Surname: "Enter your surname",
        City: "On what city do you live",
        Country: "In what country do you live?",
        PhoneNumber: "What is your phone number?",
        UserAddress: "What is your home address?"
    ]
    
    func getCellInformation() -> (title: String, placeholder: String) {
        if let name = PersonalInfo.names[self], let placeholder = PersonalInfo.placeholder[self] {
            return (title: name, placeholder: placeholder)
        } else {
            return (title: "", placeholder: "")
        }
    }
}

private enum CreditInfo: Int {
    case NameCard, UserCreditCard, ExpDate, CVV
    
    static let names = [
        NameCard: "Cardholder name",
        UserCreditCard: "Card Number",
        ExpDate: "Expiration Date",
        CVV: "CVV"
    ]
    
    static let placeholder = [
        NameCard: "User name as appears on the card",
        UserCreditCard: "Enter the card number",
        ExpDate: "What is the expiration date?",
        CVV: "Enter the security code"
    ]
    
    func getCellInformation() -> (title: String, placeholder: String) {
        if let name = CreditInfo.names[self], let placeholder = CreditInfo.placeholder[self] {
            return (title: name, placeholder: placeholder)
        } else {
            return (title: "", placeholder: "")
        }
    }
}

class SignUpDataSource: NSObject, UITableViewDataSource {
    
    var signupController: SignUpViewController?
    
    // MARK: - Method
    func textFieldDidChange(textField: UITextField) {
        let tag = textField.tag
        
        switch tag {
            
        case 10:
            signupController?.personalInfo[0] = textField.text
        case 11:
            signupController?.personalInfo[1] = textField.text
        case 12:
            signupController?.personalInfo[2] = textField.text
        case 13:
            signupController?.personalInfo[3] = textField.text
        case 14:
            signupController?.personalInfo[4] = textField.text
        case 15:
            signupController?.personalInfo[5] = textField.text
        case 16:
            signupController?.personalInfo[6] = textField.text
        case 17:
            signupController?.personalInfo[7] = textField.text
        case 18:
            signupController?.personalInfo[8] = textField.text
            
        case 20:
            signupController?.crediCardInfo[0] = textField.text
        case 21:
            signupController?.crediCardInfo[1] = textField.text
        case 22:
            signupController?.crediCardInfo[2] = textField.text
        case 23:
            signupController?.crediCardInfo[3] = textField.text
            
        default:
            break
        }
    }
    
    // MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 9 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithTitleTableViewCell", for: indexPath) as! LabelWithTitleTableViewCell
        
        if indexPath.section == 0 {
            if let personalInfo = PersonalInfo(rawValue: indexPath.row) {
                let cellInformation = personalInfo.getCellInformation()
                cell.configureCell(title: cellInformation.title, placeholder: cellInformation.placeholder)
                cell.textField.text = signupController?.personalInfo[indexPath.row]
                cell.textField.tag = 10 + indexPath.row
                
                if indexPath.row <= 4 {
                    cell.textField.isUserInteractionEnabled = false
                } else {
                    cell.textField.isUserInteractionEnabled = true
                }
            }
        } else {
            if let creditInfo = CreditInfo(rawValue: indexPath.row) {
                let cellInformation = creditInfo.getCellInformation()
                cell.configureCell(title: cellInformation.title, placeholder: cellInformation.placeholder)
                cell.textField.text = signupController?.crediCardInfo[indexPath.row]
                cell.textField.tag = 20 + indexPath.row
                cell.textField.isUserInteractionEnabled = true
            }
        }
        
        cell.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Personal Info" : "Credit Info"
    }
    
}

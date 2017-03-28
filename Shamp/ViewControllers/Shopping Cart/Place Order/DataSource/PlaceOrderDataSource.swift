//
//  PlaceOrderDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/28/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

enum OrderItems: Int {
    case DeliveryAddress, ContactPhone, City, Country
    
    static let names = [
        DeliveryAddress: "Delivery Address",
        ContactPhone: "Contact Phone",
        City: "City",
        Country: "Country"
    ]
    
    static let placeholder = [
        DeliveryAddress: "Enter the address for the delivery",
        ContactPhone: "Type your phone number",
        City: "Type your city",
        Country: "Type your country"
    ]
    
    func getCellInformation() -> (title: String, placeholder: String) {
        if let name = OrderItems.names[self], let placeholder = OrderItems.placeholder[self] {
            return (title: name, placeholder: placeholder)
        } else {
            return (title: "", placeholder: "")
        }
    }
}

class PlaceOrderDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithTitleTableViewCell", for: indexPath) as! LabelWithTitleTableViewCell
        if let orderItems = OrderItems(rawValue: indexPath.row) {
            let cellInformation = orderItems.getCellInformation()
            cell.configureCell(title: cellInformation.title, placeholder: cellInformation.placeholder)
        }
        return cell
    }

}

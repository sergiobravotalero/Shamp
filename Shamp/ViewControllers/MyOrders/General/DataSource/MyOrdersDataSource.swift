//
//  MyOrdersDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/22/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

private enum OrderInfo: Int {
    case DeliveryAddress, ContactPhone, City, Country
    
    static let names = [
        DeliveryAddress: "Delivery Address",
        ContactPhone: "Contact Phone",
        City: "City",
        Country: "Country"
    ]
    
    func getCellInformation() -> String {
        if let name = OrderInfo.names[self] {
            return name
        } else {
            return ""
        }
    }
}

private enum ProductInfo: Int {
    case Products
    
    static let names = [
        Products: "Products"
    ]
    
    func getCellInformation() -> String {
        if let name = ProductInfo.names[self] {
            return name
        } else {
            return ""
        }
    }
}

class MyOrdersDataSource: NSObject, UITableViewDataSource {
    var orders = [Order]()
    var odersController: MyOrdersViewController!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Order No: \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersTableViewCell", for: indexPath) as! MyOrdersTableViewCell
        
        if indexPath.row <= 3 {
            if let orderInfo = OrderInfo(rawValue: indexPath.row) {
                cell.configureCell(title: orderInfo.getCellInformation(), value: getOrderInfo(row: indexPath.row, order: order))
            }
        } else {
            let value = order.products.count
            cell.configureCell(title: "Products", value: "\(value)")
        }

        return cell
    }
    
    private func getOrderInfo(row: Int, order: Order) -> String {
        if row == 0 {
            return order.deliveryAddress
        } else if row == 1 {
            return order.contactPhone
        } else if row == 2 {
            return order.city
        } else {
            return order.country
        }
    }
}

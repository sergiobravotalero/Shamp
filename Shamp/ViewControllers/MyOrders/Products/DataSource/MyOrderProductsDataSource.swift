//
//  MyOrderProductsDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

private enum ProductsInfo: Int {
    case StampName, ShirtName, Quantity, ShirtSize, StampLocation, TextSize, TextColor, Text, StampUrl
    
    static let names = [
        StampName: "Stamp name",
        ShirtName: "Shirt Name",
        Quantity: "Quantity",
        ShirtSize: "Shirt size",
        StampLocation: "Stamp location",
        TextSize: "Text size",
        TextColor: "Text color",
        Text: "Text",
        StampUrl: "StampUrl"
    ]
    
    func getCellInformation() -> String {
        if let name = ProductsInfo.names[self] {
            return name
        } else {
            return ""
        }
    }
}

class MyOrderProductsDataSource: NSObject, UITableViewDataSource {
    var order: Order!
    var orderProductsController: MyOrderProductsViewController!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return order.products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductsInfo.names.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Product \(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = order.products[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersTableViewCell", for: indexPath) as! MyOrdersTableViewCell
        
        if let productInfo = ProductsInfo(rawValue: indexPath.row) {
            let value = getValueForRow(product: product, row: indexPath.row)
            cell.configureCell(title: productInfo.getCellInformation(), value: value)
        }
        
        return cell
    }
    
    // MARK: - Private Methods
    private func getValueForRow(product: Product, row: Int) -> String {
        if row == 0 {
            if let stamp = SessionHandler.shared.stampsCollection.first(where: { $0.id == product.stampID}) {
                return stamp.name
            } else {
                return "nil"
            }
        } else if row == 1 {
            if let shirt = SessionHandler.shared.shirtsCollection.first(where: { $0.id == product.shirtID }) {
                return shirt.name
            } else {
                return "nil"
            }
        } else if row == 2 {
            return "\(product.quantity)"
        } else if row == 3 {
            return product.size
        } else if row == 4 {
            return product.location
        } else if row == 5 {
            return product.textSize ?? "nil"
        } else if row == 6 {
            return product.textColor?.hexCode ?? "nil"
        } else if row == 7 {
            return product.text ?? "nil"
        } else {
            return product.imageUrl.absoluteString
        }
    }
}

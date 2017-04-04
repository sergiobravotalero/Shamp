//
//  ShoppingCartDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

class ShoppingCartDataSource: NSObject, UITableViewDataSource, ProductCellDelegate {
    
    var cartController: ShoppingCartViewController!
    
    var products = [Product]()
    
    // MARK: - Method
    func productWasRemoved() {
        products = ShoppingCart.shared.products
        cartController.tableView.reloadData()
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.configureCell(product: product)
        cell.delegate = self
        return cell
    }
}

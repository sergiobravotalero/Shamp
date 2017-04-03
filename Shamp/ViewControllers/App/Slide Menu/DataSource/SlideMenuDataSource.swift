//
//  SlideMenuDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

private enum MenuOptions: Int {
    case Home,ShoppingCart, PaymentInfo
    
    static let option = [
        Home: "Home",
        ShoppingCart: "Shopping Cart",
        PaymentInfo: "Payment"
    ]
    
    func getCellInformation() -> String {
        if let name = MenuOptions.option[self] {
            return name
        } else {
            return ""
        }
    }
}

class SlideMenuDataSource: NSObject, UITableViewDataSource {
    
    var slideMenuController: SlideMenuViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithArrowTableViewCell", for: indexPath) as! CellWithArrowTableViewCell
        if let option = MenuOptions(rawValue: indexPath.row) {
            cell.configureCell(name: option.getCellInformation())
        }
        return cell
    }
}

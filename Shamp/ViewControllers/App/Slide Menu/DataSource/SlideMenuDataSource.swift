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
    case Home,ShoppingCart, SignOut
    
    static let option = [
        Home: "Home",
        ShoppingCart: "Shopping Cart",
        SignOut: "Sign out"
    ]
    
    func getCellInformation() -> String {
        if let name = MenuOptions.option[self] {
            return name
        } else {
            return ""
        }
    }
}

private enum MenuOptionsWithMessages: Int {
    case Home, ShoppingCart, Messages, SignOut
    
    static let option = [
        Home: "Home",
        ShoppingCart: "Shopping Cart",
        Messages: "Messages",
        SignOut: "Sign out"
    ]
    
    func getCellInformation() -> String {
        if let name = MenuOptionsWithMessages.option[self] {
            return name
        } else {
            return ""
        }
    }
}

class SlideMenuDataSource: NSObject, UITableViewDataSource {
    
    var slideMenuController: SlideMenuViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = SessionHandler.shared.listOfFeatures?.messages, messages {
            return MenuOptionsWithMessages.option.count
        } else {
            return MenuOptions.option.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let messages = SessionHandler.shared.listOfFeatures?.messages, messages {
            return setupCellOfMenuWithMessages(indexPath: indexPath, tableView: tableView)
        } else {
            return setupCellOfSimpleMenu(indexPath: indexPath, tableView: tableView)
        }
    }
    
    private func setupCellOfSimpleMenu(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithArrowTableViewCell", for: indexPath) as! CellWithArrowTableViewCell
        if let option = MenuOptions(rawValue: indexPath.row) {
            cell.configureCell(name: option.getCellInformation())
            
            if option.getCellInformation() == "Sign out" {
                cell.nameLabel.textColor = UIColor.signatureRed()
            }
        }
        return cell
    }
    
    private func setupCellOfMenuWithMessages(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithArrowTableViewCell", for: indexPath) as! CellWithArrowTableViewCell
        if let option = MenuOptionsWithMessages(rawValue: indexPath.row) {
            cell.configureCell(name: option.getCellInformation())
            
            if option.getCellInformation() == "Sign out" {
                cell.nameLabel.textColor = UIColor.signatureRed()
            }
        }
        return cell
    }
}

//
//  SlideMenuTableView.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/3/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

extension SlideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentIndex == indexPath.row {
            slideMenuController()?.closeLeft()
            return
        }
        if let messages = SessionHandler.shared.listOfFeatures?.messages, messages {
            changeRootControllerOfMenuWithMessages(row: indexPath.row)
        } else {
            changeRootController(row: indexPath.row)
        }
        
    }
    
    private func changeRootController(row: Int) {
        if row == 0 {
            if let controller = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 1 {
            if let controller = UIStoryboard(name: "ShoppingCart", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 2 {
            if let controller = UIStoryboard(name: "MyOrders", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 3 {
            userTappedSignOut()
        }
    }
    
    private func changeRootControllerOfMenuWithMessages(row: Int) {
        if row == 0 {
            if let controller = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 1 {
            if let controller = UIStoryboard(name: "ShoppingCart", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 2 {
            if let controller = UIStoryboard(name: "Messages", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 3 {
            if let controller = UIStoryboard(name: "MyOrders", bundle: nil).instantiateInitialViewController() {
                currentIndex = row
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if row == 4 {
            userTappedSignOut()
        }
    }
    
}

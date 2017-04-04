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
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let controller = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() {
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        } else if indexPath.row == 1 {
            if let controller = UIStoryboard(name: "ShoppingCart", bundle: nil).instantiateInitialViewController() {
                slideMenuController()?.changeMainViewController(controller, close: true)
            }
        }
    }
}

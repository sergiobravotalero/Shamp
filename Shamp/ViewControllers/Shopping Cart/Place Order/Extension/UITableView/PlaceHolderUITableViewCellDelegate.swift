//
//  PlaceHolderUITableViewCellDelegate.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/28/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

extension PlaceOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98.5
    }
}

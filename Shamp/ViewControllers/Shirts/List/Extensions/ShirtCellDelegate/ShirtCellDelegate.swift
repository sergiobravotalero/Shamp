//
//  ShirtCellDelegate.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

extension ShirtsViewController: ShirtCellDelegate {
    func userDidSelectShirt(shirt: Shirt) {
        selectedShirt = shirt
        performSegue(withIdentifier: "showConfigureShirt", sender: nil)
    }
}

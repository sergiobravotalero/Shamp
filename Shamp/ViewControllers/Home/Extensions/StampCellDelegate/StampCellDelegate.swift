//
//  StampCellDelegate.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation

extension HomeViewController: StampCellDelegate {
    
    func userDidSelectStamp(stamp: Stamp) {
        selectedStamp = stamp
        performSegue(withIdentifier: "showShirts", sender: nil)
    }
}

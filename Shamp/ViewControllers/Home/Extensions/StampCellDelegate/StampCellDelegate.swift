//
//  StampCellDelegate.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import  UIKit

extension HomeViewController: StampCellDelegate {
    
    func userDidSelectStamp(stamp: Stamp) {
        let actionController = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: "Select this stamp", style: .default, handler: { (action) in
            self.selectedStamp = stamp
            self.performSegue(withIdentifier: "showShirts", sender: nil)
        })
        actionController.addAction(addAction)
        
        if let productRating = SessionHandler.shared.listOfFeatures?.productRating, productRating{
            let rateAction = UIAlertAction(title: "Rate this stamp", style: .default, handler: { (action) in
            
            })
            actionController.addAction(rateAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionController.addAction(cancelAction)
        
        present(actionController, animated: true, completion: nil)
    }
}

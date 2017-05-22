//
//  StampCellDelegate.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import  UIKit
import FCAlertView

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
                self.showStampRater(stamp: stamp)
            })
            actionController.addAction(rateAction)
        }
        
        if let shareSocialNetwork = SessionHandler.shared.listOfFeatures?.shareSocialNetwork, shareSocialNetwork{
            let shareAction = UIAlertAction(title: "Share this stamp", style: .default, handler: { (action) in
                self.shareStamp(stamp: stamp)
            })
            actionController.addAction(shareAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionController.addAction(cancelAction)
        
        present(actionController, animated: true, completion: nil)
    }
    
    // MARK: - Rate stamp
    func showStampRater(stamp: Stamp) {
        let alert = FCAlertView()
        
        alert.makeAlertTypeRateStars({ (rating) in
            RequesterHandler().rateStamp(stamp: stamp, rating: rating)
        })
        
        alert.showAlert(withTitle: "Rate \(stamp.name)", withSubtitle: "Tell us how much you like this stamp.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    // MARK: - Share stamp
    func shareStamp(stamp: Stamp) {
        
    }
}

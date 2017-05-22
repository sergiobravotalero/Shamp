//
//  StampCellDelegate.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit
import FCAlertView
import Social

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
        
        if let messages = SessionHandler.shared.listOfFeatures?.messages, messages {
            let messageAction = UIAlertAction(title: "Contact the artist", style: .default, handler: { (action) in
                self.showMessage(stamp: stamp)
            })
            actionController.addAction(messageAction)
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
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            if let socialController = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                socialController.setInitialText("I love this stamp named \(stamp.name)")
                socialController.add(stamp.imagePath)
                present(socialController, animated: true, completion: nil)
            }
        }
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            if let socialController = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                socialController.setInitialText("I love this stamp named \(stamp.name)")
                socialController.add(stamp.imagePath)
                present(socialController, animated: true, completion: nil)
            }
        }
        
        if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) && !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Sorry", message: "We can't share to any of your social networks right now.")
        }
    }
    
    // MARK: - Messages
    func showMessage(stamp: Stamp) {
        var enteredText: String = ""
        let alert = FCAlertView()
        
        alert.addTextField(withPlaceholder: "Enter your message", andTextReturn: { (text) in
            if let text = text {
                enteredText = text
            }
        })
        
        alert.addButton("Cancel", withActionBlock: nil)
        
        alert.doneActionBlock({ (action) in
            guard let text = alert.textField.text else { return }
            RequesterHandler().createNewMessage(stamp: stamp, message: text, parentMessage: -1, completion: { (result) in
                result ? AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: nil, message: "Message Sent") : AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Sorry", message: "There was an error sending your message. Try again.")
            })
        })
        
        alert.firstButtonTitleColor = UIColor.signatureYellow()
        alert.doneButtonTitleColor = UIColor.signatureYellow()
        
//        alert.makeAlertTypeSuccess()
        
        alert.showAlert(withTitle: "Write to artist", withSubtitle: "Start a conversation with the artist (\(stamp.artistEmail)) if you want a personalized stamp", withCustomImage: #imageLiteral(resourceName: "Andes Logo"), withDoneButtonTitle: "Send", andButtons: nil)
    }
    
}

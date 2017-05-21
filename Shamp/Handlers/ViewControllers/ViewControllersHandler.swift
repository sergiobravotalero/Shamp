//
//  ViewControllersHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import SlideMenuControllerSwift
import UIKit

class ViewControllersHandler {
    
    func showLoginAsRoot(window: UIWindow?) {
        let controller = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!
        window?.rootViewController = controller
    }

    func changeRootViewController(withName name: String, window: UIWindow?) {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        
        guard let window = window else { return }
        guard let rootViewController = window.rootViewController else { return }
        
        controller?.view.frame = rootViewController.view.frame
        controller?.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: {
            window.rootViewController = controller
            
            if name == "Home" {
                let mainController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! UINavigationController
                let leftContoller = UIStoryboard(name: "SlideMenu", bundle: nil).instantiateInitialViewController() as! SlideMenuViewController
                
                leftContoller.mainViewController = mainController
                
                SlideMenuOptions.contentViewScale = 1.0
                
                let slideMenuController = SlideMenuController(mainViewController: mainController, leftMenuViewController: leftContoller)
                slideMenuController.automaticallyAdjustsScrollViewInsets = true
                slideMenuController.delegate = leftContoller
                slideMenuController.changeLeftViewWidth(UIScreen.main.bounds.size.width / 1.2 )
                
                window.rootViewController = slideMenuController
                window.makeKeyAndVisible()
            }

        }, completion: nil)
    }
}

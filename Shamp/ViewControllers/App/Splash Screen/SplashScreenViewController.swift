//
//  SplashScreenViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/4/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import Pulsator

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startPulsating()
    }    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getListOfFeatures()
    }

    // MARK: - Methods
    private func startPulsating() {
        let pulsator = Pulsator()
        pulsator.numPulse = 3
        pulsator.radius = 240.0
        pulsator.backgroundColor = UIColor.signatureYellow().cgColor
        pulsator.position = view.center
        
        
        view.layer.addSublayer(pulsator)
        view.bringSubview(toFront: logoImage)
        
        pulsator.start()
    }
    
    private func getListOfFeatures() {
        RequesterHandler().getListOfFeatures(completion: { (success) in
            success ? self.attemptToLogin() : self.showErrorScreen()
        })
    }
    
    private func showErrorScreen() {
        print("Error getting list of Features")
    }
    
    private func attemptToLogin() {
        if let userCredentials = UserDefaultsHandler.shared.userCredentials {
            
            RequesterHandler().attemptToLoginWith(email: userCredentials.email, password: userCredentials.password, completion: { (result) in
                if result {
                    ViewControllersHandler().changeRootViewController(withName: "Home", window: self.view.window)
                } else {
                    self.showLoginScreen()
                }
            })
        } else {
            showLoginScreen()
        }
    }

    private func showLoginScreen() {
        ViewControllersHandler().showLoginAsRoot(window: self.view.window)
    }
}

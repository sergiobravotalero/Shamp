//
//  LoginViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit
import FacebookLogin
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginWithSocialNetworksButton: UIButton!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet var socialNetworkViews: [UIView]!
    
    @IBOutlet weak var usernameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTopContraintWithoutSN: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Methods
    private func setupController() {
        loginWithSocialNetworksButton.backgroundColor = UIColor.signatureYellow()
        loginButton.setTitleColor(UIColor.signatureYellow(), for: .normal)
        signUpButton.setTitleColor(UIColor.signatureYellow(), for: .normal)
        
        if let isLoginWithSocialNetworksAllowed = SessionHandler.shared.listOfFeatures?.loginSocialNetwork, isLoginWithSocialNetworksAllowed {
            print("Login with social networks enabled")
            usernameTopConstraint.isActive = true
            usernameTopContraintWithoutSN.isActive = false
        } else {
            hideSocialNetworkViews()
        }
    }
    
    private func hideSocialNetworkViews() {
        for view in socialNetworkViews {
            view.isHidden = true
        }
        
        usernameTopConstraint.isActive = false
        usernameTopContraintWithoutSN.isActive = true
        view.layoutIfNeeded()
    }
        
    // MARK: - IBAction
    @IBAction func loginWithSocialNetworkTapped(_ sender: Any) {
        let actionController = UIAlertController(title: "Login with", message: nil, preferredStyle: .actionSheet)
        
        let facebookAction = UIAlertAction(title: "Facebook", style: .default, handler: { (action) in
            FacebookHandler.shared.facebookButtonTapped(viewController: self)
        })
        
        let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: { (action) in
            Twitterhandler.shared.attemtpToLogin(viewController: self)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionController.addAction(facebookAction)
        actionController.addAction(twitterAction)
        actionController.addAction(cancelAction)
        
        present(actionController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = usernameTextfield.text, let password = passwordTextfield.text else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all the fields")
            return
        }
        if username == "" || password == "" {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "You need to fill all the fields")
            return
        }
        
        SVProgressHUD.show()
        RequesterHandler().attemptToLoginWith(email: username, password: password, completion: { (succeeded) in
            SVProgressHUD.dismiss()
            if succeeded {
                ViewControllersHandler().changeRootViewController(withName: "Home", window: self.view.window)
            } else {
                AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Ooops", message: "Something went wrong. Try again.")
            }
        })
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        if let controller = UIStoryboard(name: "SignUp", bundle: nil).instantiateInitialViewController() {
            present(controller, animated: true, completion: nil)
        }
    }
}

//
//  ChangePasswordViewController.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        slideMenuController()?.removeLeftGestures()
        slideMenuController()?.addLeftGestures()
    }
    
    private func setupNavigationBar() {
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 17)!, NSForegroundColorAttributeName: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = UIColor.signatureYellow()
        navigationController?.navigationBar.tintColor = UIColor.signatureYellow()
    }

    // MARK: - IBAction
    @IBAction func showSideMenu(_ sender: Any) {
        slideMenuController()?.openLeft()
    }

    @IBAction func changePasswordTapped(_ sender: Any) {
        guard let oldPassword = oldPasswordTextField.text, let newPassword = newPasswordTextField.text, let confirmPassword = confirmPasswordTextField.text else {
            return
        }
        
        if oldPassword != UserDefaultsHandler.shared.userCredentials!.password {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Attention", message: "Wrong password")
            return
        }
        
        if newPassword.contains("") || newPassword.characters.count < 6 {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Error", message: "The new password is not valid")
            return
        }
        
        if newPassword != confirmPassword {
            AlertViewHandler().showAlerWithOkButton(fromViewController: self, title: "Error", message: "The passwords don't match")
            return
        }
        
        print("Change password")
    }
}

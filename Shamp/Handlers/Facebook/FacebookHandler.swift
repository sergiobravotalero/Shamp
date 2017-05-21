//
//  FacebookHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/23/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FacebookHandler {
    static let shared = FacebookHandler()
    private init() {}
    
    private let loginMananager = FBSDKLoginManager()
    
    func loginWithFacebookWithCompletion(viewController: UIViewController, completion: @escaping (_ result: Bool) -> ()) {
        loginMananager.logIn(withReadPermissions: ["email"], from: viewController, handler: { (result, error) in
            
            if let error = error {
                print("error: \(error.localizedDescription)")
                completion(false)
                AlertViewHandler().showAlerWithOkButton(fromViewController: viewController, title: "Oops", message: "Something went wrong, please try to login again.")
                return
            }
            guard let result = result else {
                print("Could not get result")
                completion(false)
                AlertViewHandler().showAlerWithOkButton(fromViewController: viewController, title: "Oops", message: "Something went wrong, please try to login again.")
                return
            }
            
            if result.isCancelled {
                print("User cancelled login with Facebook")
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    func isUserLoggedWithFacebook() -> Bool {
        return FBSDKAccessToken.current() != nil
    }
    
    func getFacebookCurrentAccessToken() -> String {
        return FBSDKAccessToken.current().userID
    }
    
    func facebookButtonTapped(viewController: UIViewController) {
        FacebookHandler.shared.loginWithFacebookWithCompletion(viewController: viewController, completion: { (result) in
            if result {
                let parameters = ["fields" : "name, email, first_name, last_name"]
                
                FBRequestHandler.shared.requestPersonalDataToFacebook(graphPath: "me", parameters: parameters, callback: { (data) in
                    guard let data = data else {
                        AlertViewHandler().showAlerWithOkButton(fromViewController: viewController, title: "Ooops", message: "Something went wrong.")
                        return
                    }
                    
                    self.attemptToLoginWithFacebook(data: data, viewController: viewController)
                })
            }
        })
    }
    
    func attemptToLoginWithFacebook(data: NSDictionary, viewController: UIViewController) {
        print(data)
        
        guard let firstName = data.object(forKey: "first_name") as? String, let name = data.object(forKey: "name") as? String, let lastName = data.object(forKey: "last_name") as? String, let id = data.object(forKey: "id") as? String, let email = data.object(forKey: "email") as? String else {
            AlertViewHandler().showAlerWithOkButton(fromViewController: viewController, title: "Ooops", message: "Something went wrong. Please try again")
            return
        }
        
        RequesterHandler().attemptToLoginWith(email: email, password: id, completion: { (result) in
            if result {
                ViewControllersHandler().changeRootViewController(withName: "Home", window: viewController.view.window)
            } else {
                self.signUpWithFacebook(id: id, name: name, firstName: firstName, lastName: lastName, email: email, viewController: viewController)
            }
        })
    }
    
    func signUpWithFacebook(id: String, name: String, firstName: String, lastName: String, email: String, viewController: UIViewController) {
        let controller = UIStoryboard(name: "SignUp", bundle: nil).instantiateInitialViewController() as! SignUpViewController
        
//        controller.personalInfo[0] = id
        controller.personalInfo[1] = id
        controller.personalInfo[2] = id
        controller.personalInfo[3] = email
        controller.personalInfo[4] = name
        
        controller.isAttemptingFacebook = true
        viewController.present(controller, animated: true, completion: nil)
    }

}

//
//  TwitterHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/21/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import TwitterKit

class Twitterhandler {
    static let shared = Twitterhandler()
    private init() {}
    
    func attemtpToLogin(viewController: UIViewController) {
        Twitter.sharedInstance().logIn(with: viewController, methods: [.webBased], completion: { (session, error) in
            if session != nil {
                self.requestTwitterEmail(completion: { (email) in
                    guard let email = email,
                        let username = session?.userName,
                        let userID = session?.userID else {
                            AlertViewHandler().showAlerWithOkButton(fromViewController: viewController, title: "Oops", message: "You need to enable email sharing on your Twtter account to login")
                            return
                    }
                    
                    self.attemptToLoginWithTwitter(email: email, password: userID, name: username, viewController: viewController)
                })
            } else {
                print("error: \(error?.localizedDescription)")
            }
        })
    }
    
    func requestTwitterEmail(completion: @escaping (_ email: String?)->()) {
        let client = TWTRAPIClient.withCurrentUser()
        let request = client.urlRequest(withMethod: "GET", url: "https://api.twitter.com/1.1/account/verify_credentials.json", parameters: ["include_email": "true", "skip_status": "true"], error: nil)
        
        client.sendTwitterRequest(request, completion: { (response, data, connectionError) in
            if data == nil {
                completion(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as!  [String: Any]
                if let email = json["email"] as? String{
                    completion(email)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        })
    }
    
    func attemptToLoginWithTwitter(email: String, password: String, name: String, viewController: UIViewController) {
        RequesterHandler().attemptToLoginWith(email: email, password: password, completion: { (result) in
            if result {
                ViewControllersHandler().changeRootViewController(withName: "Home", window: viewController.view.window)
            } else {
                let controller = UIStoryboard(name: "SignUp", bundle: nil).instantiateInitialViewController() as! SignUpViewController
                
                controller.personalInfo[1] = password
                controller.personalInfo[2] = password
                controller.personalInfo[3] = email
                controller.personalInfo[4] = name
                
                controller.isAttemptingFacebook = true
                viewController.present(controller, animated: true, completion: nil)
            }
        })
    }
    
}

//
//  FBRequestHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 4/4/17.
//  Copyright © 2017 Koombea. All rights reserved.
//


import Foundation
import FBSDKCoreKit

class FBRequestHandler {
    
    static let shared = FBRequestHandler()
    private init() {}
    
    //    ["fields" : "picture, email, gender, friends"]
    //     "me"
    
    func requestPersonalDataToFacebook(graphPath: String, parameters: [String : String], callback: @escaping (_ result: NSDictionary?) -> Void) {
        
        if let request = FBSDKGraphRequest.init(graphPath: graphPath, parameters: parameters, httpMethod: "GET") {
            request.start(completionHandler: { (connection, result, error) -> Void in
                
                if let error = error {
                    print(error.localizedDescription)
                    callback(nil)
                    return
                }
                
                if let result = result as? NSDictionary {
                    callback(result)
                } else {
                    callback(nil)
                }
            })
        }
    }
    
    
}

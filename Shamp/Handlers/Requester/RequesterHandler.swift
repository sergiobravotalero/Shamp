//
//  RequesterHandler.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import Alamofire

class RequesterHandler {
    private let baseUrl = "https://shamp.herokuapp.com/"

    // MARK: - GET
    func getListOfFeatures(completion: @escaping(_ success: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "Features") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            if let isSuccessful = dictionary.object(forKey: "isSuccessfull") as? Bool, !isSuccessful {
                completion(false)
                return
            }
            
            guard let body = dictionary.object(forKey: "body") as? NSDictionary else {
                completion(false)
                return
            }
            
            ParserHandler().getListOfFeatures(body: body, completion: { (success) in
                completion(success)
            })
        })
    }
    
    func getListOfStampsWithCompletion(completion: @escaping (_ succeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "Stamps") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            if let isSuccessful = dictionary.object(forKey: "isSuccessfull") as? Bool, !isSuccessful {
                completion(false)
                return
            }
            
            guard let body = dictionary.object(forKey: "body") as? NSArray else {
                completion(false)
                return
            }
            
            ParserHandler().getCollectionOfStampsWithCompletion(dictionary: body, completion: {
                completion(true)
            })
            
        })

    }
    
    func getListOfShirtsWithCompletion(completion: @escaping(_ succeeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "Shirts") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            if let isSuccessful = dictionary.object(forKey: "isSuccessfull") as? Bool, !isSuccessful {
                completion(false)
                return
            }
            
            guard let body = dictionary.object(forKey: "body") as? NSArray else {
                completion(false)
                return
            }

            
            ParserHandler().getCollectionOfShirtsWithCompletion(dictionary: body, completion: {
                completion(true)
            })
        })
    }
    
    // MARK: - POST
    func attemptToLoginWith(email: String, password: String, completion: @escaping (_ succeeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "User/Token") else {
            completion(false)
            return
        }
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            guard let isSuccessful = dictionary.object(forKey: "isSuccessfull") as? Bool else {
                completion(false)
                return
            }
            
            guard let body = dictionary.object(forKey: "body") as? NSDictionary else {
                completion(false)
                return
            }
            
            guard let token = body.object(forKey: "token") as? String, let user = body.object(forKey: "user") as? NSDictionary, let userBilling = body.object(forKey: "userBilling") as? NSDictionary else {
                completion(false)
                return
            }
            
            ParserHandler().getUserFrom(dictionary: user, billing: userBilling, completion: { (succeeded) in
                if succeeded {
                    let email = parameters["email"]!
                    let password = parameters["password"]!
                    
                    UserDefaultsHandler.shared.token = token
                    UserDefaultsHandler.shared.userCredentials = (email: email, password: password)
                    completion(true)
                } else {
                    completion(false)
                }
            })
        })
    }
    
    func registerUserInDbWith(parameters: [String: String], callback: @escaping(_ succeeded: Bool) -> ()){
        guard let requestUrl = URL(string: baseUrl + "User") else {
            callback(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                callback(false)
                return
            }
            
            guard let isSuccessful = dictionary.object(forKey: "isSuccessfull") as? Bool else {
                callback(false)
                return
            }
            
            guard let body = dictionary.object(forKey: "body") as? NSDictionary else {
                callback(false)
                return
            }
            
            guard let token = body.object(forKey: "token") as? String, let user = body.object(forKey: "user") as? NSDictionary, let userBilling = body.object(forKey: "userBilling") as? NSDictionary else {
                callback(false)
                return
            }
            
            ParserHandler().getUserFrom(dictionary: user, billing: userBilling, completion: { (succeeded) in
                if succeeded {
                    let email = parameters["email"]!
                    let password = parameters["password"]!
                    
                    UserDefaultsHandler.shared.token = token
                    UserDefaultsHandler.shared.userCredentials = (email: email, password: password)
                    callback(true)
                } else {
                    callback(false)
                }
            })
        })
    }
    
    func rateStamp(stamp: Stamp, rating: Int) {
        guard let requestUrl = URL(string: baseUrl + "Rating") else {
            return
        }
        
        let parameters = [
            "stamp_id": stamp.id,
            "stamp_rating": rating,
            "stamp_comments": "No comments"
        ] as [String : Any]
        
        guard let userID = SessionHandler.shared.loggedUser?.id else {
            return
        }
        
        let header: HTTPHeaders = [
            "user_id": "\(userID)"
        ]
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                return
            }
            
            guard let isSuccessful = dictionary.object(forKey: "isSuccessfull") as? Bool else {
                return
            }
            
            guard let body = dictionary.object(forKey: "body") as? NSDictionary else {
                return
            }
            
        })
    }
    
    func addOrderToServerWithCompletion(order: [String : Any], completion: @escaping(_ succeeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "order/register") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .post, parameters: order, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            ShoppingCart.shared.products.removeAll()
            completion(true)
        })
    }
}

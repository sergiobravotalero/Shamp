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
    private let baseUrl = "http://35.162.96.142:28080/shamp-web/rest/"

    // MARK: - GET
    func getListOfStampsWithCompletion(completion: @escaping (_ succeded: Bool) -> ()) {
        
        guard let requestUrl = URL(string: baseUrl + "stamp") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            ParserHandler().getCollectionOfStampsWithCompletion(dictionary: dictionary, completion: { () in
                completion(true)
            })
        })
    }
    
    func getListOfShirtsWithCompletion(completion: @escaping(_ succeeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "shirt") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            ParserHandler().getCollectionOfShirtsWithCompletion(dictionary: dictionary, completion: { () in
                completion(true)
            })
        })
    }
    
    // MARK: - POST
    func attemptToLoginWith(username: String, password: String, completion: @escaping (_ succeeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "login") else {
            completion(false)
            return
        }
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            guard let token = dictionary.object(forKey: "token") as? String, let user = dictionary.object(forKey: "user") as? NSDictionary, let userBilling = dictionary.object(forKey: "userBilling") as? NSDictionary else {
                completion(false)
                return
            }
            
            ParserHandler().getUserFrom(dictionary: user, billing: userBilling, completion: { (succeeded) in
                if succeeded {
                    UserDefaultsHandler.shared.token = token
                    UserDefaultsHandler.shared.userCredentials = (username: username, password: password)
                    completion(true)
                } else {
                    completion(false)
                }
            })
        })
    }
    
    func registerUserInDbWith(parameters: [String: String], callback: @escaping(_ succeeded: Bool) -> ()){
        guard let requestUrl = URL(string: baseUrl + "register") else {
            callback(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                callback(false)
                return
            }
            
            guard let token = dictionary.object(forKey: "token") as? String, let user = dictionary.object(forKey: "user") as? NSDictionary, let userBilling = dictionary.object(forKey: "userBilling") as? NSDictionary else {
                callback(false)
                return
            }
            
            ParserHandler().getUserFrom(dictionary: user, billing: userBilling, completion: { (succeeded) in
                if succeeded {
                    let username = parameters["username"]!
                    let password = parameters["password"]!
                    
                    UserDefaultsHandler.shared.token = token
                    UserDefaultsHandler.shared.userCredentials = (username: username, password: password)
                    callback(true)
                } else {
                    callback(false)
                }
            })
        })
    }
    
    func addOrderToServerWithCompletion(order: [String : Any], completion: @escaping(_ succeeded: Bool) -> ()) {
        guard let requestUrl = URL(string: baseUrl + "order/register") else {
            completion(false)
            return
        }
        
        Alamofire.request(requestUrl, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard let dictionary = response.result.value as? NSDictionary else {
                completion(false)
                return
            }
            
            print(dictionary)
        })
    }
}

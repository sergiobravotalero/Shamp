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

    // MARK: - Stamps
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
    
    // MARK: - Shirt
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
}

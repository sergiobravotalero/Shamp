//
//  ShirtsDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

class ShirtsDataSource: NSObject, UITableViewDataSource {
    var shirtsController : ShirtsViewController!
    var shirts = [Shirt]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shirts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shirt = shirts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShirtsTableViewCell", for: indexPath) as! ShirtsTableViewCell
        cell.configureCell(shirt: shirt)
        cell.delegate = shirtsController
        return cell
    }
}

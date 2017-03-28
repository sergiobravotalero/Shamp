//
//  HomeDataSource.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

class HomeDataSource: NSObject, UITableViewDataSource {
    
    var homeController: HomeViewController!
    var stamps = [Stamp]()
    
    // MARK; - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stamps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stamp = stamps[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StampTableViewCell", for: indexPath) as! StampTableViewCell
        cell.configureCell(stamp: stamp)
        cell.delegate = homeController
        return cell
    }
}

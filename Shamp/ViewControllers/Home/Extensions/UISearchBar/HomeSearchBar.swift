//
//  HomeSearchBar.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 5/21/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.resignFirstResponder()
        searchBarHeightConstraint.constant = 0
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.resignFirstResponder()
        searchBarHeightConstraint.constant = 0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredStamps = SessionHandler.shared.stampsCollection.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        
        if searchText == "" {
            dataSource.stamps = SessionHandler.shared.stampsCollection
            tableView.reloadData()
            return
        }
        
        if filteredStamps.isEmpty {
            return
        }
        
        dataSource.stamps = filteredStamps
        tableView.reloadData()
    }
    
}

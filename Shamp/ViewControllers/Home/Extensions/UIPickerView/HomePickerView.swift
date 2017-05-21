//
//  HomePickerView.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Methods
    func setupPickerView() {
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.isHidden = true
        toolBar.isHidden = true
    }

    // MARK: - UIPickerView Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerShouldShowCategories {
            return SessionHandler.shared.categoriesCollection.count + 1
        } else if pickerShouldShowPrices {
            return priceCategories.count
        } else {
            return SessionHandler.shared.artistsCollection.count + 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerShouldShowCategories || pickerShouldShowArtists {
            if row == 0 {
                return "None"
            }
            
            if pickerShouldShowCategories {
                return SessionHandler.shared.categoriesCollection[row - 1].name
            } else {
                return SessionHandler.shared.artistsCollection[row - 1]
            }
        } else {
            return priceCategories[row]
        }
    }
    
    // MARK: - UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            dataSource.stamps = SessionHandler.shared.stampsCollection
            tableView.reloadData()
            return
        }
        
        if pickerShouldShowCategories {
            let category = SessionHandler.shared.categoriesCollection[row - 1]
            let filteredStamps = SessionHandler.shared.stampsCollection.filter({ $0.categoryName == category.name })
            dataSource.stamps = filteredStamps
            tableView.reloadData()
        } else if pickerShouldShowArtists{
            let artist = SessionHandler.shared.artistsCollection[row - 1]
            let filteredStamps = SessionHandler.shared.stampsCollection.filter({ $0.artistEmail == artist })
            dataSource.stamps = filteredStamps
            tableView.reloadData()
        } else {
            
            let filteredStamps = SessionHandler.shared.stampsCollection.filter({
                let price = $0.price
                
                if row == 1 {
                    return price < 10000
                } else if row == 2 {
                    return price >= 10000 && price < 50000
                } else if row == 3 {
                    return price >= 50000 && price < 100000
                } else {
                    return price >= 100000
                }
            })
            
            dataSource.stamps = filteredStamps
            tableView.reloadData()
        }
    }
}

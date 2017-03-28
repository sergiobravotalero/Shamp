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
        return SessionHandler.shared.categoriesCollection.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "None"
        } else {
            return SessionHandler.shared.categoriesCollection[row - 1].name
        }
    }
    
    // MARK: - UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            dataSource.stamps = SessionHandler.shared.stampsCollection
            tableView.reloadData()
            return
        }
        
        let category = SessionHandler.shared.categoriesCollection[row - 1]
        let filteredStamps = SessionHandler.shared.stampsCollection.filter({ $0.categoryName == category.name })
        dataSource.stamps = filteredStamps
        tableView.reloadData()
    }
}

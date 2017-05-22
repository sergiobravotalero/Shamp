//
//  ConfigureShirtPickerView.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

extension ConfigureShirtViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Method
    func setupPickerView() {
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.backgroundColor = UIColor.white
        toolBar.tintColor = UIColor.signatureRed()
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        sizeTextField.inputView = pickerView
        locationTextField.inputView = pickerView
        fontSizeTextField.inputView = pickerView
        fontLocation.inputView = pickerView
        
        sizeTextField.inputAccessoryView = toolBar
        locationTextField.inputAccessoryView = toolBar
        fontSizeTextField.inputAccessoryView = toolBar
        fontLocation.inputAccessoryView = toolBar
    }
    
    func doneButtonTapped(_ sender: Any) {
        dismissPicker()
        
        if pickerView.tag == 0 {
            let row = pickerView.selectedRow(inComponent: 0)
            sizeTextField.text = shirtSizes[row]
            selectedShirtSize = shirtSizes[row]
        } else if pickerView.tag == 2 {
            let row = pickerView.selectedRow(inComponent: 0)
            locationTextField.text = location[row]
            selectedLocation = location[row]
        } else if pickerView.tag == 4 {
            let row = pickerView.selectedRow(inComponent: 0)
            fontSizeTextField.text = fontSizes[row]
            selectedFontSize = fontSizes[row]
        } else {
            let row = pickerView.selectedRow(inComponent: 0)
            fontLocation.text = location[row]
            selectedFontLocation = location[row]
        }
    }
    
    func dismissPicker() {
        pickerView.removeFromSuperview()
        
        if pickerView.tag == 0 {
            sizeTextField.resignFirstResponder()
        } else if pickerView.tag == 2 {
            locationTextField.resignFirstResponder()
        } else if  pickerView.tag == 4 {
            fontSizeTextField.resignFirstResponder()
        } else {
            fontLocation.resignFirstResponder()
        }
    }
    
    // MARK: - UIPickerView Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return shirtSizes.count
        } else if pickerView.tag == 2 {
            return location.count
        } else if pickerView.tag == 4 {
            return fontSizes.count
        } else {
            return location.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return shirtSizes[row]
        } else if pickerView.tag == 2 || pickerView.tag == 6 {
            return location[row]
        } else {
            return fontSizes[row]
        }
    }
}

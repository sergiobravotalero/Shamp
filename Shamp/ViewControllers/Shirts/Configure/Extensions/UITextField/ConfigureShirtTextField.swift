//
//  ConfigureShirtTextField.swift
//  Shamp
//
//  Created by Sergio David Bravo Talero on 3/27/17.
//  Copyright © 2017 Koombea. All rights reserved.
//

import Foundation
import UIKit

extension ConfigureShirtViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.tag = textField.tag
    }
}

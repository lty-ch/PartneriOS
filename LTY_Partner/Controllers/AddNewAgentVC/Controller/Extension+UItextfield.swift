//
//  Extension+UItextfield.swift
//  LTY_Partner
//
//  Created by CTS on 23/05/23.
//

import Foundation
import UIKit
extension AddNewAgentVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == textDob {

            showDatePicker()
            return true
        }

        return true

    }
}


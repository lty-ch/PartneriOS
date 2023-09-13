//
//  Extension+ResetPassVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation
import UIKit


extension ResetPassVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string.count == 1) {
            
            if textField == textfield1 {
                textfield2?.becomeFirstResponder()
            }
            if textField == textfield2 {
                textfield3?.becomeFirstResponder()
            }
            
            if textField == textfield3 {
                textfield4?.becomeFirstResponder()
            }
            if textField == textfield4 {
                textfield5?.becomeFirstResponder()
            }
            if textField == textfield5 {
                textfield6?.becomeFirstResponder()
            }
            if textField == textfield6 {
                textfield6?.resignFirstResponder()
                
                textField.text? = string
                
                // this is used for get otp text value
                
                let otp = "\((textfield1?.text)!)\((textfield2?.text)!)\((textfield3?.text)!)\((textfield4?.text)!)\((textfield5?.text)!)\((textfield6?.text)!)"
                print(otp)
                otpValue = otp
                
            }
            
            textField.text? = string
            
            if (textfield1.text != "") && (textfield2.text != "") && (textfield3.text != "") && (textfield4.text != "")  && (textfield5.text != "")  && (textfield6.text != "") {
                
                btnSetPass.isEnabled = true
                btnSetPass.alpha = 1
                
            } else {
                otpValue = ""
                btnSetPass.isEnabled = false
                btnSetPass.alpha = 0.5
                
            }
            
            return false
        }
        else{
            
            if textField == textfield1 {
                textfield1?.becomeFirstResponder()
            }
            if textField == textfield2 {
                textfield1?.becomeFirstResponder()
            }
            if textField == textfield3 {
                textfield2?.becomeFirstResponder()
            }
            if textField == textfield4 {
                textfield3?.becomeFirstResponder()
            }
            if textField == textfield5 {
                textfield4?.becomeFirstResponder()
            }
            if textField == textfield6 {
                textfield5?.becomeFirstResponder()
            }
            textField.text? = string
            otpValue = ""

            btnSetPass.isEnabled = false
            btnSetPass.alpha = 0.5

            return false
        }
    }
    
}



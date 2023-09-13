//
//  ExtensionResetPass+Delegate.swift
//  LTY_Partner
//
//  Created by Chawtech on 15/05/23.
//

import Foundation

extension ResetPassVC : ResetPassProtocolDelegate {
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            
            self.ShowAlert(message: msg)
            
        }
    }
    
    func setData(data : ResetPassModel) {
        
        if data.status == "ERROR" {
            DispatchQueue.main.async {
                self.ShowAlert(message:data.error?.clientErrorMessage ?? "")
            }
        }
        else {
            DispatchQueue.main.async {
                self.showSimpleAlert(title:LTYText.textResetVC_UpdatePass.localized())
            }
        }
    }
    

}

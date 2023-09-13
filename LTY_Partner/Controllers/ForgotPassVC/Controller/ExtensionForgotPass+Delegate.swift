//
//  ExtensionForgotPass+Delegate.swift
//  LTY_Partner
//
//  Created by Chawtech on 15/05/23.
//

import Foundation

extension ForgotPassVC : ForgotPassProtocolDelegate {
     
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
       func setData(data : ForgotVCModel) {
     
           if data.status == "ERROR" {
               DispatchQueue.main.async {
                   self.ShowAlert(message:data.error?.clientErrorMessage ?? "")
               }
           }
           else {
               DispatchQueue.main.async {
                   
                   self.dismiss(animated: false) {
                       self.delegate?.dismissScreen(setValue: true,data: ForgotPassValue.init(otpID: data.data?.otpID, userEmail: self.textEmail.text ?? "", duration: data.data?.timeoutInSeconds, remainingAttempts: data.data?.remainingAttempts, resendOtpTime: data.data?.resendOtpTime))

                    }
               }
           }
    }
}

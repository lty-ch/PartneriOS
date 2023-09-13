//
//  LoginVC+Delegate.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//


import Foundation

extension LoginVC : LoginSignUpProtocolDelegate {
    func popupMsg(msg: String) {
        self.btnLogin.isUserInteractionEnabled = true
        self.ShowAlert(message: msg)
    }
    
       func setLoginSignup(data : LoginModel) {
     
           if data.status == "ERROR" {
               
               DispatchQueue.main.async {
                   let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                   let result = language as! NSArray
                   
                   if result[0] as! String == "fr" {
                       self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                   }else{
                       self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                   }
                   self.btnLogin.isUserInteractionEnabled = true
               }
           }
           else {
               DispatchQueue.main.async {
                   self.btnLogin.isUserInteractionEnabled = true
                   
                   let vc = OtpVerifyVC.instantiate(fromAppStoryboard: .main)
                   vc.comingFrom = "loginVC"
                   vc.otpId = data.data?.processStageData?.txnStateData?.otpID ?? ""
                   vc.verifiedEmail = self.textEmail.text ?? ""
                   vc.modalTransitionStyle = .crossDissolve
                   vc.modalPresentationStyle = .overFullScreen
            
                   self.present(vc, animated: true)
               }
           }
    }
}


//MARK:- This extension is use for dismiss present screen first after that present another screen

extension LoginVC :DismissScreen {

    func dismissScreen(setValue: Bool,data: ForgotPassValue) {
        if setValue == true {
            let vc = ResetPassVC.instantiate(fromAppStoryboard: .main)
            //self.storyboard?.instantiateViewController(withIdentifier: "ResetPassVC") as! ResetPassVC
            vc.userEmail = data.userEmail ?? ""
            vc.forgotPassData.append(ForgotPassData.init(otpID: data.otpID, duration: data.duration, remainingAttempts: data.remainingAttempts, resendOtpTime: data.resendOtpTime))
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }else {
            
        }
    }
    
}

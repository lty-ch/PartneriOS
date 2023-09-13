//
//  Extension+OtpVerifyVCDelegate.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation


extension OtpVerifyVC : OtpVerifyProtocolDelegate {
  
  
    func dismiss(setDismiss: Bool) {
        if setDismiss == true {
            self.dismiss(animated: true)
        }
    }
     
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            
            self.ShowAlert(message: msg)

        }
    }
    
       func setOtpData(data : OtpVerifyModel) {
     
           if data.status == "ERROR" {
               DispatchQueue.main.async {
                   self.ShowAlert(message:data.error?.clientErrorMessage ?? "")
               }
           }
           else {
               DispatchQueue.main.async {
                   
                   if self.comingFrom == "loginVC" {
                       
                       if (data.data?.processStageData.txnStateData.state == "APPROVED" && data.data?.processStageData.txnStateData.userType == "PARTNER") || (data.data?.processStageData.txnStateData.state == "ACTIVE" && data.data?.processStageData.txnStateData.userType == "AGENT") {
                           
                         

                           let modelResponse = data.data?.processStageData.txnStateData
                           
                           kUserDefaults.set(modelResponse?.token, forKey: AppKeys.token)
                           kUserDefaults.set(modelResponse?.state, forKey: AppKeys.state)
                           kUserDefaults.set(modelResponse?.partnerID, forKey: AppKeys.partnerID)
                           kUserDefaults.set(modelResponse?.userType, forKey: AppKeys.userType)
                           kUserDefaults.set(modelResponse?.isDefaultPasswordSet, forKey: AppKeys.isDefaultPasswordSet)
//                           kUserDefaults.set(true, forKey: AppKeys.isDefaultPasswordSet)
                           self.callApiServices()
                           
                       
//                           self.group.notify(queue: .main) {
//                               print("success")
//                               //self.showSimpleAlert(title:LTYText.textLoginSuccess.localized())
//                               //self.switchToTab()
//                           }
                           
                       }
                       else {
                           self.ShowAlert(message: LTY_AlterText.accountApprovedPending.localized())

                       }
                   }
                   else {
                       self.dismiss(animated: false) {
                           self.delegate?.dimissOtpVerifyVC(setValue: true)
                       }

                   }
                   /*
                   if data.data?.processStageData.txnStateData.state == "APPROVED" {
                       
                       self.switchToTab()
                   }
                   else {
                       if self.comingFrom == "signUp"{
                           
                           self.dismiss(animated: false) {
                               self.delegate?.dimissOtpVerifyVC(setValue: true)
                           }
                       }
                       self.ShowAlert(message: "Invalid user")

                   }
                    */

//                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerifyVC") as! OtpVerifyVC
//                   self.navigationController?.pushViewController(vc, animated: true)
               }
           }
    }
    
    func callApiServices() {
        let dispatchGroup = DispatchGroup()
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)
        let partnerID = kUserDefaults.value(forKey: AppKeys.partnerID)
        let token = kUserDefaults.value(forKey: AppKeys.token)

        if usertype as! String == "AGENT"{
            group.enter()
            let param : [String:Any] = ["userId":partnerID ?? ""]
            self.otpVerifyViewModel.getUserRoleApi(param: param)
            
            group.leave()
            
        }
        
        group.enter()
        
        let param :[String:Any]  = ["token":token ?? ""]
        self.otpVerifyViewModel.profileDetailApi(param: param)
        group.leave()
    
//        self.group.notify(queue: .global(), execute: { [weak self] in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                //self.showSimpleAlert(title:LTYText.textLoginSuccess.localized())
//                self.switchToTab()
//
//            }
//        })
     
    }
    
    func setProfileDate(data: ProfileModel) {
        let fName = data.data?.firstName?.capitalized   ?? ""
        let lName = data.data?.lastName?.capitalized   ?? ""
        print(fName + " " + lName)
        kUserDefaults.set(fName + " " + lName, forKey: AppKeys.agentName)
        kUserDefaults.set(data.data?.source, forKey: AppKeys.sourceId)
        kUserDefaults.set(data.data?.profilePic, forKey: AppKeys.profile)
        kUserDefaults.set(data.data?.companyDetails?.companyName, forKey: AppKeys.companyName)
        
        group.notify(queue: .main) {
            print("success")
            self.switchToTab()
        }
       
    }
    

}

//
//  EditAgentCommission+Delegate.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation

extension EditAgentCommissionVC : EditAgentCommListProtocolDelegate {
    func setAgentList(data: SuccessModel) {
        print(data.data?.status)
        
        if data.data?.status == "SUCCESS"{
            DispatchQueue.main.async {
                self.popVC(animated: true)
            }
        }
        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                       let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                          self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                      }else{
                          self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                      }
                      
                  }
              }
          }
    }
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    
}

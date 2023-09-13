//
//  Extension+AgentCommDelegate.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation

extension AgentCommissionVC : AgentCommissionListProtocolDelegate {
    func setAgentCommissionList(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
            self.checkConnection() 
            self.agentCommissionTableView.reloadData()
                
            }
        }
        else{
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
    
    
    func setAgentList(data: AgentCommissionModel) {
        
        if data.status == "SUCCESS" {
            
                self.agentCommissionList = data.data?.feeDetailsList ?? []
            
            if agentCommissionList.count == 0 {
                DispatchQueue.main.async {
                    
                    self.noDataFoundView.isHidden = false
                    self.agentCommissionTableView.isHidden = true
                }
            } else {
                DispatchQueue.main.async{
                    self.noDataFoundView.isHidden = true
                    self.agentCommissionTableView.isHidden = false
                    self.agentCommissionTableView.reloadData()
                }
            }
        }
        else{
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

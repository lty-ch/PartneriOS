//
//  Extension+SetDataDelegate.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import Foundation

extension AgentVC : AgentListProtocolDelegate {
    
    //MARK:- Delete user
    func setDeleteUserData(data: DeleteModel) {
        if data.status == "SUCCESS"{
            
            if data.data?.isAgentDeleted == true{
                
                DispatchQueue.main.async {
                    self.showToast(message: "Agent Delete Successfully".localized(), font: FontSize.size12!)
                    
                    let partnerId =  kUserDefaults.string(forKey: "partnerID")
                    let param :[String:Any]  = ["partnerId":partnerId,"searchBy":""]
                    self.agentVCViewModel.agentListApi(param: param)
                    
                }
                
            }
        }else{
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
    
    
    //MARK:- func for block user
    func setBlockUser(data: SuccessModel) {
        if data.data?.status == "SUCCESS"{
            
            DispatchQueue.main.async {
                if self.blockStatus == "BLOCKED" {
                    self.showToast(message: "Agent Unblock Successfully".localized(), font: FontSize.size12!)
                }else {
                    self.showToast(message: "Agent block Successfully".localized(), font: FontSize.size12!)
                    
                }
                self.checkNetwork()
            }
            
            
        }else{
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
    
    func setAgentList(data: AgentVCModel) {
        
        if data.status == "SUCCESS"{
            
            self.agentListData = data.data?.agentsList! ?? []
            
            if agentListData.count == 0 {
                
                DispatchQueue.main.async {
                    
                    self.noDataFoundView.isHidden = false
                    self.tableViewAgentVC.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    //                self.noDataFoundView.isHidden = false
                    //                self.tableViewAgentVC.isHidden = true
                    self.noDataFoundView.isHidden = true
                    self.tableViewAgentVC.isHidden = false
                    self.tableViewAgentVC.reloadData()
                }
            }
        }else{
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




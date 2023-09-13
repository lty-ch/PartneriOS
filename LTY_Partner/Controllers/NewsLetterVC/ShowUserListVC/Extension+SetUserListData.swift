//
//  Extension+SetUserListData.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/08/23.
//

import Foundation

extension ShowUserListVC : CustomerListProtocolDelegate{
    
    func setCustomerList(data: CustomerModel) {
        
        if data.status == "SUCCESS" {
            self.customerListArr = data.data?.usersList ?? []
            
            if customerListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.noDataFoundView.isHidden = false
                    self.userListTableView.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self.noDataFoundView.isHidden = true
                    self.userListTableView.isHidden = false
                    self.userListTableView.reloadData()
                }
            }
        }
        else{
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
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
      
        
    }

    
    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        
        if data.status == "SUCCESS" {
           print("success")
    //        self.customerAgentArr = data.data?.agentsList ?? []
            
//            if customerAgentArr.count == 0 {
//                DispatchQueue.main.async {
//
//                    self.noDataFoundView.isHidden = false
//                    self.tableView.isHidden = true
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.noDataFoundView.isHidden = true
//                    self.tableView.isHidden = false
//                    self.tableView.reloadData()
//                }
//            }
        }
        else{
            //self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
            if data.error?.errorCode == AppKeys.invalidTokenCode {
                LTY_AppDelegate.setRootVC()
            }else {
                DispatchQueue.main.async {
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

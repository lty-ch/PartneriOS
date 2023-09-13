//
//  Extension+LeadListVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/06/23.
//

import Foundation

extension LeadListVC : LeadVcProtpcolDelegate{
    func setdata(data: LeadModel) {
        if data.status == "SUCCESS"{
            leadListArr = data.data?.leadsList ?? []
            if leadListArr.count != 0 {
                emptyView.isHidden = true
                tableView.isHidden = false
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                emptyView.isHidden = false
                tableView.isHidden = true
            }
        }else {
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
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    
}

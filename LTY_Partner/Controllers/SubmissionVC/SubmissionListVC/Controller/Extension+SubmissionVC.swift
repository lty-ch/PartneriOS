//
//  Extension+SubmissionVC.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import Foundation

extension SubmissionListVC :SubmissionVCProtpcolDelegate{
    func setdata(data: SubmissionModel) {
        if data.status == "SUCCESS"{
            submissionListArr = data.data?.proposalsList ?? []
            if submissionListArr.count != 0 {
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
        DispatchQueue.main.async {
        self.ShowAlert(message: msg)
        }
    }
    
    
}

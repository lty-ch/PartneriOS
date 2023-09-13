//
//  Extension+SetNewLetterTemplate.swift
//  LTY_Partner
//
//  Created by Chawtech on 10/08/23.
//

import Foundation

extension SendNewsLetterVC : SendNewLetterProtocol{
    func setNewsLetterData(data: SendNewsLetterModel) {
        
        if data.status == "SUCCESS" {
            self.newsTemplateArr.removeAll()
            
            self.newsTemplateArr = data.data?.templateList ?? []
            
            if newsTemplateArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.newsLettterTableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                }
            }else {
                
                DispatchQueue.main.async {
                    self.newsLettterTableView.isHidden = false
                    self.noDataFoundView.isHidden = true
                    self.newsLettterTableView.reloadData()
                }
            }
        }
        else {
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
    
    func showMessage(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
}

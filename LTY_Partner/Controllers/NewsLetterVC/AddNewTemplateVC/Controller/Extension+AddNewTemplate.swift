//
//  Extension+AddNewTemplate.swift
//  LTY_Partner
//
//  Created by Chawtech on 10/08/23.
//

import Foundation

extension AddNewTemplateVC : AddNewsLetterProtocol {
    func getNewsLetterData(data: GetTempModel) {
        
        if data.status == "SUCCESS" {
            let data = data.data
            DispatchQueue.main.async {
                
                self.textTemplateName.text = data?.templateName ?? ""
                self.textContent.text = data?.content ?? ""
                self.textTemplateTitle.text = data?.templateSettingDetails?.title ?? ""
                self.textTemplateSenderName.text = data?.templateSettingDetails?.name ?? ""
                self.textTemplatesenderEmail.text = data?.templateSettingDetails?.email ?? ""
                self.textPUserFirstName.text = data?.personalizationDetails?.firstName?.capitalized   ?? ""
                self.textPUserLastName.text = data?.personalizationDetails?.lastName?.capitalized   ?? ""
                self.textPUserMobile.text = data?.personalizationDetails?.mobile ?? ""
                self.textPUserEmail.text = data?.personalizationDetails?.email ?? ""
                self.textCompTitle.text = data?.companyDetails?.title ?? ""
                self.textCompAddress.text = data?.companyDetails?.address ?? ""
                self.textCompMobile.text = data?.companyDetails?.mobile ?? ""
                self.textCompCopyWrite.text = data?.companyDetails?.copyRight ?? ""
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
    
    func AddNewsLetterData(data: AddNewTempModel) {
        
        if data.status == "SUCCESS" {
            self.popVC(animated: true)
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

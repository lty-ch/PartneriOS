//
//  Extension+HealthInsuranceSetData.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/06/23.
//

import Foundation

extension HealthInsuranceVC : SetHeathInsuranceData {
    
    func setData(data: LeadInsuranceModel) {
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                
                let basicInfo = data.data?.memberDetails
                let fname =  basicInfo?.firstName?.capitalized   ?? ""
                let lname =  basicInfo?.lastName?.capitalized    ?? ""
                
                self.lblFullName.text = fname + lname
                self.lblEmail.text = basicInfo?.email  ?? ""
                self.lblMobile.text = basicInfo?.mobile  ?? ""
                self.lblAddress.text = basicInfo?.address  ?? ""
                self.lblNationality.text = basicInfo?.country  ?? ""
                self.lblState.text = basicInfo?.state  ?? ""
                self.lblCity.text = basicInfo?.city  ?? ""
                self.lblPostCode.text = basicInfo?.postCode  ?? ""
                
                let memberInfo = data.data
                self.lblmemberName.text =  memberInfo?.memberName ?? ""
                self.lblInsuranceType.text =  memberInfo?.insuranceType ?? ""
                self.lblRelation.text =  memberInfo?.relation  ?? ""
                
                let healthData = data.data?.metadata
                
                self.lblAge.text = healthData?.age ?? ""
                self.lblFranchise.text = healthData?.franchise ?? ""
                self.lblAccidentType.text = healthData?.withAccident ?? ""
                self.lblHealthFund.text = healthData?.currentHealthFund ?? ""
                self.lblBasicPostalCode.text = healthData?.postalCode ?? ""
                self.lblMedels.text = healthData?.models ?? ""
                
            }
        }else{
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

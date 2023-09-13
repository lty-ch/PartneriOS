//
//  Extension+TravelInsuranceSetData.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/06/23.
//

import Foundation
extension TravelInsuranceVC : SetHeathInsuranceData {
    
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
                
                self.lblAdults.text  = "\(String(describing: healthData?.adultsCount))"
                self.lblChildren.text  = "\(String(describing: healthData?.childrenCount))" 
        
                var array = healthData?.assistanceToPeople ?? []
                self.lblAssistance.text  =  array.joined(separator:",") //healthData?.assistanceToPeople?.first ?? ""
                
                var blanketsArr  = healthData?.assistanceToPeople ?? []
                self.lblDesireBlankets.text  = blanketsArr.joined(separator:",")
                self.lblinjuredPerson.text  = healthData?.personsToBeInsured ?? ""

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

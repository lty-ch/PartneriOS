//
//  Extension+AgentProfileVC.swift
//  LTY_Partner
//
//  Created by CTS on 01/06/23.
//

import Foundation
import UIKit

extension AgentProfileVC : SetAgentProfileData{
    func setData(data: AgentViewProfileModel) {
        if data.status == "SUCCESS"{
            
            DispatchQueue.main.async {
                self.lblTitle.text = "\(data.data?.firstName?.capitalized ?? "") \(data.data?.lastName?.capitalized ?? "")"
                if data.data?.dob != "" {
                    guard let dob = data.data?.dob else {return}
                    self.lblAgentSubTitle.text =  "\(self.calcAge(birthday: dob)) Yrs"
                    self.lblDob.text = returnDOB(date: dob)
                }
                
                //MARK:- persnal Details
                
                if ((data.data?.profilePic) != nil) {
                    self.imgProfile.sd_setImage(with: URL(string: data.data?.profilePic ?? ""), placeholderImage:UIImage(named: data.data?.gender == "Male" ? "user_male" : "user_female"))
                }else{
                    self.imgProfile.sd_setImage(with: URL(string: data.data?.profilePic ?? ""), placeholderImage:UIImage(named: data.data?.gender == "Male" ? "user_male" : "user_female"))
                }
                
//                self.imgProfile.sd_setImage(with:URL(string: data.data?.profilePic ?? ""), placeholderImage:UIImage(named: "user"))
                self.lblCity.text = data.data?.city
                self.lblEmail.text = data.data?.email
                self.lblState.text = data.data?.state
                self.lblGender.text = "N/A"//data.data?.dob
                let countryCode = data.data?.countryCode ?? ""
                self.lblMobile.text = "\(countryCode) \(data.data?.mobile ?? "")"
                //self.lblMobile.text = data.data?.mobile
                self.lblAddress.text = data.data?.address
                self.lblCountry.text = data.data?.country
                self.lblFullName.text = "\(data.data?.firstName?.capitalized ?? "") \(data.data?.lastName?.capitalized ?? "")"
                self.lblUSerType.text = data.data?.profile
                self.lblPostCode.text = data.data?.postCode
                self.lblAgentName.text = data.data?.firstName?.capitalized  
                self.lblRole.text = data.data?.roleName
                
                /*
                //MARK:- Copmny data
                self.lblCompPO.text = data.data?.companyDetails?.companyPo
                self.lblCompCity.text = data.data?.companyDetails?.city
                self.lblCompName.text = data.data?.companyDetails?.companyName
                self.lblCompState.text = data.data?.companyDetails?.state
                self.lblPrivateOP.text = data.data?.companyDetails?.privateOp
                self.lblCompFinam.text = data.data?.companyDetails?.finamNo
                self.lblCompEmail.text = data.data?.companyDetails?.email
                self.lblCompMobile.text = data.data?.companyDetails?.telephone
                self.lblCompCountry.text = data.data?.companyDetails?.country
                self.lblCompCirceo.text = data.data?.companyDetails?.ciceroNo
                self.lblCompWebsite.text = data.data?.companyDetails?.website
                self.lblCompAddress.text = data.data?.companyDetails?.address
                self.lblCompPostCode.text = data.data?.companyDetails?.postCode
                self.lblCompCriminalRecord.text = data.data?.companyDetails?.privateCriminalRecord
                */
                
                //MARK:- bank Details
                self.lblBank.text = data.data?.bankDetails?.bank
                self.lblIBAN.text = data.data?.bankDetails?.iban
                self.lblSwiftBIC.text = data.data?.bankDetails?.swift
                self.lblBankCountry.text = data.data?.bankDetails?.country
                self.lblBankSate.text = data.data?.bankDetails?.state
                self.lblBankCity.text = data.data?.bankDetails?.city
                self.lblBankAddress.text = data.data?.bankDetails?.address
                self.lblBAnkPostCode.text = data.data?.bankDetails?.postCode

                

                

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
    
    func showMsg(msg: String) {
        DispatchQueue.main.async {
            
            self.ShowAlert(message: msg)
        }
    }
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        if birthday.contains(".") {
            print("dd.mm.yyyy")

            dateFormater.dateFormat = "dd.mm.yyyy"
            let birthdayDate = dateFormater.date(from: birthday)
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
            let now = Date()
            let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
            let age = calcAge.year
            
            return age!

        }else {
            print("yyyy-MM-dd")
            dateFormater.dateFormat = "yyyy-MM-dd"
            let birthdayDate = dateFormater.date(from: birthday)
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
            let now = Date()
            let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
            let age = calcAge.year
            
            return age!
        }

    }
    
    
}

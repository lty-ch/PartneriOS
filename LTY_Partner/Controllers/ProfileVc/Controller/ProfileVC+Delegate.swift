//
//  ProfileVC+Delegate.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 18/05/23.
//

import Foundation
import UIKit

extension ProfileVC : ProfileProtocolDelegate {

    
    func changePass(data: ChangePassModel) {
        if data.data?.isPasswordChanged == true {
            DispatchQueue.main.async {
                self.textOldPass.text = ""
                self.textNewPass.text = ""
                self.textConfirmPass.text = ""
                self.ShowAlert(message: "Password Change successfully")

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
    func setProfile(data: ProfileModel) {

        if data.status == "ERROR" {
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
        else {
            DispatchQueue.main.async {
                
                let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
                
                let userName = kUserDefaults.value(forKey: AppKeys.agentName)
                let companyName = kUserDefaults.value(forKey: AppKeys.companyName)
            
                if userType == "AGENT" {
                    let fName = data.data?.firstName?.capitalized   ?? ""
                    let lName = data.data?.lastName?.capitalized   ?? ""
                    self.lblUserName.text = fName + " " + lName
                    
                    kUserDefaults.set(fName + " " + lName, forKey: AppKeys.agentName)
                    
                    self.textCompanyCCode.text = data.data?.companyDetails?.countryCode ?? ""
                    self.textCompEmail.text = data.data?.companyDetails?.email ?? ""
                    self.textCompMobile.text = "\(data.data?.companyDetails?.telephone ?? "")"
                    self.textPhone.text = data.data?.mobile ?? ""
                    self.textPersnalInfoCCode.text = data.data?.countryCode ?? ""
                    self.textEmail.text = "\(data.data?.email ?? "")"

                }
                else {
                    kUserDefaults.set(data.data?.companyDetails?.companyName, forKey: AppKeys.companyName)
                    //.value(forKey: AppKeys.companyName)
                    self.lblUserName.text = data.data?.companyDetails?.companyName
                    
                    self.textCompanyCCode.text = data.data?.countryCode ?? ""
                    self.textPhone.text = "\(data.data?.companyDetails?.telephone ?? "")"
                    self.textCompEmail.text = data.data?.email ?? ""
                    self.textCompMobile.text = data.data?.mobile ?? ""
                    self.textPersnalInfoCCode.text = data.data?.companyDetails?.countryCode ?? ""
                    self.textEmail.text = "\(data.data?.companyDetails?.email ?? "")"
                     
                    
//                    self.textCompanyCCode.text = data.data?.companyDetails?.countryCode ?? ""
//                    self.textCompEmail.text = data.data?.companyDetails?.email ?? ""
//                    self.textCompMobile.text = "\(data.data?.companyDetails?.telephone ?? "")"
//                    self.textPhone.text = data.data?.mobile ?? ""
//                    self.textPersnalInfoCCode.text = data.data?.countryCode ?? ""
//                    self.textEmail.text = "\(data.data?.email ?? "")"
                }
                
                if  let userImage = data.data?.profilePic {
                    self.imgUserImage.sd_setImage(with:  URL(string:userImage as! String), placeholderImage: UIImage(named: "user"))
                    kUserDefaults.set(data.data?.profilePic,forKey: AppKeys.profile)

                }else{
                    self.imgUserImage.image = UIImage(named: "user")

                }

    
                
                /*
                 if  let userImage = kUserDefaults.value(forKey: AppKeys.profile) {
                     self.imgUserImage.sd_setImage(with:  URL(string:userImage as! String), placeholderImage: UIImage(named: "user"))

                 }else{
                     self.imgUserImage.image = UIImage(named: "user")

                 }
                 
                */
                
                self.textFirstName.text = "\(data.data?.firstName?.capitalized   ?? "")"
                self.textLastName.text = "\(data.data?.lastName?.capitalized   ?? "")"
                self.textDOB.text = returnDOB(date: data.data?.dob ?? "")
                self.agentDob = data.data?.dob ?? ""
                //"\(data.data?.dob ?? "")"
                self.textAddress.text = "\(data.data?.address ?? "")"
                self.textCountry.text = "\(data.data?.country ?? "")"
                self.textState.text = "\(data.data?.state ?? "")"
                self.textCity.text = "\(data.data?.city ?? "")"
                self.textPostCode.text = "\(data.data?.postCode ?? "")"
                self.textLanguage.text = "\(data.data?.language ?? "")"
                self.textNationality.text = "\(data.data?.nationality ?? "")"
                self.textCompanyName.text = "\(data.data?.companyDetails?.companyName ?? "")"
                self.textWebSite.text = "\(data.data?.companyDetails?.website ?? "")"
                self.textIBAN.text = "\(data.data?.bankDetails?.iban ?? "")"
                self.textSwiftBIC.text = "\(data.data?.bankDetails?.swift ?? "")"
                self.textBank.text = "\(data.data?.bankDetails?.bank ?? "")"
                self.textCompAddress.text = "\(data.data?.bankDetails?.address ?? "")"
                self.textCompPostCode.text = "\(data.data?.bankDetails?.postCode ?? "")"
                self.textBankCountry.text = "\(data.data?.bankDetails?.country ?? "")"
                self.textBankSate.text = "\(data.data?.bankDetails?.state ?? "")"
                self.textBankCity.text = "\(data.data?.bankDetails?.city ?? "")"
                

                self.textFiemNo.text = data.data?.companyDetails?.finamNo ?? ""
                self.textCireoNo.text = data.data?.companyDetails?.ciceroNo ?? ""
                self.textCCountry.text = data.data?.companyDetails?.country ?? ""
                self.textCompState.text = data.data?.companyDetails?.state ?? ""
                self.textCompCity.text = data.data?.companyDetails?.city ?? ""
                self.textCompAdd.text = data.data?.companyDetails?.address ?? ""
                self.textCompPost.text = data.data?.companyDetails?.postCode ?? ""
                
              //  self.textPrivateCriminalRecord.text = data.data?.companyDetails?.privateCriminalRecord ?? ""
                var dataCriminalRecord = data.data?.companyDetails?.privateCriminalRecord ?? ""
                self.privateCriminalRecord = dataCriminalRecord
                let data1 = dataCriminalRecord
                if let lastSlashIndex1 = data1.lastIndex(of: "/") {
                    let fileName1 = String(data1[data1.index(after: lastSlashIndex1)...])
                    self.textPrivateCriminalRecord.text = fileName1
                    
                    //            print("File Name: \(fileName)")
                } else {
                  //  print("Invalid URL format")
                }
                
                var datacompanyPo = data.data?.companyDetails?.companyPo ?? ""
                self.companyPO = datacompanyPo
                let dataCompnyPO = datacompanyPo
                if let lastSlashIndex2 = dataCompnyPO.lastIndex(of: "/") {
                    let fileName2 = String(dataCompnyPO[dataCompnyPO.index(after: lastSlashIndex2)...])
                    self.textCompnyPO.text = fileName2
                    //            print("File Name: \(fileName)")
                } else {
                   // print("Invalid URL format")
                }
                
                var dataprivateOp = data.data?.companyDetails?.privateOp ?? ""
                self.privateOP = dataprivateOp
                let dataPrivateOP = dataprivateOp
                if let lastSlashIndex = dataPrivateOP.lastIndex(of: "/") {
                    let fileName3 = String(dataPrivateOP[dataPrivateOP.index(after: lastSlashIndex)...])
                    self.textPrivateOP.text = fileName3
                    //            print("File Name: \(fileName)")
                } else {
                  //  print("Invalid URL format")
                }

               // self.textPrivateOP.text = data.data?.companyDetails?.privateOp ?? ""
                //self.textCompnyPO.text = data.data?.companyDetails?.companyPo ?? ""
                
            }
        }
    }

    func updateProfile(data: ProfileModel) {
        print("")
    }

    
    
}

extension ProfileVC : SignUpProtocolDelegate {
  

    func setCountryList(countryData: CountryModel) {
        //print(countryData.data.countriesList.first?.name)
        self.drpDownCounrtyListArray.append(CountryModel.init(status: countryData.status, data: countryData.data))
        
        self.newDrpDownCounrtyListArray.removeAll()
        for i in 0..<countryData.data.countriesList.count
        {
            let id = countryData.data.countriesList[i].id
            let name = countryData.data.countriesList[i].name
            let countryCode = countryData.data.countriesList[i].phonecode
            self.newDrpDownCounrtyListArray.append(DrpDownListStruct.init(id: id, phoneCode: countryCode, name: name))
        }
    }
    func setStateList(stateData: StateModel) {
        self.drpDownStateListArray.append(StateModel.init(status: stateData.status, data: stateData.data))
        self.newDrpDownStateListArray.removeAll()
        for i in 0..<stateData.data.statesList.count
        {
            let id = stateData.data.statesList[i].id
            let name = stateData.data.statesList[i].name
            self.newDrpDownStateListArray.append(DrpDownListStruct.init(id: id, phoneCode: 0, name: name))
            
        }
    }
    func setCityList(cityData: CityModel) {
        self.drpDownCityListArray.append(CityModel.init(status: cityData.status, data: cityData.data))
        self.newDrpDownCityListArray.removeAll()
        for i in 0..<cityData.data.citiesList.count
        {
            let id = cityData.data.citiesList[i].id
            let name = cityData.data.citiesList[i].name
            self.newDrpDownCityListArray.append(DrpDownListStruct.init(id: id, phoneCode: 0, name: name))
        }
    }
    func setSignup(data : ProfileModel) {
    }
  
    func setSignup(data: SignUpModel) {
        print("")
        
    }
    
    
}

//MARK:- This extension is use for dismiss present screen first after that present another screen

extension ProfileVC :DismissScreen {
    
    func dismissScreen(setValue: Bool,data: ForgotPassValue) {
        if setValue == true {
            //            let vc = ResetPassVC.instantiate(fromAppStoryboard: .main)
            //            //self.storyboard?.instantiateViewController(withIdentifier: "ResetPassVC") as! ResetPassVC
            //            vc.userEmail = data.userEmail ?? ""
            //            vc.forgotPassData.append(ForgotPassData.init(otpID: data.otpID, duration: data.duration, remainingAttempts: data.remainingAttempts, resendOtpTime: data.resendOtpTime))
            //            vc.modalPresentationStyle = .overCurrentContext
            //            self.present(vc, animated: true)
        }else {
            
        }
    }
    
}

extension ProfileVC : AddAgentProtocolDelegate
{
 
    func setRolesList(data: RolesModel) {
        print("")
    }
    
    func showToastMessg(toast: String) {
        
        DispatchQueue.main.async {
            self.showToast(message: toast, font: FontSize.size14!)
            self.popVC(animated: true)
            
        }
        
    }
    
    func setSignup(data: AddNewAgentModel) {
        print("")
    }
    
    func setAgentEditDetailData(data: AgentEditDetailModel) {
        
        if data.status == "SUCCESS" {
            
            
            let fName = data.data?.firstName?.capitalized   ?? ""
            let lName = data.data?.lastName?.capitalized   ?? ""
            self.lblUserName.text = fName + " " + lName
            kUserDefaults.set(fName + " " + lName, forKey: AppKeys.agentName)

            if  let userImage = data.data?.profilePic {
                self.imgUserImage.sd_setImage(with:  URL(string:userImage as! String), placeholderImage: UIImage(named: "user"))
                kUserDefaults.set(data.data?.profilePic,forKey: AppKeys.profile)

            }else{
                self.imgUserImage.image = UIImage(named: "user")

            }
            
//            if isCommingFrom == "Edit_agent_detail" {
//   
//                self.textEmail.text = data.data?.email ?? ""
//            }
//            else {
//                
//            }
            
            self.textPersnalInfoCCode.text = data.data?.countryCode
            self.textCompanyCCode.text = data.data?.companyDetails?.countryCode ?? ""
            self.txtProfile.text            = data.data?.profile ?? ""
            self.txtAgentCommision.text     = "\(data.data?.commissionDetails?.agentCommission ?? 0.0)"
            self.txtCompReserve.text        = "\(data.data?.commissionDetails?.companyReserve ?? 0.0)"
            self.txtAgentReserve.text       = "\(data.data?.commissionDetails?.agentReserve ?? 0.0)"
            self.textDOB.text               = returnDOB(date: data.data?.dob ?? "")//data.data?.dob
            self.agentDob = data.data?.dob ?? ""
            self.textFirstName.text         = data.data?.firstName?.capitalized   ?? ""
            self.textLastName.text          = data.data?.lastName?.capitalized   ?? ""
            self.textPhone.text             = data.data?.mobile ?? ""
            self.textEmail.text             = data.data?.email ?? ""
            self.textAddress.text           = data.data?.address ?? ""
            self.textCountry.text           = data.data?.country ?? ""
            self.textState.text             = data.data?.state ?? ""
            self.textCity.text              = data.data?.city ?? ""
            self.textPostCode.text          = data.data?.postCode ?? ""
            self.textLanguage.text          = data.data?.language ?? ""
            self.textNationality.text       = data.data?.nationality ?? ""
            self.textCompanyName.text       = data.data?.companyDetails?.companyName ?? ""
            self.textWebSite.text           = data.data?.companyDetails?.website ?? ""
            self.textIBAN.text              = data.data?.bankDetails?.iban ?? ""
            self.textSwiftBIC.text          = data.data?.bankDetails?.swift ?? ""
            self.textBank.text              = data.data?.bankDetails?.bank ?? ""
            
            self.textCompAddress.text       = data.data?.bankDetails?.address ?? ""
            self.textCompPostCode.text      = data.data?.bankDetails?.postCode ?? ""
            self.textBankCountry.text       = data.data?.bankDetails?.country ?? ""
            self.textBankSate.text = "\(data.data?.bankDetails?.state ?? "")"
            self.textBankCity.text = "\(data.data?.bankDetails?.city ?? "")"
            
            
            //MARK:- company params
            //        self.textCompanyName.text  = data.data?.companyDetails?.companyName
            //        self.textWebSite.text      = data.data?.companyDetails?.website
            self.textFiemNo.text       = data.data?.companyDetails?.finamNo ?? ""
            self.textCireoNo.text      = data.data?.companyDetails?.ciceroNo ?? ""
            self.textCompMobile.text   = data.data?.companyDetails?.telephone ?? ""
            self.textCompEmail.text    = data.data?.companyDetails?.email ?? ""
            self.textCompCity.text     = data.data?.companyDetails?.city ?? ""
            self.textCompState.text    = data.data?.companyDetails?.state ?? ""
            self.textCompAdd.text      = data.data?.companyDetails?.address ?? ""
            self.textCompPost.text     = data.data?.companyDetails?.postCode ?? ""
            self.textCCountry.text     = data.data?.companyDetails?.country ?? ""
            
//            self.textPrivateCriminalRecord.text = data.data?.companyDetails?.privateCriminalRecord
//            self.textPrivateOP.text = data.data?.companyDetails?.privateOp
//            self.textCompnyPO.text = data.data?.companyDetails?.companyPo
            
          
              var dataCriminalRecord = data.data?.companyDetails?.privateCriminalRecord ?? ""
              self.privateCriminalRecord = dataCriminalRecord
              let data1 = dataCriminalRecord
              if let lastSlashIndex1 = data1.lastIndex(of: "/") {
                  let fileName1 = String(data1[data1.index(after: lastSlashIndex1)...])
                  self.textPrivateCriminalRecord.text = fileName1
                  
                  //            print("File Name: \(fileName)")
              } else {
                //  print("Invalid URL format")
              }
              
              var datacompanyPo = data.data?.companyDetails?.companyPo ?? ""
              self.companyPO = datacompanyPo
              let dataCompnyPO = datacompanyPo
              if let lastSlashIndex2 = dataCompnyPO.lastIndex(of: "/") {
                  let fileName2 = String(dataCompnyPO[dataCompnyPO.index(after: lastSlashIndex2)...])
                  self.textCompnyPO.text = fileName2
                  //            print("File Name: \(fileName)")
              } else {
                 // print("Invalid URL format")
              }
              
              var dataprivateOp = data.data?.companyDetails?.privateOp ?? ""
              self.privateOP = dataprivateOp
              let dataPrivateOP = dataprivateOp
              if let lastSlashIndex = dataPrivateOP.lastIndex(of: "/") {
                  let fileName3 = String(dataPrivateOP[dataPrivateOP.index(after: lastSlashIndex)...])
                  self.textPrivateOP.text = fileName3
                  //            print("File Name: \(fileName)")
              } else {
                //  print("Invalid URL format")
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
}



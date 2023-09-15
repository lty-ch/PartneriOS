//
//  AddNewAgent+Delegate.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import Foundation

extension AddNewAgentVC : AddAgentProtocolDelegate {
    
    func showToastMessg(toast: String) {
        
        
        DispatchQueue.main.async {
            self.showToast(message: toast, font: FontSize.size14!)
            self.popVC(animated: true)
        }
        
    }
    
    
    func setAgentEditDetailData(data: AgentEditDetailModel) {
        
        self.txtProfile.text            = data.data?.profile
        self.txtAgentCommision.text     = "\(data.data?.commissionDetails?.agentCommission ?? 0.0)"
        self.txtCompReserve.text        = "\(data.data?.commissionDetails?.companyReserve ?? 0.0)"
        self.txtAgentReserve.text       = "\(data.data?.commissionDetails?.agentReserve ?? 0.0)"
        self.textDob.text               = data.data?.dob
        self.textFirstName.text         = data.data?.firstName?.capitalized
        self.textLastName.text          = data.data?.lastName?.capitalized  
        self.textPhone.text             = data.data?.mobile
        self.textEmail.text             = data.data?.email
        self.textAddress.text           = data.data?.address
        self.textCountry.text           = data.data?.country
        self.textState.text             = data.data?.state
        self.textCity.text              = data.data?.city
        self.textPostCode.text          = data.data?.postCode
        self.textLanguage.text          = data.data?.language
        self.textNationality.text       = data.data?.nationality
        self.textCompanyName.text       = data.data?.companyDetails?.companyName
        self.textWebSite.text           = data.data?.companyDetails?.website
        self.textIBAN.text              = data.data?.bankDetails?.iban
        self.textSwiftBIC.text          = data.data?.bankDetails?.swift
        self.textBank.text              = data.data?.bankDetails?.bank
        self.textCompAddress.text       = data.data?.bankDetails?.address
        self.textCompPostCode.text      = data.data?.bankDetails?.postCode
        self.textBankCountry.text       = data.data?.bankDetails?.country
        
    }
    
    
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
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    func setSignup(data : AddNewAgentModel) {
        
        if data.status == "ERROR" {
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
        else {
            DispatchQueue.main.async {
                self.popVC(animated: true)
            }
        }
    }
    
    
    //MARK:- get Agent Roles
    
    
    func setRolesList(data: RolesModel) {
        
        self.roleListArr.removeAll()
        if data.status == "SUCCESS" {
            self.roleListArr = data.data?.rolesList ?? []
            if roleListArr.count == 0 {
                
                self.showAlertWithActions(msg: "Please add Role first.".localized(), titles: ["Yes".localized(), "Not Now".localized()]) { (value) in
                    if value == 1{
                        let vc = RulesVC.instantiate(fromAppStoryboard: .ruleStoryboard)
                        self.pushToVC(vc, animated: true)
                    }
                }
                
                
            } else {
            
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

extension AddNewAgentVC : DismissOtpVerifyVCDelegate{
    func dimissOtpVerifyVC(setValue: Bool) {
        if setValue == true{
            self.popVC(animated: true)
        }
    }
}


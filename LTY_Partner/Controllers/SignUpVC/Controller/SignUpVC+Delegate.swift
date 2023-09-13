//
//  SignUpVC+Delegate.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 15/05/23.
//

import Foundation

extension SignUpVC : SignUpProtocolDelegate {
    
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
          //  self.counrtyCodeListArray.append(DrpDownListStruct.init(id:countryCode , name: ""))
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
    
    func setSignup(data : SignUpModel) {
        
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
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerifyVC") as! OtpVerifyVC
                vc.delegate = self
                vc.verifiedEmail = self.textCompEmail.text ?? ""
                vc.otpId = String(data.data?.processStageData?.txnStateData?.otpID ?? "")
                vc.comingFrom = "signUp"
                vc.emailOtpID = String(data.data?.processStageData?.emailTxnStateData?.otpID ?? "")
                vc.phoneNumber = self.textCompPhone.text ?? ""
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }
        }
    }
}

extension SignUpVC : DismissOtpVerifyVCDelegate{
    func dimissOtpVerifyVC(setValue: Bool) {
        if setValue == true{
            self.popVC(animated: true)
        }
    }
}

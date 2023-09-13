//
//  UpdatePhoneEmailVC+Delegate.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 22/05/23.
//

import Foundation


extension UpdatePhoneEmailVC : UpdatePhoneEmailProtocolDelegate {
    
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
    
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    func setData(data : ForgotVCModel) {
        
        print(self.isCommingFrom)
        
        if data.status == "ERROR" {
            DispatchQueue.main.async {
                self.ShowAlert(message:data.error?.clientErrorMessage ?? "")
            }
        }
        else {
            DispatchQueue.main.async {
                
                self.dismiss(animated: false) {
                    self.delegate?.dismissScreenInProfileModule(setValue: true,data: ForgotPassValue.init(otpID: data.data?.otpID, userEmail: self.textEmail.text ?? "", duration: data.data?.timeoutInSeconds, remainingAttempts: data.data?.remainingAttempts, resendOtpTime: data.data?.resendOtpTime),isComming: self.isCommingFrom)
                    
                }
            }
        }
    }
}

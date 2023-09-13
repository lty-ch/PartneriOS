//
//  UpdatePhoneEmailViewModel.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 22/05/23.
//

import Foundation
//


protocol UpdatePhoneEmailProtocolDelegate : AnyObject {
    func setData(data : ForgotVCModel)
    func setCountryList(countryData:CountryModel)
    func popupMsg(msg : String)
}


class UpdatePhoneEmailViewModel {
    
    var forgotPassData = [UpdatePhoneEmailViewModel]()
    weak var delegate : UpdatePhoneEmailProtocolDelegate?
    
    var ListData : UpdatePhoneEmailViewModel!
    init(data:UpdatePhoneEmailViewModel? = nil) {
        if data == nil {
        return
    }
    self.ListData = data
        
    }
    //MARK:- call Api func
    
    func updateEmailApi1(param:[String:Any]) {
        
        Services.shareInstance.register(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.resendOtp, expecting:ResendOtpM.self, dataDict: param) { response
            in
            switch response {
            case .success(let result):
                print("success")

               // self.delegate?.popupMsg(msg:result.status)

                
            case .failure(let error):
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    
    func updatePhoneApi2(param:[String:Any]) {
        
        Services.shareInstance.register(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.resendOtp, expecting:ResendOtpM.self, dataDict: param) { response
            in
            switch response {
            case .success(let result):
                print("success")
               // self.delegate?.popupMsg(msg:result.status)

                
            case .failure(let error):
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    
    func updatePhoneApi(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        let urlStr = LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.profileUpadtePhone
        
        Services.shareInstance.putRequestApiForUpdatePhoneEmail(url: urlStr, method: "PUT", passToken: true, expecting:ForgotVCModel.self, dataDict: param) { response in
            print(response)
            switch response {
              
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.setData(data: result)
                }
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        }
    }
    func updateEmailApi(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        let urlStr = LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.profileUpadteEmail
        
        Services.shareInstance.putRequestApiForUpdatePhoneEmail(url: urlStr, method: "PUT", passToken: true, expecting:ForgotVCModel.self, dataDict: param) { response in
            switch response {
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.setData(data: result)
                }
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        }
    }
    
   //MARK:- get county List 
    func getCountryListApi() {
        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_COMMON + LTY_END_POINT_URL.COUNTRIES_URL), shouldSendHeader: false, expecting: CountryModel.self) { response in
            switch response {
            case .success (let result) :
                self.delegate?.setCountryList(countryData:result)
            case.failure (let error) :
                print(error)
            }
        }
    }
    
    
    
    
    
    
    func networkServiceCall (param:ForgotParams){
        
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.ForgotPass(params:param){ [self] (list, error) in
//            
//            if error == nil {
//                
//                self.forgotPassData = (list?.map({return ForgotVCViewModel(data:$0) }))!
//                
//                if self.forgotPassData.count != 0 {
//                    delegate?.setData(data:(forgotPassData.first?.ListData)!)
//                    SwiftLoader.hide()
//
//                }
//                else {
//                    DispatchQueue.main.async {
//                        SwiftLoader.hide()
//                        self.delegate?.popupMsg(msg: "Data is not Available.")
//                    }
//                }
//                
//            }
//            else{
//                DispatchQueue.main.async {
//                    SwiftLoader.hide()
//                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.")
//                }
//            }
//
//        }
        
    }
    
    
 // END api calling func
}

    



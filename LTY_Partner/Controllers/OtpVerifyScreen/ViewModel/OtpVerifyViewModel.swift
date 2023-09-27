//
//  OtpVerifyViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation

protocol OtpVerifyProtocolDelegate : AnyObject {
    func setOtpData(data : OtpVerifyModel)
    func setProfileDate(data : ProfileModel)
    func popupMsg(msg : String)
    func dismiss(setDismiss:Bool)
}


class OtpVerifyViewModel {
    
    var otpVerifyData = [OtpVerifyViewModel]()
    weak var delegate : OtpVerifyProtocolDelegate?
    
    var ListData : OtpVerifyModel!
    init(data:OtpVerifyModel? = nil) {
        if data == nil {
        return
    }
    self.ListData = data
        
    }
    //MARK:- call Api func
    
    func networkServiceCall (param:OTPVerifyParams){
        
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.OtpVerify(params:param){ [self] (list, error) in
            
            if error == nil {
                if list?.first?.status == "SUCCESS"  {
                    self.otpVerifyData = (list?.map({return OtpVerifyViewModel(data:$0) }))!
                    
                    if self.otpVerifyData.count != 0 {
                        delegate?.setOtpData(data:(otpVerifyData.first?.ListData)!)
                        SwiftLoader.hide()
                        
                    }
                    else {
                        DispatchQueue.main.async {
                            SwiftLoader.hide()
                            self.delegate?.popupMsg(msg: "Data is not Available.".localized())
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg:(list?.first?.error?.serverErrorMessage ??  "" ))
                    }
                }
                
            }
            else{
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.".localized())
                }
            }

        }
        
    }
    func networkServiceCallForVerifyPhone(param:OTPVerifyPhoneParams,isComming:String){
        
        SwiftLoader.show(animated: true)
        Services.shareInstance.OtpVerifyForPhone(params:param, isComming: isComming){ [self] (list, error) in
            SwiftLoader.hide()
            if error == nil {
            
                if list?.first?.status == "SUCCESS"  {
                    DispatchQueue.main.async {
                        let userInfo: [AnyHashable : Any] = ["mobile": list?.first?.data?.mobile ,"countryCode":list?.first?.data?.countryCode]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateEmailPhone"), object: nil, userInfo: userInfo)
                        self.delegate?.dismiss(setDismiss: true)
                    }

                }
                else {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg:(list?.first?.error?.serverErrorMessage ??  "" ))
                    }
                }
                
            }
            else{
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.".localized())
                }
            }

        }
        
    }
    func networkServiceCallForVerifyEmail(param:OTPVerifyEmailParams,isComming:String){
        
        SwiftLoader.show(animated: true)
        Services.shareInstance.OtpVerifyForEmail(params:param, isComming: isComming){ [self] (list, error) in
            SwiftLoader.hide()
           
            if error == nil {
                if list?.first?.status == "SUCCESS" {
                    DispatchQueue.main.async {

                        let userInfo: [AnyHashable : Any] = ["email": list?.first?.data?.email]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateEmailPhone"), object: nil, userInfo: userInfo)

                        self.delegate?.dismiss(setDismiss: true)

                    }
                }

                else {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg:(list?.first?.error?.serverErrorMessage ??  "" ))
                    }
                }

            }
            else{
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.".localized())
                }
            }

        }
        
    }
 // END api calling func
    
    
    //MARK:- Api Calling func for Resend Password Api
    
    func resendPasswordApi (param:[String:Any]) {
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.resendOtp, method: "put", isPassToken: false, expecting:ResendOtpM.self, dataDict: param) { response
            in

            switch response {
            case .success(let result):
                print(result)
                
               // self.delegate?.popupMsg(msg:result.status)

                
            case .failure(let error):
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    // End Resend Password Api func
    
    //MARK:- Check UserRole Api
    
    func getUserRoleApi(param:[String:Any]) {
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url:LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.getUserRole, method: "POST", passToken: true, expecting:RoleDetailModel.self, dataDict: param) { response in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                UserDefaults.standard.setValue(try? PropertyListEncoder().encode(result.data), forKey: AppKeys.roleList)

               
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    
                }
            }

        }

    }
    //MARK:- profle detial Api
    
    func profileDetailApi(param:[String:Any]) {
        
        let urlStr = "\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.PROFILE_DETAIL_URL)"
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApiForProfileDetail(url: urlStr, method: "POST", passToken: true, expecting:ProfileModel.self, dataDict: param) { response in
          
           print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                if result.status == "SUCCESS"{
          
                DispatchQueue.main.async {
                    self.delegate?.setProfileDate(data: result)
                }
            }
            case .failure(let error):
                SwiftLoader.hide()
                /*
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
                */
            }
        }
    }
    
}

    


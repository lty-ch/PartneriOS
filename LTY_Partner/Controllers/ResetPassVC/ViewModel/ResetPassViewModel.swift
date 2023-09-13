//
//  ResetPassViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 15/05/23.
//

import Foundation

protocol ResetPassProtocolDelegate : AnyObject {
    func setData(data : ResetPassModel)
    func popupMsg(msg : String)
}


class ResetPassViewModel {
    
    var resetPassData = [ResetPassViewModel]()
    weak var delegate : ResetPassProtocolDelegate?
    
    var ListData : ResetPassModel!
    init(data:ResetPassModel? = nil) {
        if data == nil {
        return
    }
    self.ListData = data
        
    }
    //MARK:- call Api func
    
    func networkServiceCall (param:ResetPassParam){
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.ResetPassword(params:param){ [self] (list, error) in
            
            if error == nil {
                
                self.resetPassData = (list?.map({return ResetPassViewModel(data:$0) }))!
                
                if self.resetPassData.count != 0 {
                    delegate?.setData(data:(resetPassData.first?.ListData)!)
                    SwiftLoader.hide()

                }
                else {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg: "Data is not Available.")
                    }
                }
                
            }
            else{
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.")
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
              //  self.delegate?.popupMsg(msg:result.status)

                
            case .failure(let error):
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    // End Resend Password Api func
}

    


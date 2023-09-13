//
//  LoginViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation

protocol LoginSignUpProtocolDelegate : AnyObject {
    func setLoginSignup(data : LoginModel)
    func popupMsg(msg : String)
}


class LoginViewModel {
    var loginData = [LoginViewModel]()
    weak var delegate : LoginSignUpProtocolDelegate?
    
    var ListData : LoginModel!
    init(data:LoginModel? = nil) {
        if data == nil {
        return
    }
    self.ListData = data
        
    }
    //MARK:- call Api func
    
    func networkServiceCall (param:LoginParams){
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.LoginApi(params:param){ [self] (list, error) in
            
            if error == nil {
                
                self.loginData = (list?.map({return LoginViewModel(data:$0) }))!
                
                if self.loginData.count != 0 {
                    delegate?.setLoginSignup(data:(loginData.first?.ListData)!)
                    SwiftLoader.hide()

                }
                else {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg: "Data is not Available.".localized())
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
}

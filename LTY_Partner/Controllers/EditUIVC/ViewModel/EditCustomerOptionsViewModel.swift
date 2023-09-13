//
//  EditCustomerOptionsViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import Foundation

protocol EditCustomerOptionsProtocolDelegate : AnyObject {
    func setBlockCustomerdata(data : SuccessModel)
    func popupMsg(msg : String)
}


class EditCustomerOptionsViewModel {
    
    weak var delegatee : EditCustomerOptionsProtocolDelegate?
    
    func blockCustomerApi (param:[String:Any]) {
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.blockUser, method: "put", isPassToken: true, expecting:SuccessModel.self, dataDict: param) { response
            in
            switch response {
            case .success(let result):
                
                self.delegatee?.setBlockCustomerdata(data: result)

                
            case .failure(let error):
                self.delegatee?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    
}



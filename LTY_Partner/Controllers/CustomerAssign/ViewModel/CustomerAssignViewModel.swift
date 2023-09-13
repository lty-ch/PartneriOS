//
//  CustomerAssignViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import Foundation

protocol CustomerAssignAgentProtocolDelegate : AnyObject {
    func setCustomerAssignAgentApi(data : SuccessModel)
    func onLeadAssignAgentApi(data : SuccessModel)
    func popupMsg(msg : String)
}

class CustomerAssignViewModel {
    
    weak var delegate : CustomerAssignAgentProtocolDelegate?

    func customerAssignAgentApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.customerAssignAgent, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustomerAssignAgentApi(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
   
    func assignAgentApiUsingLead (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.leadAssignAgent, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.onLeadAssignAgentApi(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
}

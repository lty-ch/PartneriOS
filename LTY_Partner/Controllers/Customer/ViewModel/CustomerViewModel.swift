//
//  CustomerViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import Foundation

protocol CustomerListProtocolDelegate : AnyObject {
    func setCustomerList(data : CustomerModel)
    func setCustomerAgentList(data : CustomerActiveAgentModel)
    
    func popupMsg(msg : String)
}

protocol ModifyCommissionProtocolDelegate : AnyObject {
    func setModifyCommissionData(data : SuccessModel)
}



class CustomerViewModel {
    
    weak var delegate : CustomerListProtocolDelegate?
    weak var modifyCommissiondelegate : ModifyCommissionProtocolDelegate?


    func customerListApi (param:[String:Any],url:String) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url:url , method: "POST", passToken: true, expecting:CustomerModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustomerList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }

    //MARK:- Delete Api
    
    func getCustomerActiveAgent (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomerActiveAgents, method: "POST", passToken: true, expecting:CustomerActiveAgentModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustomerAgentList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func modifyCommissionApi (param:[String:Any],url:String) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url:url , method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.modifyCommissiondelegate?.setModifyCommissionData(data: result)

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

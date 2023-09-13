//
//  AgentCommission+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation


protocol AgentCommissionListProtocolDelegate : AnyObject {
    func setAgentList(data : AgentCommissionModel)
    func setAgentCommissionList(data:SuccessModel)
    func popupMsg(msg : String)
}

class AgentCommissionViewModel {
    
    weak var delegate : AgentCommissionListProtocolDelegate?
    
    func agentCommissionListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.GET_AGENT_COMMISSION, method: "POST", passToken: true, expecting:AgentCommissionModel.self, dataDict: param) { response in

            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.setAgentList(data: result)
                    
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
    
    func agentCommissionDelete (param:[String:Any]) {

        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.DELETE_AGENT_COMMISSION, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response in
            
            switch response {
            case .success(let result):
                SwiftLoader.hide()
         
                    self.delegate?.setAgentCommissionList(data: result)
                
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }

        }

    }
    
    
}

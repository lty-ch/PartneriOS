//
//  AgentEditCommission+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation

protocol EditAgentCommListProtocolDelegate : AnyObject {
    func setAgentList(data : SuccessModel)
    func popupMsg(msg : String)
}

class EditAgentCommViewModel {
    
    weak var delegate : EditAgentCommListProtocolDelegate?
    
    func updateCommissionListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.UPDATE_AGENT_COMMISSION, method:"PUT", isPassToken: true, expecting:SuccessModel.self, dataDict: param) { response in
    
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
}

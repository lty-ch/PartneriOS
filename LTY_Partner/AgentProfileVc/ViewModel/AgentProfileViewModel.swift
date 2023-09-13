//
//  AgentProfileViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 01/06/23.
//

import Foundation

protocol SetAgentProfileData: Any {
    func setData(data:AgentViewProfileModel)
    func showMsg(msg:String)
    
}
class AgentProfileViewModel {
    
    var delegate : SetAgentProfileData?
    
    func getAgentProfile(params:[String:Any]) {
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.partnerDetails, method: "POST", passToken: true, expecting: AgentViewProfileModel.self, dataDict: params) { response in
            
            switch response {
            case .success(let result):
                self.delegate?.setData(data: result)
            case .failure(let error):
                
                self.delegate?.showMsg(msg: error.localizedDescription)

            }
        }
        
    }
    
}

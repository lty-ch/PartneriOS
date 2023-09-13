//
//  AgentVC+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import Foundation

protocol AgentListProtocolDelegate : AnyObject {
    func setAgentList(data : AgentVCModel)
    func setBlockUser(data: SuccessModel)
    func setDeleteUserData(data:DeleteModel)
    func popupMsg(msg : String)
}

class AgentVCViewModel {
    
    weak var delegate : AgentListProtocolDelegate?

    func agentListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.agentListUrl, method: "POST", passToken: true, expecting:AgentVCModel.self, dataDict: param) { response
            
            in
  //          print(response)
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
    
    func agentDeleteApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.agentDeleteUrl, method: "PUT", isPassToken: true, expecting:DeleteModel.self, dataDict: param) { response
            in
            switch response {
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.setDeleteUserData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        
        }

    }
    
    //MARK:- block / unblock agent api
    
    func blockAgentApi(params:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.blockAgent, method: "PUT", isPassToken: true, expecting:SuccessModel.self, dataDict: params) { response
            in
            switch response {
            case .success(let result):
                SwiftLoader.hide()
                self.delegate?.setBlockUser(data: result)
              
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        
        }
        
    }
   
    
}

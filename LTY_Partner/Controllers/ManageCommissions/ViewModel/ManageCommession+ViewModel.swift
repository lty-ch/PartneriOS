//
//  ManageCommession+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 24/05/23.
//

import Foundation

protocol ManageCommessionprotocolDelegate : AnyObject{
    func checkStatus(data:SuccessModel)
    func showMsg(msg:String)
}
class ManageCommessionViewModel {
    var delegate : ManageCommessionprotocolDelegate?
    func addAgentCommission(param:[String:Any]){
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.agentCommission, method: "POST", passToken: true, expecting: SuccessModel.self, dataDict: param) { reseponse in
            
            switch reseponse {
            case .success(let result):
                self.delegate?.checkStatus(data:result)
              
            case .failure(let error):
                self.delegate?.showMsg(msg: error.localizedDescription)
            }
        }
    }
}

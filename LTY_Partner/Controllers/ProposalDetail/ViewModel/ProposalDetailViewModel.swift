//
//  ProposalDetailViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 07/06/23.
//

import Foundation

protocol ProposalCommissionProtocolDelegate : AnyObject {
    func setCommissionData(data : commissionModel)
    func popupMsg(msg : String)
}

class ProposalDetailViewModel {
    
    weak var delegate : ProposalCommissionProtocolDelegate?

    func getCommissionApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.getCommission, method: "POST", passToken: true, expecting:commissionModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCommissionData(data: result)

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

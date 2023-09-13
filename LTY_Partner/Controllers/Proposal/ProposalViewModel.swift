//
//  ProposalViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 01/06/23.
//

import Foundation

protocol ProposalListProtocolDelegate : AnyObject {
    func setProposalList(data : ProposalModel)
    func popupMsg(msg : String)
}

protocol ExpiredProposalListProtocolDelegate : AnyObject {
    func setExpiredProposalList(data : SubmissionModel, withInMonth: Int)
}
 
class ProposalViewModel {
    
    weak var delegate : ProposalListProtocolDelegate?
    weak var expireDelegate : ExpiredProposalListProtocolDelegate?

    func proposalListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getProposalListNew, method: "POST", passToken: true, expecting:ProposalModel.self, dataDict: param) { response
            
            in

      //      print(response)
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setProposalList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func expiredProposalListApi (param:[String:Any], withInMonth: Int) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getExpiredContract, method: "POST", passToken: true, expecting:SubmissionModel.self, dataDict: param) { response
            
            in

//           print(response)
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.expireDelegate?.setExpiredProposalList(data: result, withInMonth: withInMonth)

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
    
//    func getCustomerActiveAgent (param:[String:Any]) {
//        
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomerActiveAgents, method: "POST", passToken: true, expecting:CustomerActiveAgentModel.self, dataDict: param) { response
//            
//            in
//
//            switch response {
//            
//            case .success(let result):
//                SwiftLoader.hide()
//
//                DispatchQueue.main.async {
//                    self.delegate?.setCustomerAgentList(data: result)
//
//                }
//
//            case .failure(let error):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//                    
//                    
//                    self.delegate?.popupMsg(msg:error.localizedDescription)
//                    
//                }
//            }
//
//        
//        }
//
//    }

   
    
}

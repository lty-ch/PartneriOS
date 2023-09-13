//
//  LeadProposalViewModel.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 13/06/23.
//

import Foundation

protocol LeadProposalDelegate {
    func setData(data:LeadProposalModel)
    func showMessage(msg:String)
}

protocol SendMultipleProposalDelegate {
    func setMultipleProposalData(data:SuccessModel, from: String)
    func showMultipleProposalMessage(msg:String)
}
protocol SendLeadProposalDelegate {
    func setLeadData(data:SuccessModel, from: String)
    func showLeadMessage(msg:String)
}
class LeadProposalViewModel {
    
    var delegate: LeadProposalDelegate?
    var sendLeadProposalDelegate: SendLeadProposalDelegate?
    var sendMultipleProposalDelegate: SendMultipleProposalDelegate?
    
    func leadProposalApi(param:[String:Any]){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.leadProposal, method: "POST", passToken: true, expecting:LeadProposalModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func sendLeadProposalApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.sendProposal, method: "PUT", isPassToken: true, expecting:SuccessModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.sendLeadProposalDelegate?.setLeadData(data: result, from: "SendLead")
                    
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.sendLeadProposalDelegate?.showLeadMessage(msg: error.localizedDescription)
                }
            }
            
        }
        
    }
    
    func deleteProposalApi(param:[String:Any]){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.deleteLeadProposal, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.sendLeadProposalDelegate?.setLeadData(data: result, from: "DeleteLead")
                }
                

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.sendLeadProposalDelegate?.showLeadMessage(msg: error.localizedDescription)
                }
                
            }
            
        }
        
    }
    func sendMultipleProposalApi(param:[String:Any]){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.sendMultipleProposal, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.sendMultipleProposalDelegate?.setMultipleProposalData(data: result, from: "SendMultipleLead")
                }
                

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.sendMultipleProposalDelegate?.showMultipleProposalMessage(msg: error.localizedDescription)
                }
                
            }
            
        }
        
    }
}

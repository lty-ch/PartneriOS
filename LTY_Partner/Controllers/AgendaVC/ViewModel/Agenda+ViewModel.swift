//
//  Agenda+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import Foundation

protocol AgendaProtocolDelegate : AnyObject {
    func setAgendaLst(data : AgendaModel)
    func deletAgenda(data : AddNewAgendaModel)
    func popupMsg(msg : String)
}


class AgendaViewModel {
    
    weak var delegate : AgendaProtocolDelegate?
    
    func agendaListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgendaList, method: "POST", passToken: true, expecting:AgendaModel.self, dataDict: param) { response
            
            in
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.setAgendaLst(data: result)
                    
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
            
            
        }
        
    }
    
    
    //MARK:- delete agenda Details
    
    
    func deleteAgenda(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.deleteAgenda, method: "POST", passToken: true, expecting:AddNewAgendaModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.deletAgenda(data: result)
                    
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

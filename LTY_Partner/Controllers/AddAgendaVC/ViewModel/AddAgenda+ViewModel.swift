//
//  AddAgenda+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 25/07/23.
//

import Foundation

protocol AddNewAgendaProtocolDelegate : AnyObject {
    func AddNewAgenda(data : AddNewAgendaModel)
    func getAgendaDetail(data : GetAgendaDModel)
    func popupMsg(msg : String)
}

class AddAgendaViewModel {
    
    weak var delegate : AddNewAgendaProtocolDelegate?
    
    func addNewAgendaApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.addNewAgenda, method: "POST", passToken: true, expecting:AddNewAgendaModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.AddNewAgenda(data: result)
                    
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
            
            
        }
        
    }
    
    //MARK:- get Agenda Details
    
    
    func getAgendaDetails (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgendaDetails, method: "POST", passToken: true, expecting:GetAgendaDModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.getAgendaDetail(data: result)
                    
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
            
            
        }
        
    }
    
    
    //MARK:- update Agenda Details
    
    
    func updateAgendaDetailsApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.putRequestApi(url:  LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.updateAgenda, method: "PUT", isPassToken: true, expecting: AddNewAgendaModel.self, dataDict: param) { response
      
            
            in
          //  print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.AddNewAgenda(data: result)

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

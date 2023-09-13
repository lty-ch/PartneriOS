//
//  RolesViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 27/06/23.
//

import Foundation

protocol RolesListProtocolDelegate : AnyObject {
    func setRolesList(data : RolesModel)
    func setAgentRolesList(data : AgentListRoleModel)
    func setDeleteRoleData(data : SuccessModel)
    func popupMsg(msg : String)
}

class RolesViewModel {
    
    weak var delegate : RolesListProtocolDelegate?
    
    func getRolesApi(param:[String:Any]){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.rolesList, method: "POST", passToken: true, expecting:RolesModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.setRolesList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
                
            }
            
        }
        
    }

//    func getRolesApi() {
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.rolesList), shouldSendHeader: true, expecting: RolesModel.self) { response in
//            print(response)
//            switch response {
//
//            case .success(let result):
//                SwiftLoader.hide()
//
//                DispatchQueue.main.async {
//                    self.delegate?.setRolesList(data: result)
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
//        }
//
//    }
    
    func getAgentRolesListApi(param:[String:Any]){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.usersList, method: "POST", passToken: true, expecting:AgentListRoleModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.setAgentRolesList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
                
            }
            
        }
        
    }
    
    
//    func getAgentRolesListApi() {
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.usersList), shouldSendHeader: true, expecting: AgentListRoleModel.self) { response in
//
//            switch response {
//
//            case .success(let result):
//                SwiftLoader.hide()
//
//                DispatchQueue.main.async {
//                    self.delegate?.setAgentRolesList(data: result)
//
//                }
//
//            case .failure(let error):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//
//                    self.delegate?.popupMsg(msg:error.localizedDescription)
//
//                }
//            }
//
//        }
//
//    }
    
    func deleteRole (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.deleteRole, method: "PUT", isPassToken: true, expecting:SuccessModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
            case .success(let result):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.setDeleteRoleData(data: result)
                    
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



//
//  RoleDetailViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 27/06/23.
//

import Foundation

protocol RoleDetailDelegate{
    func setAllRolesData(data:RoleDetailModel)
    func setSelectedRolesData(data:RoleDetailModel)
    func setUpdateRolesData(data:SuccessModel)
    func popupMsg(msg:String)
}

class RoleDetailViewModel{
    
    var delegate :RoleDetailDelegate?
    
    func getAllRoleDetailApi() {
        SwiftLoader.show(animated: true)

        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.getAllRoles), shouldSendHeader: true, expecting: RoleDetailModel.self) { response in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setAllRolesData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        }

    }
    
    func getSelectedRoleAPI (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.getSelectedRoles, method: "POST", passToken: true, expecting:RoleDetailModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setSelectedRolesData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func updateRoleAPI (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.updateRoles, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setUpdateRolesData(data: result)

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

//
//  AddRoleViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 27/06/23.
//

import Foundation

protocol AddRoleListProtocolDelegate : AnyObject {
    func setAddRoleData(data : SuccessModel)
    func popupMsg(msg : String)
}

protocol AssignRoleListProtocolDelegate : AnyObject {
    func setAssignRoleData(data : SuccessModel)
    func popupMsg(msg : String)
}

class AddRoleViewModel {
    
    weak var delegate : AddRoleListProtocolDelegate?
    weak var assignRoleDelegate : AssignRoleListProtocolDelegate?
    
    func addRoleAPI (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.addRole, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()
                

                DispatchQueue.main.async {
                    self.delegate?.setAddRoleData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func assignRoleAPI (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.assignRole, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.assignRoleDelegate?.setAssignRoleData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.assignRoleDelegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    
}


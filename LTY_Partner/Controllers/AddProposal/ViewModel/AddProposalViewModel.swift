//
//  AddProposalViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import Foundation

protocol AddPropsalAgentListProtocolDelegate : AnyObject {
    func setAgentList(data : AddProposalAgentModel)
    func popupMsg(msg : String)
}

protocol AddPropsalMemberListProtocolDelegate : AnyObject {
    func setMembersList(data : AddProposalMembersModel)
}

protocol AddPropsalProtocolDelegate : AnyObject {
    func setSuccessList(data : addProposalModel)
}

protocol UpdateGeneralPropsalProtocolDelegate : AnyObject {
    func setUpdateProposalSuccessList(data : editProposalModel)
}

protocol ActiveUsersProtocolDeleagte : AnyObject {
    func setActiveUsersList(data : AddProposalMembersModel)
}

class AddProposalViewModel {
    
    weak var delegate : AddPropsalAgentListProtocolDelegate?
    weak var proposalDelegate : AddPropsalMemberListProtocolDelegate?
    weak var addProposalDelegate : AddPropsalProtocolDelegate?
    weak var editProposalDelegate : UpdateGeneralPropsalProtocolDelegate?
    weak var activeUsersDelegate : ActiveUsersProtocolDeleagte?

    func addProposalAgentListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.catAgentListUrl, method: "POST", passToken: true, expecting:AddProposalAgentModel.self, dataDict: param) { response
            
            in

            print(response)
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
    
    func getMembersApi (param:[String:Any]) {
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getActiveMembers, method: "POST", passToken: true, expecting:AddProposalMembersModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.proposalDelegate?.setMembersList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func getActiveUsers (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getActiveUsers, method: "POST", passToken: true, expecting:AddProposalMembersModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.activeUsersDelegate?.setActiveUsersList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func addProposalAPI (param:[String:Any]) {
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.addProposal, method: "POST", passToken: true, expecting:addProposalModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.addProposalDelegate?.setSuccessList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func editProposalAPI (param:[String:Any]) {
        SwiftLoader.show(animated: true)

        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.updateProposal, method: "PUT", isPassToken: true, expecting:editProposalModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.editProposalDelegate?.setUpdateProposalSuccessList(data: result)

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
    
//    func agentDeleteApi (param:[String:Any]) {
//
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.agentDeleteUrl, method: "PUT", isPassToken: true, expecting:DeleteModel.self, dataDict: param) { response
//            in
//            switch response {
//            case .success(let result):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//                    self.delegate?.setDeleteUserData(data: result)
//
//                }
//
//            case .failure(let error):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//                    self.delegate?.popupMsg(msg:error.localizedDescription)
//                }
//            }
//
//        }
//
//    }
//
//    //MARK:- block / unblock agent api
//
//    func blockAgentApi(params:[String:Any]) {
//
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.blockAgent, method: "PUT", isPassToken: true, expecting:SuccessModel.self, dataDict: params) { response
//            in
//            switch response {
//            case .success(let result):
//                SwiftLoader.hide()
//                self.delegate?.setBlockUser(data: result)
//
//            case .failure(let error):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//                    self.delegate?.popupMsg(msg:error.localizedDescription)
//                }
//            }
//
//        }
//
//    }
   
    
}

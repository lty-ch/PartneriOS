//
//  CustomerMemberViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import Foundation

protocol CustomerUserDocProtocolDelegate : AnyObject {
    func setCustContract(data : SubmissionModel)
    func setCustUserDocData(data : CustDocModel)
    func setCustomerMemberdata(data : CustomerMemberModel)
    func setCustomerLeadata(data : LeadModel)
    func popupMsg(msg : String)
}

protocol CustomerMemberDocProtocolDelegate : AnyObject {
    func setCustMemberDocData(data : CustMemberDocModel)
    func popupMsg(msg : String)
}

class CustomerMemberViewModel {
    
    weak var delegate : CustomerUserDocProtocolDelegate?
    weak var docDelegate : CustomerMemberDocProtocolDelegate?

    func getCustomerMemberApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getFamilyMember, method: "POST", passToken: true, expecting:CustomerMemberModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustomerMemberdata(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    //MARK:- get customer Leads
    
    
    func getCustomerLeadsApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getCustomerLead, method: "POST", passToken: true, expecting:LeadModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustomerLeadata(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
        
        }

    }
    
    
    //MARK:- get customer Contracts
    
    
    func getCustomerContractApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getCustContract, method: "POST", passToken: true, expecting:SubmissionModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustContract(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
        
        }

    }
    
    
    //MARK:- get customer Document
    
    
    func getCustomerUserDocumentApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        print(param)
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.DOCUMENT_BASE_URL + LTY_END_POINT_URL.getCustUserDocument, method: "POST", passToken: true, expecting:CustDocModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustUserDocData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
        
        }

    }
    
    
    func getCustomerMemberDocumentApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        print(param)
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.DOCUMENT_BASE_URL + LTY_END_POINT_URL.getCustMemberDocument, method: "POST", passToken: true, expecting:CustMemberDocModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.docDelegate?.setCustMemberDocData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.docDelegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
        
        }

    }
   
}

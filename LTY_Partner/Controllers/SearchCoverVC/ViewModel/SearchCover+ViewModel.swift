//
//  SearchCover+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 17/07/23.
//

import Foundation

protocol SearchCoverProtocolDelegate : AnyObject {
    func setOverAllData(data : SCOverAllModel)
    func setCustList(data : SC_CustomerModel)
    func setAgentList(data : SC_AgentModel)
    func setAnalysisList(data : SC_AnalysisModel)
    func popupMsg(msg : String)
}


class SearchCoverViewModel {
    
    weak var delegate : SearchCoverProtocolDelegate?

    func searchCoverListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.searchCover_OverAll, method: "POST", passToken: true, expecting:SCOverAllModel.self, dataDict: param) { response
            
            in

            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setOverAllData(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    //MARK:-  to get customer data
    
    
    func searchCoverCustomers(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.searchCover_Customers, method: "POST", passToken: true, expecting:SC_CustomerModel.self, dataDict: param) { response
            
            in

            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setCustList(data: result)

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    
    //MARK:-  to get agent  data
    
    func searchCoverAgents(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.searchCover_Agents, method: "POST", passToken: true, expecting:SC_AgentModel.self, dataDict: param) { response
            
            in

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
    
    
    //MARK:-  to get Analysis  data
    
    
    func searchCoverAnalysisList(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.searchCover_Analysis, method: "POST", passToken: true, expecting:SC_AnalysisModel.self, dataDict: param) { response
            
            in

            print(response)
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setAnalysisList(data: result)

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

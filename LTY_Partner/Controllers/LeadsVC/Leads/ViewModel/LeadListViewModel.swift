//
//  LeadListViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/06/23.
//

import Foundation

protocol LeadVcProtpcolDelegate{
    func setdata(data:LeadModel)
    func popupMsg(msg:String)
}
class LeadListViewModel {
    
    var delegate:LeadVcProtpcolDelegate?
    
    func leadListApiCall(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.partnerLeadsListNew, method: "POST", passToken: true, expecting:LeadModel.self, dataDict: param) { response
            
            in
           // print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setdata(data: result)

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

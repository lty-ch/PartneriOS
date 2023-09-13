//
//  HomeVC+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/07/23.
//

import Foundation

protocol HomeVCProtocoldelegate {
    func setDashboardData(data:HomeVCModel)
    func popupMsg(msg: String)
    
}
class HomeVCViewModel {
    
    var delegate : HomeVCProtocoldelegate?
    func dashboardInfoApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getdashboardInfo, method: "POST", passToken: true, expecting:HomeVCModel.self, dataDict: param) { response
            
            in
            
            print(response)
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.setDashboardData(data: result)
                    
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

//
//  StaticDataViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 04/08/23.
//

import Foundation

protocol SetInsuranceTypeData{
    func setData(data:InsuranceTypeModel)
    func showMessage(msg:String)
}

class StaticDataViewModel {
    var delegate :SetInsuranceTypeData?
    
    func insuranceTypeApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getStaticData, method: "POST", passToken: true, expecting:InsuranceTypeModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
}

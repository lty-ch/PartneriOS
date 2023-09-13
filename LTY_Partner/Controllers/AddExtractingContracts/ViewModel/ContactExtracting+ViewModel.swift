//
//  ContactExtracting+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/08/23.
//

import Foundation

protocol ExistingContractProtocol{
    func setExistingContractData(data:SuccessModel)
    func showMessage(msg:String)
}

class ExistingContractViewModel {
    var delegate : ExistingContractProtocol?
    
    func insuranceTypeApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.postExistingContract, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.setExistingContractData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
}

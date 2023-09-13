//
//  EditProductOptionsViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 24/05/23.
//

import Foundation

protocol EditProductOptionsProtocolDelegate : AnyObject {
    func deleteProductProtocol(data : SuccessModel)
    func popupMsg(msg : String)
}

class EditProductOptionsViewModel {
    
    weak var delegate : EditProductOptionsProtocolDelegate?

    
    
    func deleteCatProducts (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + LTY_END_POINT_URL.deleteProductCommission, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.deleteProductProtocol(data: result)

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

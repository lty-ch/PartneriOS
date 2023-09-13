//
//  EditCatOptionsViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 24/05/23.
//

import Foundation

protocol EditCatOptionsProtocolDelegate : AnyObject {
//    func setMainCatList(data : SelectCatResponse)
    func deleteMainCatProtocol(data : SuccessModel)
//    func setAddproductList(data : SuccessModel)
    func popupMsg(msg : String)
}

class EditCatOptionsViewModel {
    
    weak var delegate : EditCatOptionsProtocolDelegate?

    
    
    func deleteMainCat (_ param:[String:Any], url: String) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + url, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.deleteMainCatProtocol(data: result)

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

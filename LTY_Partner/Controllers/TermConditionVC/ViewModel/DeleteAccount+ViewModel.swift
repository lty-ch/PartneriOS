//
//  DeleteAccount+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/09/23.
//

import Foundation

protocol DeleteAccountProtocol {
    func setData(data:DeleteAccountModel)
    func showMessage(message:String)
}
class DeleteAccountViewModel {
    
    var delegate:DeleteAccountProtocol?
    func DeleteAccountApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.deleteAccount, method: "PUT", isPassToken: true, expecting:DeleteAccountModel.self, dataDict: param) { response
            
            in
            //print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.setData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(message: error.localizedDescription)
                
            }
            
        }
        
    }
    
}

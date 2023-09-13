//
//  NewLetter+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 10/08/23.
//

import Foundation
    

protocol SendNewLetterProtocol{
    func setNewsLetterData(data:SendNewsLetterModel)
    func showMessage(msg:String)
}

class NewLetterViewModel {
    var delegate : SendNewLetterProtocol?
    
    func getNewTemplateApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.getNewsLetterData, method: "POST", passToken: true, expecting:SendNewsLetterModel.self, dataDict: param) { response
            
            in
            //print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.setNewsLetterData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
}

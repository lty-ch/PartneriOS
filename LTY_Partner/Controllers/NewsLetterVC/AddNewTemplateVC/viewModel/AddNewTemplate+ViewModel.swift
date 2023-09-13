//
//  AddNewTemplate+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 10/08/23.
//

import Foundation

import Foundation

protocol AddNewsLetterProtocol{
    func AddNewsLetterData(data:AddNewTempModel)
    func getNewsLetterData(data:GetTempModel)
    func showMessage(msg:String)
}
protocol SendNewsLetterProtocol{
    func SendNewsLetterData(data:SuccessModel)
}

class AddNewTemplateViewModel {
    var delegate : AddNewsLetterProtocol?
    var SendNewsLetterDelegate : SendNewsLetterProtocol?
    
    func AddTemplateApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.addNewsLetterTemplate, method: "POST", passToken: true, expecting:AddNewTempModel.self, dataDict: param) { response
            
            in
            //print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.AddNewsLetterData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func getTempDetailsApiCall(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.getNewsLetterDetails, method: "POST", passToken: true, expecting:GetTempModel.self, dataDict: param) { response
            
            in
            //print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.delegate?.getNewsLetterData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
    
    func sendTemplateApi(param:[String:Any]){
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.sendNewsLetter, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in
            //print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                self.SendNewsLetterDelegate?.SendNewsLetterData(data: result)

            case .failure(let error):
                SwiftLoader.hide()
                self.delegate?.showMessage(msg: error.localizedDescription)
                
            }
            
        }
        
    }
}

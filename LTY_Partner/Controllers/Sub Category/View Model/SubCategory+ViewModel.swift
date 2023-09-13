//
//  SubCategory+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 24/05/23.
//

import Foundation

protocol subCategoryListProtocolDelegate : AnyObject {
    
    func setSubCategoryList(data : SubCategoryModel)
    func popupMsg(msg : String)
}

protocol subCategoryListByAgentProtocolDelegate : AnyObject {
    
    func setSubCategoryListByAgent(data : SubCategoryModel)
}

class SubCatagoryViewModel{
    
    var delegate : subCategoryListProtocolDelegate?
    var subCategoryListByAgentDelegate : subCategoryListByAgentProtocolDelegate?
    func subCatListApi (param:[String:Any]) {
        
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + LTY_END_POINT_URL.getSubCategoryNew, method: "POST", passToken: true, expecting:SubCategoryModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                print("success")
                
                self.delegate?.setSubCategoryList(data: result)
                
                
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)
                
            }
            
        }
    }
    func getSubCatByAgent (param:[String:Any], url: String) {
     
        SwiftLoader.show(animated: true)
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + url, method: "POST", passToken: true, expecting:SubCategoryModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                print("success")
            
                self.subCategoryListByAgentDelegate?.setSubCategoryListByAgent(data: result)

                
            case .failure(let error):
                SwiftLoader.hide()
                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    
}

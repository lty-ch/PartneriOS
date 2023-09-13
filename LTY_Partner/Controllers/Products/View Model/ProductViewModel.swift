//
//  ProductViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 24/05/23.
//

import Foundation


protocol ProductListProtocolDelegate : AnyObject {
    
    func setSubCategoryList(data : ProductModel)
    func popupMsg(msg : String)
}

class ProductViewModel {
    
    var delegate : ProductListProtocolDelegate?
    
    func subCatListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + LTY_END_POINT_URL.getProduct, method: "POST", passToken: true, expecting:ProductModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                print("success")
                SwiftLoader.hide()

                self.delegate?.setSubCategoryList(data: result)
                
                
            case .failure(let error):
                SwiftLoader.hide()

                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)
                
            }
            
        }
    }
    
    func getProductByAgent (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + LTY_END_POINT_URL.getProductByAgent, method: "POST", passToken: true, expecting:ProductModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                print("success")
                SwiftLoader.hide()

                self.delegate?.setSubCategoryList(data: result)
                
                
            case .failure(let error):
                SwiftLoader.hide()

                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)
                
            }
            
        }
    }
    
}

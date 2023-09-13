//
//  SelectCatViewModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 23/05/23.
//

import Foundation

protocol SelectCatProtocolDelegate : AnyObject {
    func setMainCatList(data : SelectCatResponse)
    func setAddproductList(data : SuccessModel)
    func setSubCatList(data : SelectSubCatModel)
    func popupMsg(msg : String)
}

class SelectCatViewModel {
    
    weak var delegate : SelectCatProtocolDelegate?

    
    
    func mainCatListApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_CATEGORY + LTY_END_POINT_URL.getAllMainCategory, method: "POST", passToken: true, expecting:SelectCatResponse.self, dataDict: param) { response
            
            in
            print(response)

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setMainCatList(data: result)

                }

                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }

    func addProductApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.addProductCommissions, method: "POST", passToken: true, expecting:SuccessModel.self, dataDict: param) { response
            
            in

            print(response)
            
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setAddproductList(data: result)

                }

                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    
    func subCatListApi(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT_CATEGORY + LTY_END_POINT_URL.getproductCat, method: "POST", passToken: true, expecting:SelectSubCatModel.self, dataDict: param) { response
            
            in

            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setSubCatList(data: result)

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

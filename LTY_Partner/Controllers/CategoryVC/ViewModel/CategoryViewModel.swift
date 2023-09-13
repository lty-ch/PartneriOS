//
//  CategoryViewModel.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/23/23.
//

import Foundation


protocol CategoryListProtocolDelegate : AnyObject {
    func setCategoryList(data : CategoryModel)
    func setCategoryNewList(data : CategoryNewModel)
    func popupMsg(msg : String)
}
protocol CategoryListByAgentProtocolDelegate : AnyObject {
    func setCategoryListByAgent(data : CategoryNewModel)
}
protocol AllCatProtocolDelegate : AnyObject {
    func setAllCategoryList(data : CategoryNewModel)
}
class CategoryViewModel {
    weak var categoryListByAgentDelegate : CategoryListByAgentProtocolDelegate?
    weak var delegate : CategoryListProtocolDelegate?
    weak var allCategoryListDelegate : AllCatProtocolDelegate?
    
    
    func getAllCategory (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_CATEGORY + LTY_END_POINT_URL.getAllMainCategory, method: "POST", passToken: true, expecting:CategoryNewModel.self, dataDict: param) { response
            
            in
            debugPrint(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.allCategoryListDelegate?.setAllCategoryList(data: result)

                }

                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }

        
        }

    }
    
    func productCommissionListApi (param:[String:Any], url: String) {
     
        SwiftLoader.show(animated: true)
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + url, method: "POST", passToken: true, expecting:CategoryModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
            
                self.delegate?.setCategoryList(data: result)

                
            case .failure(let error):
                SwiftLoader.hide()
                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
    
    
    func productCategoryListApi (param:[String:Any], url: String) {
     
        SwiftLoader.show(animated: true)
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + url, method: "POST", passToken: true, expecting:CategoryNewModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
            
                self.delegate?.setCategoryNewList(data: result)

                
            case .failure(let error):
                SwiftLoader.hide()
                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }

    func getCatByAgent (param:[String:Any], url: String) {
     
        SwiftLoader.show(animated: true)
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PRODUCT + url, method: "POST", passToken: true, expecting:CategoryNewModel.self, dataDict: param) { response
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                print("success")
            
                self.categoryListByAgentDelegate?.setCategoryListByAgent(data: result)

                
            case .failure(let error):
                SwiftLoader.hide()
                print(error.localizedDescription)
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }

    
}

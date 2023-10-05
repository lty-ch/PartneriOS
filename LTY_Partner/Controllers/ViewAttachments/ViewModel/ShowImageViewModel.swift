//
//  ShowImageViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/10/23.
//

import Foundation

protocol ShowImageViewProtocolDelegate {
  
    func showImage(data : ShowImageModel)
    func popupMsg(msg : String)
}

class ShowImageViewModel {
    var delegate : ShowImageViewProtocolDelegate?
    
    func ViewImageApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.SHOW_DOCUMENT_URL , method: "POST", passToken: true, expecting:ShowImageModel.self, dataDict: param) { response
            
            in

            print(response)
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.showImage(data: result)

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

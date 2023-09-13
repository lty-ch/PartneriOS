//
//  ForgotVCViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 15/05/23.
//

import Foundation

protocol ForgotPassProtocolDelegate : AnyObject {
    func setData(data : ForgotVCModel)
    func popupMsg(msg : String)
}


class ForgotVCViewModel {
    
    var forgotPassData = [ForgotVCViewModel]()
    weak var delegate : ForgotPassProtocolDelegate?
    
    var ListData : ForgotVCModel!
    init(data:ForgotVCModel? = nil) {
        if data == nil {
        return
    }
    self.ListData = data
        
    }
    //MARK:- call Api func
    
    func networkServiceCall (param:ForgotParams){
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.ForgotPass(params:param){ [self] (list, error) in
            
            if error == nil {
                
                self.forgotPassData = (list?.map({return ForgotVCViewModel(data:$0) }))!
                
                if self.forgotPassData.count != 0 {
                    delegate?.setData(data:(forgotPassData.first?.ListData)!)
                    SwiftLoader.hide()

                }
                else {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg: "Data is not Available.")
                    }
                }
                
            }
            else{
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.")
                }
            }

        }
        
    }
    
    
 // END api calling func
}

    


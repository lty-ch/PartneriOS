//
//  NotificationVC+ViewModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 28/08/23.
//

import Foundation

protocol NotificationDelegate {
    func setData(data:NotificationModel)
    func popupMsg(msg:String)
}

class NotificationViewModel {
    var delegate : NotificationDelegate?
 
    func notificationListApi(param:[String:Any]) {
        
        let urlStr = "\(LTY_BASE_URL.BASE_URL_RESEND_OTP + LTY_END_POINT_URL.getNotificationList)"

        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApiForProfileDetail(url: urlStr, method: "POST", passToken: true, expecting:NotificationModel.self, dataDict: param) { response in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    //self.delegate?.setAgentEditDetailData(data: result)
                    self.delegate?.setData(data: result)
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

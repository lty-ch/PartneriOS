//
//  SubmissionListViewModel.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import Foundation

protocol SubmissionVCProtpcolDelegate{
    func setdata(data:SubmissionModel)
    func popupMsg(msg:String)
}

class SubmissionListViewModel {
    
    var delegate:SubmissionVCProtpcolDelegate?
    
    func submissionListApiCall(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.getSubmission, method: "POST", passToken: true, expecting:SubmissionModel.self, dataDict: param) { response
         
       
            in
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    self.delegate?.setdata(data: result)

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

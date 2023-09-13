//
//  ProfileViewModel.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 18/05/23.
//

import Foundation

protocol ProfileProtocolDelegate : AnyObject {
    func setProfile(data : ProfileModel)
    func updateProfile(data : ProfileModel)
    func changePass(data: ChangePassModel)
    func popupMsg(msg : String)
}

class ProfileViewModel {
    
    var profileData = [ProfileViewModel]()
    weak var delegate : ProfileProtocolDelegate?
    
    var ListData : ProfileModel!
    init(data:ProfileModel? = nil) {
        if data == nil {
            return
        }
        self.ListData = data
    }
    //MARK:- call Api func
    func networkServiceCall (param:ProfileParams){
        
        SwiftLoader.show(animated: true)
        Services.shareInstance.profileDetailApi(params: param) { [self] (list, error) in
            
            if error == nil {
                
                self.profileData = (list?.map({return ProfileViewModel(data:$0) }))!
                if self.profileData.count != 0 {
                    delegate?.setProfile(data: (self.profileData.first?.ListData)!)
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
    func profileDetailApi(param:[String:Any]) {
        
        let urlStr = "\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.PROFILE_DETAIL_URL)"
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApiForProfileDetail(url: urlStr, method: "POST", passToken: true, expecting:ProfileModel.self, dataDict: param) { response in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    //self.delegate?.setAgentEditDetailData(data: result)
                    self.delegate?.setProfile(data: result)
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:- func chnage Pass api
    
    func chnagePassApi(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)

        Services.shareInstance.putRequestApiForUpdatePhoneEmail(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.changePassword, method: "PUT", passToken: true, expecting: ChangePassModel.self, dataDict:param ) { response in
            
            switch response {
            case .success(let result):
                SwiftLoader.hide()

                self.delegate?.changePass(data: result)
                
            case .failure(let error):
                SwiftLoader.hide()

                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        }
        
    }
    
    
    
    
}

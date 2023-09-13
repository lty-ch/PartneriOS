//
//  AddNewAgentVC+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import Foundation

protocol AddAgentProtocolDelegate : AnyObject {
    
    func setSignup(data : AddNewAgentModel)
    func showToastMessg(toast:String)
    func popupMsg(msg : String)
    func setCountryList(countryData:CountryModel)
    func setStateList(stateData:StateModel)
    func setCityList(cityData:CityModel)
    func setRolesList(data : RolesModel)
    func setAgentEditDetailData(data : AgentEditDetailModel)
}

class AddNewAgentViewModel {
    
    var AddNewAgent = [AddNewAgentViewModel]()
    
    var ListData : AddNewAgentModel!
    init(data:AddNewAgentModel? = nil) {
        if data == nil {
            return
        }
        self.ListData = data
        
    }
    
    weak var delegate : AddAgentProtocolDelegate?

    func getProfile() {
        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_GETPROFILE), shouldSendHeader: true, expecting: AgentProfileModel.self) { response in
            switch response {
            case .success (let result) :
                if result.data?.profiles!.keys.count != 0
                {
                    let keyCount = result.data?.profiles!.keys.count ?? 0
                    for item in result.data!.profiles!.keys
                    {
                        print(result.data?.profiles?["\(item)"]?.agentReserve as Any)
                    }
                }
            case.failure (let error) :
                print(error)
            }

        }

    }
    
    //MARK:- Addnew agent Api
    
    func AddNewAgentApi12 (param:AddAgentParams){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.AddAgentApi(params:param){ [self] (list, error) in
            
            if error == nil {
                
                self.AddNewAgent = (list?.map({return AddNewAgentViewModel(data:$0) }))!
                
                if self.AddNewAgent.count != 0 {
                    
                    delegate?.setSignup(data:AddNewAgent.first!.ListData)
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
    
//    func updateAgentApi(param:EditAgentModel) {
//        
//        SwiftLoader.show(animated: true)
//        
//        let urlStr = "\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.agentDetailupdateUrl)"
//        
//        Services.shareInstance.putRequestApiForUpdateProfile(url: urlStr, method: "PUT", passToken: true, expecting:AgentEditDetailModel.self, dataDict: param) { response in
//            
//            switch response {
//                
//            case .success(let result):
//                SwiftLoader.hide()
//                print(result)
//                
//                DispatchQueue.main.async {
//                   self.delegate?.setAgentEditDetailData(data: result)
//                }
//                
//            case .failure(let error):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//                    self.delegate?.popupMsg(msg:error.localizedDescription)
//                }
//            }
//        }
//    }
    
    func updateAgentApi(param:EditAgentModel, isCommingFrom:String){
        SwiftLoader.show(animated: true)
        Services.shareInstance.updateAgentApi(params:param){ [self] (data, error) in
            SwiftLoader.hide()

            if error == nil {
            
                if isCommingFrom == "Edit_agent_detail"
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        
                        delegate?.showToastMessg(toast: "Update Successfully")

                        let userInfo: [AnyHashable : Any] = ["UpdateProfileData":"True"]
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateProfileData"), object: nil, userInfo: userInfo)
                    }
                    //here update ui according to updated agent detail data
                }
                else
                {
                    DispatchQueue.main.async {
                     
                        
                        kUserDefaults.set(param.companyDetails?.companyName, forKey: AppKeys.companyName)
                        
                        let fName = param.firstName?.capitalized   ?? ""
                        let lName = param.lastName?.capitalized   ?? ""
                        self.updateProfieImageFbdb(profile: param.profilePic ?? "", name:fName + " " + lName,email:param.email ?? "")
                        self.delegate?.showToastMessg(toast: "Update Successfully")
                        
                        let userInfo: [AnyHashable : Any] = ["UpdateProfileData":"True"]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateProfileData"), object: nil, userInfo: userInfo)
                        
                    }

                }
                
                
                /*
                self.AddNewAgent = (list?.map({return AddNewAgentViewModel(data:$0) }))!

                if self.AddNewAgent.count != 0 {

                    delegate?.setSignup(data:AddNewAgent.first!.ListData)
                    SwiftLoader.hide()

                }
                else {
                    DispatchQueue.main.async {
                        SwiftLoader.hide()
                        self.delegate?.popupMsg(msg: "Data is not Available.")
                    }
                }
                 */
            }
            else{
                DispatchQueue.main.async {
                    SwiftLoader.hide()
                    self.delegate?.popupMsg(msg: "The data couldn’t be read because it isn’t in the correct format.")
                }
            }

        }

    }
    
    
    
    //MARK:- UpdateProfile image fbdb
    
    func updateProfieImageFbdb (profile:String,name:String,email:String){
        var fcmKeyValue = ""

        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        let fcmKey = kUserDefaults.value(forKey: AppKeys.fcmKey) as? String
        if fcmKey == nil {
           fcmKeyValue = "dummmy_App_fcm"
        }else{
            fcmKeyValue = fcmKey ?? ""
        }
        
        let userDict = [
            "email": email,
            "name" : name,
            "pic" :profile,
            "fcmKey" :fcmKeyValue,
        ]
        
        if userType == "AGENT" {
            
            AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])
            
            
        }else {
            
            AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])
        }
        
    }
     
    func agentEditDetailApi(param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.agentEditDetailUrl, method: "POST", passToken: true, expecting:AgentEditDetailModel.self, dataDict: param) { response in
            
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    //self.delegate?.setAgentList(data: result)
                    self.delegate?.setAgentEditDetailData(data: result)
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        }
    }

    // END api calling func
    
    
    
    /*
    func AddNewAgentApi (param:[String:Any]) {
        
        
        Services.shareInstance.postRequestApi(url:LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.signUpUrl , method: "POST", passToken: false, expecting: AddAgentModel.self, dataDict: param) { response in
            
            switch response {
            case .success(let result):
                print(result)
            case .failure(let error) :
                print(error.localizedDescription)
                
            }
        }
        
    }
     */
    
    
   //MARK:- GET COUNTRY LIST API
    
    func getCountryListApi() {
        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_COMMON + LTY_END_POINT_URL.COUNTRIES_URL), shouldSendHeader: false, expecting: CountryModel.self) { response in
            switch response {
            case .success (let result) :
                self.delegate?.setCountryList(countryData:result)
            case.failure (let error) :
                print(error)
            }
        }
    }
    
//    //MARK:- GET STATE LIST API
//     
    func getStateListApi(url:String) {
        Services.shareInstance.requestGetApi(url: URL(string: url), shouldSendHeader: false, expecting: StateModel.self) { response in
             switch response {
             case .success (let result) :
                 self.delegate?.setStateList(stateData: result)
             case.failure (let error) :
                 print(error)
             }
         }
     }
    
    //MARK:- GET CITY LIST API
     
    func getCityListApi(url:String) {
        Services.shareInstance.requestGetApi(url: URL(string: url), shouldSendHeader: false, expecting: CityModel.self) { response in
             switch response {
             case .success (let result) :
                 self.delegate?.setCityList(cityData: result)
             case.failure (let error) :
                 print(error)
             }
         }
     }
    
    
   //MARK:- get agent Role api
    
//    func getRolesApi() {
//        SwiftLoader.show(animated: true)
//
//        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.rolesList), shouldSendHeader: true, expecting: RolesModel.self) { response in
//            print(response)
//            switch response {
//
//            case .success(let result):
//                SwiftLoader.hide()
//
//                DispatchQueue.main.async {
//                    self.delegate?.setRolesList(data: result)
//
//                }
//
//            case .failure(let error):
//                SwiftLoader.hide()
//                DispatchQueue.main.async {
//
//
//                    self.delegate?.popupMsg(msg:error.localizedDescription)
//
//                }
//            }
//
//        }
//
//    }
    
    func getRolesApi(param:[String:Any]){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.rolesList, method: "POST", passToken: true, expecting:RolesModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.delegate?.setRolesList(data: result)

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

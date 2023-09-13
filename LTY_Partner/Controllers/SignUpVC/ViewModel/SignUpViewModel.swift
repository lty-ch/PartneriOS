//
//  SignUpViewModel.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 15/05/23.
//

import Foundation

protocol SignUpProtocolDelegate : AnyObject {
    func setSignup(data : SignUpModel)
    func popupMsg(msg : String)
    func setCountryList(countryData:CountryModel)
    func setStateList(stateData:StateModel)
    func setCityList(cityData:CityModel)
}

class SignUpViewModel {
    var signUpData = [SignUpViewModel]()
    weak var delegate : SignUpProtocolDelegate?
    
    var ListData : SignUpModel!
    init(data:SignUpModel? = nil) {
        if data == nil {
            return
        }
        self.ListData = data
        
    }
    //MARK:- call Api func
    
    func networkServiceCall (param:SignUpParams){
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.SignUpApi(params:param){ [self] (list, error) in
            
            if error == nil {
                
                self.signUpData = (list?.map({return SignUpViewModel(data:$0) }))!
                
                if self.signUpData.count != 0 {
                    delegate?.setSignup(data:(signUpData.first?.ListData)!)
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
    
   //MARK:- GET COUNTRY LIST API
    
    func getCountryListApi() {
        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_COMMON + LTY_END_POINT_URL.COUNTRIES_URL), shouldSendHeader: false, expecting: CountryModel.self) { response in
            print(response)
            switch response {
            case .success (let result) :
                self.delegate?.setCountryList(countryData:result)
            case.failure (let error) :
                print(error)
            }
        }
    }
    
    //MARK:- GET STATE LIST API
     
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
}

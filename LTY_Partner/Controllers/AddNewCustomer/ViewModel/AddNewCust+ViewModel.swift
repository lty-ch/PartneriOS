//
//  AddNewCust+ViewModel.swift
//  LTY_Partner
//
//  Created by CTS on 26/05/23.
//

import Foundation

protocol AddNewCustomerProtocolDelegate : AnyObject {
    
    func popupMsg(msg : String)
    func setCountryList(countryData:CountryModel)
    func setStateList(stateData:StateModel)
    func setCityList(cityData:CityModel)

}
class AddNewCustomerViewModel {
    
    var delegate:AddNewCustomerProtocolDelegate?

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
    
}

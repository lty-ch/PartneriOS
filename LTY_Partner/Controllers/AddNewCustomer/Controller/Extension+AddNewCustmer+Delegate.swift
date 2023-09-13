//
//  Extension+AddNewCustmer+Delegate.swift
//  LTY_Partner
//
//  Created by CTS on 26/05/23.
//

import Foundation
import UIKit

extension AddNewCustomerVC : AddNewCustomerProtocolDelegate{
    
    func setCountryList(countryData: CountryModel) {
        //print(countryData.data.countriesList.first?.name)
        self.drpDownCounrtyListArray.append(CountryModel.init(status: countryData.status, data: countryData.data))
        
        self.newDrpDownCounrtyListArray.removeAll()
        for i in 0..<countryData.data.countriesList.count
        {
            let id = countryData.data.countriesList[i].id
            let name = countryData.data.countriesList[i].name
            let countryCode = countryData.data.countriesList[i].phonecode

            self.newDrpDownCounrtyListArray.append(DrpDownListStruct.init(id: id, phoneCode: countryCode, name: name))
        }
    }
    
    func setStateList(stateData: StateModel) {
        self.drpDownStateListArray.append(StateModel.init(status: stateData.status, data: stateData.data))
        self.newDrpDownStateListArray.removeAll()
        for i in 0..<stateData.data.statesList.count
        {
            let id = stateData.data.statesList[i].id
            let name = stateData.data.statesList[i].name
            self.newDrpDownStateListArray.append(DrpDownListStruct.init(id: id, phoneCode: 0, name: name))
        }
    }
    
    func setCityList(cityData: CityModel) {
        self.drpDownCityListArray.append(CityModel.init(status: cityData.status, data: cityData.data))
        self.newDrpDownCityListArray.removeAll()
        for i in 0..<cityData.data.citiesList.count
        {
            let id = cityData.data.citiesList[i].id
            let name = cityData.data.citiesList[i].name
            self.newDrpDownCityListArray.append(DrpDownListStruct.init(id: id, phoneCode: 0, name: name))
        }
    }
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
}

extension AddNewCustomerVC : SelectCatProtocolDelegate{
    func setMainCatList(data: SelectCatResponse) {
        if data.status == "SUCCESS"{
          
            self.maincatArr.removeAll()
    
                self.maincatArr = data.data?.categoryList ?? []
          
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
    }
    
    func setAddproductList(data: SuccessModel) {
        print("")
    }
    
    func setSubCatList(data: SelectSubCatModel) {
        print("")
    }

}

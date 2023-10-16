//
//  SignUpModel.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 15/05/23.
//

import Foundation

struct SignUpModel: Codable {
    let status: String?
    let data: SignUpData?
    let error: SignUpError?
}

// MARK: - DataClass
struct SignUpData: Codable {
    let processStage: String?
    let processStageData: SignUpProcessStageData?
    let message: String?
}

// MARK: - ProcessStageData
struct SignUpProcessStageData: Codable {
    let txnState: String?
    let txnStateData, emailTxnStateData : SignUpTxnStateData?
}

// MARK: - TxnStateData
struct SignUpTxnStateData: Codable {
 
    let otpID, timeoutInSeconds, remainingAttempts, resendOtpTime: String

     enum CodingKeys: String, CodingKey {
         case otpID = "otpId"
         case timeoutInSeconds, remainingAttempts, resendOtpTime
     }
}

// MARK: - Error
struct SignUpError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}




//MARK:- SignUp Params

struct SignUpParams : Encodable {
    var type: String = "PARTNER"
    var subscriptionPlan: String = "plan_1"
    var source: String = "Individual"
    var firstName: String = ""
    var lastName:  String = ""
    var mobile:  String = ""
    var gender:  String = ""
    var countryCode :  String = ""
    var email:  String = ""
    var country:  String = ""
    var state:  String = ""
    var city:  String = ""
    var address:  String = ""
    var postCode:  String = ""
    var language:  String = ""
    var nationality: String = ""
    var companyDetails : SignUpCompDetailSubParams
    var bankDetails : SignUpBankDetailSubParams
    var password: String = ""
    var dob:String = ""
    
}
struct SignUpCompDetailSubParams : Encodable {
    
    var companyName:  String = ""
    var website:  String = ""
    var logo:  String = ""
    var finamNo:  String = ""
    var ciceroNo:  String = ""
    var email:  String = ""
    var telephone:  String = ""
    var countryCode :  String = ""
    var country:  String = ""
    var state:  String = ""
    var city:  String = ""
    var address:  String = ""
    var postCode:  String = ""
    var privateCriminalRecord:  String = ""
    var privateOp:  String = ""
    var companyPo:  String = ""
    
}
struct SignUpBankDetailSubParams : Encodable {
    var iban: String = ""
    var swift: String = ""
    var bank: String = ""
    var country: String = ""
    var state:  String = ""
    var city:  String = ""
    var postCode: String = ""
    var address: String = ""
    var houseOwned: String = ""
}

struct SignUpCountryModel: Codable {
    let status: String?
    let data: SignUpCountryData?
    let error: SignUpCountryError?
}

// MARK: - DataClass
struct SignUpCountryData: Codable {
    let processStage: String?
    let processStageData: SignUpProcessStageData?
}

// MARK: - Error
struct SignUpCountryError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

// MARK: - Country
struct CountryModel: Codable {
    let status: String
    let data: CountryDataClass
}

// MARK: - DataClass
struct CountryDataClass: Codable {
    let countriesList: [CountriesList]
}

// MARK: - CountriesList
struct CountriesList: Codable {
    let id: Int
    let sortname, name: String
    let phonecode: Int
}


// MARK: - State
struct StateModel: Codable {
    let status: String
    let data: StateDataClass
}

// MARK: - DataClass
struct StateDataClass: Codable {
    let statesList: [StatesList]
}

// MARK: - StatesList
struct StatesList: Codable {
    let id: Int
    let name: String
    let countryID: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryID = "countryId"
    }
}


// MARK: - City
struct CityModel: Codable {
    let status: String
    let data: CityDataClass
}

// MARK: - DataClass
struct CityDataClass: Codable {
    let citiesList: [CitiesList]
}

// MARK: - CitiesList
struct CitiesList: Codable {
    let id: Int
    let name: String
    let stateID: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case stateID = "stateId"
    }
}


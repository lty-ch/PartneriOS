//
//  AddNewCustomerModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 26/05/23.
//

import Foundation

//struct AddNewCustomerParams : Encodable {
//    var source: String = ""
//    var type: String = ""
//    var firstName: String = ""
//    var lastName: String = ""
//    var mobile:  String = ""
//    var email:  String = ""
//    var country:  String = ""
//    var state:  String = ""
//    var city:  String = ""
//    var address:  String = ""
//    var postCode:  String = ""
//    var maritalStatus:  String = ""
//    var gender: String = ""
//    var companyName: String = ""
//    var companyDetails : CustomerCompDetailSubParams
//    var bankDetails : CustomerBankDetailSubParams
//    var password: String = ""
//    var dob:String = ""
//    var registrationId: String = ""
//    var agentId:String = ""
//    var partnerId: String = ""
//    
//}
//
//struct CustomerBankDetailSubParams : Encodable {
//    var iban: String = ""
//    var swift: String = ""
//    var bank: String = ""
//    var country: String = ""
//    var postCode: String = ""
//    var address: String = ""
//}
//
//struct CustomerCompDetailSubParams : Encodable {
//
//    var companyName: String = ""
//    var website: String = ""
//    var noOfEmployee: Int = 0
//    var companyId: String = ""
//    var legalEntity: String = ""
//}

struct AddNewCustomerModel: Codable {
    let status: String?
    let data: AddNewCustomerDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct AddNewCustomerDataClass: Codable {
    let processStage: String?
    let processStageData: AddNewCustomerProcessStageData?
    let message: String?
}

// MARK: - ProcessStageData
struct AddNewCustomerProcessStageData: Codable {
    let txnState: String?
    let txnStateData, emailTxnStateData: AddNewCustomerTxnStateData?
}

// MARK: - TxnStateData
struct AddNewCustomerTxnStateData: Codable {
    let additionalProp1, additionalProp2, additionalProp3: CatError?
}


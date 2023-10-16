//
//  AddNewAgentVC+Model.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import Foundation


struct AddNewAgentModel: Codable {
    let status: String?
    let data: AddNewAgentData?
    let error: AddNewAgentError?
}

// MARK: - DataClass
struct AddNewAgentData: Codable {
    let processStage: String?
    let processStageData: AddNewAgentProcessStageData?
    let message: String?
}

// MARK: - ProcessStageData
struct AddNewAgentProcessStageData: Codable {
    let txnState: String?
    let txnStateData, emailTxnStateData : SignUpTxnStateData?
}

// MARK: - TxnStateData
struct AddNeWAgentTxnStateData: Codable {
 
    let otpID, timeoutInSeconds, remainingAttempts, resendOtpTime: String

     enum CodingKeys: String, CodingKey {
         case otpID = "otpId"
         case timeoutInSeconds, remainingAttempts, resendOtpTime
     }
}

// MARK: - Error
struct AddNewAgentError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}




struct AddAgentProfileModel :Codable {
    let status: String?
    let data: AddAgentProfileData?
    let error: AddAgentProfileError?
}

// MARK: - DataClass
struct AddAgentProfileData :Codable {
    let profiles: Profiles?
}

// MARK: - Profiles
struct Profiles : Codable {
    let humanResource, juniorAgent, managingDirector, seniorAgent: HumanResource?
}

// MARK: - HumanResource
struct HumanResource: Codable {
    let agentReserve, companyReserve, agentCommission: Double?
}

// MARK: - Error
struct AddAgentProfileError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

//MARK:- Add New agent model response

// MARK: - Get Agent Profile
struct AgentProfileModel: Codable {
    let status: String?
    let data: AgentProfileData?
    let error: AddAgentError?
}
// MARK: - DataClass
struct AgentProfileData: Codable {
    let profiles: [String:InnerProfileData]?
}
// MARK: - Profiles
struct InnerProfileData: Codable {
    let agentReserve, companyReserve, agentCommission: Float?
}



struct AddAgentModel: Codable {
    let status: String?
    let data: AddAgentModelData?
    let error: AddAgentError?
}

// MARK: - DataClass
struct AddAgentModelData: Codable {
    let processStage: String?
    let processStageData: AddAgentProcessStageData?
    let message: String?
}

// MARK: - ProcessStageData
struct AddAgentProcessStageData: Codable {
    let txnState: String?
    let txnStateData, emailTxnStateData : AddAgentTxnStateData?
}

// MARK: - TxnStateData
struct AddAgentTxnStateData: Codable {
 
    let otpID, timeoutInSeconds, remainingAttempts, resendOtpTime: String?

     enum CodingKeys: String, CodingKey {
         case otpID = "otpId"
         case timeoutInSeconds, remainingAttempts, resendOtpTime
     }
}

// MARK: - Error
struct AddAgentError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}


//Add AgentModel params

let sourceID = kUserDefaults.value(forKey: "partnerID")
struct AddAgentParams : Encodable {
    
    var type: String = "AGENT"
    var subscriptionPlan: String = "plan_1"
    var source: String = sourceID as! String
    var firstName: String = ""
    var lastName:  String = ""
    var mobile:  String = ""
    var gender:  String = ""
    var countryCode:  String = ""
    var email:  String = ""
    var roleId:  String = ""
    var country:  String = ""
    var state:  String = ""
    var city:  String = ""
    var address:  String = ""
    var postCode:  String = ""
    var language:  String = ""
    var nationality: String = ""
    var password: String = ""
    var dob :String = ""
    var profile :String = ""
    var companyDetails : AddAgentParamsCompDetailSubParams
    var bankDetails : AddAgentParamsBankDetailSubParams
    var commissionDetails :AddComisionDetail

}
struct AddAgentParamsCompDetailSubParams : Encodable {
    
    var companyName:  String = ""
    var website:  String = ""
    var logo:  String = ""
    var finamNo:  String = ""
    var ciceroNo:  String = ""
    var email:  String = ""
    var telephone:  String = ""
    var country:  String = ""
    var state:  String = ""
    var city:  String = ""
    var address:  String = ""
    var postCode:  String = ""
    var privateCriminalRecord:  String = ""
    var privateOp:  String = ""
    var companyPo:  String = ""
    
}
struct AddAgentParamsBankDetailSubParams : Encodable {
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

struct AddComisionDetail :Encodable {
    var agentReserve:String = ""
    var companyReserve:String = ""
    var agentCommission:String = ""

}




// MARK: - Agent Edit Detail Api
struct AgentEditDetailModel: Codable {
    let status: String?
    let data: AgentDetailDataClass?
    let error: AddNewAgentError?
}

// MARK: - DataClass
struct AgentDetailDataClass: Codable {
    let partnerId, source, profile, profilePic, firstName: String?
    let lastName, mobile,countryCode: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let country, state, city, address, gender: String?
    let postCode, language, nationality: String?
    let companyDetails: CompanyDetails?
    let roleType, dob: String?
    let commissionDetails: CommissionDetails?
    let bankDetails: BankDetails?
    let subscriptionPlan, password: String?
    let isDefaultPasswordSet: Bool?
    //let customerCount: JSONNull?
    let partnerState, type: String?
    //let reason: JSONNull?
}

//// MARK: - BankDetails
//struct BankDetails: Codable {
//    let iban, swift, bank, country: String
//    let postCode, address: String
//}
//
//// MARK: - CommissionDetails
//struct CommissionDetails: Codable {
//    let agentReserve, companyReserve, agentCommission: Int
//}
//
//// MARK: - CompanyDetails
//struct CompanyDetails: Codable {
//    let companyName, website, logo, finamNo: String
//    let ciceroNo, email, telephone, country: String
//    let state, city, address, postCode: String
//    let privateCriminalRecord, privateOp, companyPo: String
//}

//MARK:- Edit Agent params

struct EditAgentModel: Encodable {
    let partnerId, profilePic,profile , firstName, lastName: String?
    let mobile , countryCode, email, dob, password: String?
    let country, state, city, address, gender: String?
    let postCode, language, nationality, roleType,roleId: String?
    let companyDetails: EditCompanyDetails?
    let commissionDetails: EditCommissionDetails?
    let bankDetails: EditBankDetails?
    let source: String?
}

struct EditBankDetails: Encodable {
    let iban, swift, bank, country, state, city: String?
    let postCode, address: String?
}

struct EditCommissionDetails: Encodable {
    let agentReserve, companyReserve, agentCommission: String?
}

struct EditCompanyDetails: Encodable {
    let companyName, website, logo, finamNo: String?
    let ciceroNo, email, telephone,countryCode, country: String?
    let state, city, address, postCode: String?
    let privateCriminalRecord, privateOp, companyPo: String?
}


//MARK:- upload document params

struct UploadDocumentsParams: Encodable {
    var userId: String?
    var docName: String?
 
   
}



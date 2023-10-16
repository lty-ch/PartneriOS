////
////  ProfileModel.swift
////  LTY_Partner
////
////  Created by CTS-Jay Gupta on 18/05/23.
////
//
//import Foundation
//
//// MARK: - Welcome
//struct ProfileModel: Codable {
//    let status: String?
//    let data: ProfileData?
//    let error: ProfileError?
//}
//// MARK: - DataClass
//struct ProfileData: Codable {
//    let partnerID, source, profile, firstName: String
//    let lastName, mobile: String
//    let isMobileVerified: Bool
//    let email: String
//    let isEmailVerified: Bool
//    let country, state, city, address: String
//    let postCode, language, nationality: String
//    let companyDetails: CompanyDetails
//    let roleType, dob: String
//    let commissionDetails: CommissionDetails
//    let bankDetails: BankDetails
//    let subscriptionPlan, password: String
//    let isDefaultPasswordSet: Bool
//    let customerCount: Int
//    let partnerState, type, reason: String
//
//    enum CodingKeys: String, CodingKey {
//        case partnerID = "partnerId"
//        case source, profile, firstName, lastName, mobile, isMobileVerified, email, isEmailVerified, country, state, city, address, postCode, language, nationality, companyDetails, roleType, dob, commissionDetails, bankDetails, subscriptionPlan, password, isDefaultPasswordSet, customerCount, partnerState, type, reason
//    }
//}
//// MARK: - BankDetails
//struct BankDetails: Codable {
//    let iban, swift, bank, country: String
//    let postCode, address: String
//}
//// MARK: - CommissionDetails
//struct CommissionDetails: Codable {
//    let agentReserve, companyReserve, agentCommission: Int
//}
//// MARK: - CompanyDetails
//struct CompanyDetails: Codable {
//    let companyName, website, logo, finamNo: String
//    let ciceroNo, email, telephone, country: String
//    let state, city, address, postCode: String
//    let privateCriminalRecord, privateOp, companyPo: String
//}
//// MARK: - Error
//struct ProfileError: Codable {
//    var errorCode: String?
//    var serverErrorMessage: String?
//    var clientErrorMessage: String?
//}
//
////MARK:- SignUp Params
//struct ProfileParams : Encodable {
////    var token: String = "iWAlgNwF0eEdDs53nGM8_u_nZ3_Nr0Rj1ltACFbq1aaLJc5rCSlUFfrxLn7TZKlAAkRV1CeypwEOJIMOK7XsVec-vBqlt8lQj8sSgXkEbtFHh0QY9UiJwungXt5qeUXwIsU7QxNPRv4dXSQi2Ed2xMUe4m6EE--dTzwCxBbDYLTtVZLJdafUhBYbLWUwgPQ6BE1ty7yX2aU3Hg6iHS-Hc_azXM9EQDvYgkMZ0KPEG40"
//
//    let token: String
//}
//
//  ProfileModel.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 18/05/23.
//

import Foundation

// MARK: - Profile Model
struct ProfileModel: Codable {
    let status: String?
    let data: ProfileData?
    let error: ProfileError?
}
// MARK: - DataClass
struct ProfileData: Codable {
    let partnerId, source: String?
    let profilePic: String?
    let firstName, lastName, mobile,countryCode: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let country, state, city, address: String?
    let postCode, language, nationality: String?
    let companyDetails: ProfileCompanyDetails?
    let roleType, dob,  gender: String?
    let commissionDetails: ProfileCommissionDetails?
    let bankDetails: ProfileBankDetails?
    let subscriptionPlan, password: String?
    let isDefaultPasswordSet: Bool?
    let partnerState, type, reason: String?
}
// MARK: - BankDetails
struct ProfileBankDetails: Codable {
    let iban, swift, bank: String?
    let country,state, city, postCode, address: String?
}
// MARK: - CommissionDetails
struct ProfileCommissionDetails: Codable {
    let agentReserve, companyReserve, agentCommission: Float?
}
// MARK: - CompanyDetails
struct ProfileCompanyDetails: Codable {
    let companyName, website, logo, finamNo: String?
    let ciceroNo, email, telephone,countryCode, country: String?
    let state, city, address, postCode: String?
    let privateCriminalRecord, privateOp, companyPo: String?
}
// MARK: - Error
struct ProfileError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

//MARK:- SignUp Params
struct ProfileParams : Encodable {
    let token: String?
}


//MARK:- chnage PassMode


struct ChangePassModel: Codable {
    let status: String?
    let data: ChangePassData?
    let error: ProfileError?
}

struct ChangePassData : Codable{
    let isPasswordChanged: Bool?
}

//
//  CustomerModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import Foundation

struct CustomerModel:Codable {
    let status: String?
    let data: CustomerModelDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct CustomerModelDataClass:Codable {
    let usersList: [UsersList]?
}

// MARK: - UsersList
struct UsersList:Codable {
    let userId, familyMemberId, source, type, firstName: String?
    let lastName, mobile: String?
    var isSelected: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let dob, country, countryCode, state, city: String?
    let address, postCode, maritalStatus, gender: String?
    let agentId, agentName, partnerId: String?
    let registrationIds : [String]?
    let insurerCompanies : [String]? 
    let partnerName, profilePic: String?
    let companyDetails: CustomerCompanyDetails?
    let bankDetails: CustomerBankDetails?
    let isDefaultPasswordSet: Bool?
    let userState, reason, createdOn, lastUpdatedOn: String?
}

// MARK: - BankDetails
struct CustomerBankDetails:Codable {
    let iban, swift, bank, country: String?
    let postCode, address: String?
}

// MARK: - CompanyDetails
struct CustomerCompanyDetails:Codable {
    let companyName, website: String?
    let noOfEmployee: Int?
    let companyID, legalEntity: String?
}


//struct CustomerActiveAgentModel:Codable {
//    let status: String?
//    let data: CustomerActiveAgentDataClass?
//    let error: CatError?
//}
//
// MARK: - DataClass
//struct CustomerActiveAgentDataClass:Codable {
//    let agentsList: [CustomerActiveAgentsList]?
//}
//
//// MARK: - AgentsList
//struct CustomerActiveAgentsList:Codable {
//    let partnerId, source, sourceName, profile: String?
//    let firstName, lastName, mobile: String?
//    let isMobileVerified: Bool?
//    let email: String?
//    let isEmailVerified: Bool?
//    let country, state, city, address: String?
//    let postCode, language, nationality: String?
//    let companyDetails: CustomerActiveAgentsCompanyDetails?
//    let roleType, dob: String?
//    let commissionDetails: CustomerActiveAgentsCommissionDetails?
//    let bankDetails: CustomerActiveAgentsBankDetails?
//    let subscriptionPlan, profilePic, password: String?
//    let isDefaultPasswordSet: Bool?
//    let customerCount: Int?
//    let partnerState, type, reason: String?
//}
//
//// MARK: - BankDetails
//struct CustomerActiveAgentsBankDetails:Codable {
//    let iban, swift, bank, country: String?
//    let postCode, address: String?
//}
//
//// MARK: - CommissionDetails
//struct CustomerActiveAgentsCommissionDetails:Codable {
//    let agentReserve, companyReserve, agentCommission: Int?
//}
//
//// MARK: - CompanyDetails
//struct CustomerActiveAgentsCompanyDetails:Codable {
//    let companyName, website, logo, finamNo: String?
//    let ciceroNo, email, telephone, country: String?
//    let state, city, address, postCode: String?
//    let privateCriminalRecord, privateOp, companyPo: String?
//}


struct CustomerActiveAgentModel: Codable {
    let status: String?
    let data: CustomerActiveAgentDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct CustomerActiveAgentDataClass: Codable {
    let agentsList: [CustomerActiveAgentsList]?
}

// MARK: - AgentsList
struct CustomerActiveAgentsList: Codable {
    let partnerId, source: String?
    let sourceName: String?
    let profile, firstName, lastName, mobile: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let country, state, city, address: String?
    let postCode, language, nationality: String?
    let companyDetails: CustomerActiveCompanyDetails?
    let roleType, dob: String?
    let commissionDetails: CustomerActiveCommissionDetails?
    let bankDetails: CustomerActiveBankDetails?
    let subscriptionPlan: String?
    let profilePic: String?
    let password: String?
    let isDefaultPasswordSet: Bool?
    let customerCount: Int?
    let partnerState, type: String?
    let reason: String?
}

// MARK: - BankDetails
struct CustomerActiveBankDetails: Codable {
    let iban, swift, bank, country: String?
    let postCode, address: String?
}

// MARK: - CommissionDetails
struct CustomerActiveCommissionDetails: Codable {
    let agentReserve, companyReserve, agentCommission: Double?
}

// MARK: - CompanyDetails
struct CustomerActiveCompanyDetails: Codable {
    let companyName, website, logo, finamNo: String?
    let ciceroNo, email, telephone, country: String?
    let state, city, address, postCode: String?
    let privateCriminalRecord, privateOp, companyPo: String?
}

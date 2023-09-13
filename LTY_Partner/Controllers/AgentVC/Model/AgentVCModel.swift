//
//  AgentVCModel.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import Foundation

struct AgentVCModel: Codable {
    let status: String?
    let error: AgentVCError?
    let data: DataClass?

}

// MARK: - DataClass
struct DataClass: Codable {
    let agentsList: [AgentsList]?
}

// MARK: - AgentsList
struct AgentsList: Codable {
    let partnerId, source, profile, firstName: String?
    let lastName, mobile: String?
    let roleId, roleName: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let country,countryCode, state, city, address: String?
    let postCode, language, nationality: String?
    let companyDetails: CompanyDetails?
    let roleType, dob: String?
    let commissionDetails: CommissionDetails?
    let bankDetails: BankDetails?
    let subscriptionPlan, password: String?
    let isDefaultPasswordSet: Bool?
    let customerCount: Int?
    let partnerState, type: String?
    let reason: String?
}

// MARK: - BankDetails
struct BankDetails: Codable{
    let iban, swift, bank, country, state ,city : String?
    let postCode, address: String?
}

// MARK: - CommissionDetails
struct CommissionDetails: Codable {
    let agentReserve, companyReserve, agentCommission: Float?
}

// MARK: - CompanyDetails
struct CompanyDetails: Codable {
    let companyName, website, logo, finamNo: String?
    let ciceroNo, email, telephone,countryCode, country: String?
    let state, city, address, postCode: String?
    let privateCriminalRecord, privateOp, companyPo: String?
}



// MARK: - Error
struct AgentVCError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

//MARK:- AgentVC Delete Model Class
struct DeleteModel: Codable {
    let status: String?
    let data: DeleteDataStatus?
    let error: AgentVCError?
}

// MARK: - DataClass
struct DeleteDataStatus: Codable {
    let isAgentDeleted: Bool
}

//MARK:- AgentVC Parameters

struct AgentVcParam : Encodable {
    let partnerId : String?
    let searchBy :String?
}



//
//  AgentProfileModel.swift
//  LTY_Partner
//
//  Created by CTS on 01/06/23.
//

import Foundation

struct AgentViewProfileModel:Codable {
    let status: String?
    let data: AgentViewProfileData?
    let error: SignUpError?
}

// MARK: - DataClass
struct AgentViewProfileData :Codable {
    let partnerID, source, sourceName, profile: String?
    let firstName, lastName,countryCode, mobile: String?
    let roleName, roleId: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let country, state, city, address, gender: String?
    let postCode, language, nationality: String?
    let companyDetails: AgentViewProfileCompanyDetails?
    let roleType, dob: String?
    let commissionDetails: AgentViewProfileCommissionDetails?
    let bankDetails: AgentViewProfileBankDetails?
    let subscriptionPlan, profilePic, password: String?
    let isDefaultPasswordSet: Bool?
    let customerCount: Int?
    let partnerState, type, reason: String?
}

// MARK: - BankDetails
struct AgentViewProfileBankDetails :Codable {
    let iban, swift, bank, country, state, city: String?
    let postCode, address: String?
}

// MARK: - CommissionDetails
struct AgentViewProfileCommissionDetails :Codable {
    let agentReserve, companyReserve, agentCommission: Double?
}

// MARK: - CompanyDetails
struct AgentViewProfileCompanyDetails :Codable {
    let companyName, website, logo, finamNo: String?
    let ciceroNo, email, telephone, country: String?
    let state, city, address, postCode: String?
    let privateCriminalRecord, privateOp, companyPo: String?
}

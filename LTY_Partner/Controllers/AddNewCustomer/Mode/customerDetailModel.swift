//
//  customerDetailModel.swift
//  LTY_Partner
//
//  Created by Ritesh Sinha on 28/05/23.
//

import Foundation

struct CustomerUpdateModel: Codable {
    let status: String?
    let data: CustomerUpdateDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct CustomerUpdateDataClass: Codable {
    let userId, source, type, firstName: String?
    let lastName, mobile,countryCode: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let dob, country, state, city: String?
    let address, postCode, maritalStatus, gender: String?
    let agentId, agentName, partnerId: String?
    let registrationIds : [String]?
    let insurerCompanies : [String]?
    let partnerName, profilePic: String?
    let companyDetails: CustomerUpdateCompanyDetails?
    let bankDetails: CustomerUpdateBankDetails?
    let isDefaultPasswordSet: Bool?
    let userState, reason: String?
}

// MARK: - BankDetails
struct CustomerUpdateBankDetails: Codable {
    let iban, swift, bank, country: String?
    let postCode, address: String?
}

// MARK: - CompanyDetails
struct CustomerUpdateCompanyDetails: Codable {
    let companyName, website: String?
    let noOfEmployee: Int?
    let companyId, legalEntity: String?
}


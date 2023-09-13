//
//  AddProposalModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import Foundation

struct AddProposalAgentModel: Codable {
    let status: String?
    let data: AddProposalAgentDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct AddProposalAgentDataClass: Codable {
    let agentList: [AddProposalAgentAgentList]?
}

// MARK: - AgentList
struct AddProposalAgentAgentList: Codable {
    let agentId, agentName: String?
}

/// MARK: >> MembersModel >>

struct AddProposalMembersModel: Codable {
    let status: String?
    let data: AddProposalMembersModelDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct AddProposalMembersModelDataClass: Codable {
    let usersList: [AddProposalMembersModelUsersList]?
}

// MARK: - UsersList
struct AddProposalMembersModelUsersList: Codable {
    let userId, source, type, firstName: String?
    let lastName, mobile: String?
    var isSelected: String?
    let isMobileVerified: Bool?
    let email: String?
    let isEmailVerified: Bool?
    let dob, country, state, city: String?
    let address, postCode, maritalStatus, gender: String?
    let registrationId, agentId, agentName, partnerId: String?
    let partnerName, profilePic: String?
    let companyDetails: AddProposalMembersModelCompanyDetails?
    let bankDetails: AddProposalMembersModelBankDetails?
    let isDefaultPasswordSet: Bool?
    let userState, reason, createdOn, lastUpdatedOn: String?
}

struct CellState: Codable {
    var selected:String?
    init(){
        selected = "no"
    }
}

// MARK: - BankDetails
struct AddProposalMembersModelBankDetails: Codable {
    let iban, swift, bank, country: String?
    let postCode, address: String?
}

// MARK: - CompanyDetails
struct AddProposalMembersModelCompanyDetails: Codable {
    let companyName, website: String?
    let noOfEmployee: Int?
    let companyId, legalEntity: String?
}


//MARK :-

struct addProposalModel: Codable {
    let status: String?
    let data: addProposalDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct addProposalDataClass: Codable {
    let policyId, status: String?
}

//MARK :-

struct editProposalModel: Codable {
    let status: String?
    let data: editProposalDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct editProposalDataClass: Codable {
    let offerId, status: String?
}



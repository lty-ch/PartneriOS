//
//  ProposalModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 01/06/23.
//

import Foundation
 
    
struct ProposalModel: Codable {
    let status: String?
    let data: ProposalDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct ProposalDataClass: Codable {
    let proposalsList: [ProposalsList]?
}

// MARK: - ProposalsList
struct ProposalsList: Codable {
    let proposalId, partnerId, leadId, offerType: String?
    let policyDetails: ProposalPolicyDetails?
    let memberDetails: ProposalMemberDetails?
    let insuranceType: String?
    let metadata: ProposalMetadata?
    let commissionDetails: ProposalCommissionDetails?
    let leadDetails: ProposalLeadDetails?
    let agentDetails: ProposalAgentDetails?
    let proposalState: String?
    let signedDoc: [String]?
    let isDeleted: Bool?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

struct ProposalAgentDetails: Codable {
    let agentId, agentName, email, mobile:String?
}
// MARK: - LeadDetails
struct ProposalLeadDetails: Codable {
    let leadId, memberId, memberName, relation:String?
    let agentNetCommission, agentCommission: Double?
}

// MARK: - CommissionDetails
struct ProposalCommissionDetails: Codable {
    let partnerGrossCommission, partnerReserve, partnerCommission, agentGrossCommission:Double?
    let agentReserve, agentCommission: Double?
}

// MARK: - MemberDetails
struct ProposalMemberDetails: Codable {
    let memberID, firstName, lastName, email: String?
    let mobile, address, countryCode, country, state: String?
    let city, postCode: String?
}

// MARK: - Metadata
struct ProposalMetadata: Codable {
    let type, buildingType, use, coverAs: String?
    let securityMeasures, roofConstruction, heatingSystem, yearOfConstruction: String?
    let realEstateValue: String?
    let blankets: [String]?
    let rcBuilding, franchise: String?
}

// MARK: - PolicyDetails
struct ProposalPolicyDetails: Codable {
    let policyId, offerId, policyType, startDate, endDate: String?
    let keyTags: [String]?
    let periodicity: String?
    let premiumAmount: Int?
    let policyDocs: [String]?
    let policyVisibility: String?
    let categoryDetails: ProposalCategoryDetails?
    let productDetails: ProposalProductDetails?
    let agentID, agentName: String?
    let totalAmount: Int?
    let keyFeatures, productBenefits: String?
}

// MARK: - CategoryDetails
struct ProposalCategoryDetails: Codable {
    let categoryID, categoryName, subCategoryID, subCategoryName: String?
}

// MARK: - ProductDetails
struct ProposalProductDetails: Codable {
    let productList: [ProposalProductList]?
}

// MARK: - ProductList
struct ProposalProductList: Codable {
    let productID, productName: String?
    let amount: Int?
}

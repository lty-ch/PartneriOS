//
//  ProposalDetailModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 07/06/23.
//

import Foundation

struct ValidatePolicyId : Codable{
    let status: String?
    let data: ValidatePolicyIdData?
    let error: CatError?
}

struct ValidatePolicyIdData : Codable {
    let isValid, linkedWithSameUser: Bool?
}


struct commissionModel: Codable {
    let status: String?
    let data: commissionDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct commissionDataClass: Codable {
    let partnerCommission, partnerReserve, partnerGrossCommission, agentCommission: Double?
    let agentReserve, agentGrossCommission: Double?
}

// MARK: -> View Proposal Model

struct ViewProposalModel:Codable {
    let status: String?
    let data: ViewProposalData?
    let error: CatError?
}

// MARK: - DataClass
struct ViewProposalData:Codable {
    let proposalId, partnerId, leadId: String?
    let policyDetails: ViewProposalPolicyDetails?
    let memberDetails: ViewProposalMemberDetails?
    let leadDetails: ViewProposalLeadDetails?
    let insuranceType: String?
    let metadata: ViewProposalMetadata?
    let commissionDetails: ViewProposalCommissionDetails?
    let agentDetails: ViewProposalAgentDetails?
    let proposalState: String?
    let signedDoc: [String]?
    let contractDoc: [String]?
    let isDeleted: Bool?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

// MARK: - AgentDetails
struct ViewProposalAgentDetails:Codable {
    let agentId, agentName, email, countryCode, mobile: String?
}

// MARK: - CommissionDetails
struct ViewProposalLeadDetails:Codable {
    let leadId, memberId, memberName, relation: String?
}

// MARK: - CommissionDetails
struct ViewProposalCommissionDetails:Codable {
    let partnerCommission, partnerReserve, partnerGrossCommission, agentCommission: Double?
    let agentReserve, agentGrossCommission: Double?
    let commissionDate: String?
}

// MARK: - MemberDetails
struct ViewProposalMemberDetails :Codable{
    let memberId,dob,firstName, lastName, email: String?
    let mobile, address, countryCode, country, state: String?
    let city, postCode: String?
}

// MARK: - Metadata
struct ViewProposalMetadata:Codable {
    let type, buildingType, use, coverAs: String?
    let securityMeasures, roofConstruction, heatingSystem, yearOfConstruction: String?
    let realEstateValue: String?
    let blankets: [String]?
    let rcBuilding, franchise: String?
}

// MARK: - PolicyDetails
struct ViewProposalPolicyDetails:Codable {
    let policyId, offerId, policyType, startDate, endDate: String?
    let keyTags: [String]?
    let periodicity: String?
    let premiumAmount: Int?
    let policyDocs: [String]?
    let policyVisibility: String?
    let categoryDetails: ViewProposalCategoryDetails?
    let productDetails: ViewProposalProductDetails?
    let agentId, agentName: String?
    let totalAmount: Int?
    let keyFeatures, productBenefits: String?
}

// MARK: - CategoryDetails
struct ViewProposalCategoryDetails:Codable {
    let categoryId, categoryName,categoryNameInFrench, subCategoryId, subCategoryName ,subCategoryNameInFrench: String?
}

// MARK: - ProductDetails
struct ViewProposalProductDetails :Codable{
    let productList: [ViewProposalProductList]?
}

// MARK: - ProductList
struct ViewProposalProductList:Codable {
    let productId, productName,productNameInFrench : String?
    let amount: Int?
}

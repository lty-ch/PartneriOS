//
//  LeadProposalModel.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 13/06/23.
//

import Foundation

struct LeadProposalModel:Codable {
    let status: String?
    let data: LeadProposalData?
    let error: CatError?
}


struct LeadProposalData:Codable {
    let proposalsList: [LeadProposalsList]?
}

struct LeadProposalsList:Codable {
    let proposalId, partnerId, leadId: String?
    let policyDetails: LeadProposalPolicyDetails?
    let memberDetails: LeadProposalMemberDetails?
    let insuranceType: String?
    let metadata: LeadProposalMetadata?
    let commissionDetails: LeadProposalCommissionDetails?
    let proposalState: String?
    let signedDoc: [String]?
    let isDeleted: Bool?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

// MARK: - CommissionDetails
struct LeadProposalCommissionDetails:Codable {
    let partnerCommission, partnerReserve, partnerGrossCommission, agentCommission: Double?
    let agentReserve, agentGrossCommission: Double?
}

// MARK: - MemberDetails
struct LeadProposalMemberDetails:Codable {
    let memberId, firstName, lastName, email: String?
    let mobile, address, country, state: String?
    let city, postCode: String?
}

struct LeadProposalMetadata:Codable {
    let type, buildingType, use, coverAs: String?
    let securityMeasures, roofConstruction, heatingSystem, yearOfConstruction: String?
    let realEstateValue: String?
    let blankets: [String]?
    let rcBuilding, franchise: String?
}

struct LeadProposalPolicyDetails:Codable {
    let policyId, policyType, startDate, endDate: String?
    let keyTags: [String]?
    let periodicity: String?
    let premiumAmount: Int?
    let policyDocs: [String]?
    let policyVisibility: String?
    let categoryDetails: LeadProposalCategoryDetails?
    let productDetails: LeadProposalProductDetails?
    let agentId, agentName: String?
    let totalAmount: Int?
    let keyFeatures, productBenefits: String?
}

// MARK: - CategoryDetails
struct LeadProposalCategoryDetails:Codable {
    let categoryId, categoryName, subCategoryId, subCategoryName: String?
}

// MARK: - ProductDetails
struct LeadProposalProductDetails:Codable {
    let productList: [LeadProposalProductList]?
}

// MARK: - ProductList
struct LeadProposalProductList:Codable {
    let productId, productName: String?
    let amount: Int?
}

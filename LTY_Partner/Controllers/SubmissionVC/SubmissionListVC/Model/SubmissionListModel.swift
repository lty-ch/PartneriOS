//
//  SubmissionListModel.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import Foundation

struct SubmissionModel:Codable {
    let status: String?
    let data: SubmissionData?
    let error: CatError?
}

struct SubmissionData:Codable  {
    let proposalsList: [SubmissionProposalsList]?
}

struct SubmissionProposalsList:Codable  {
    let proposalId, partnerId, offerType, leadId: String?
    let policyDetails: SubmissionPolicyDetails?
    let memberDetails: SubmissionMemberDetails?
    let insuranceType: String?
    let metadata: SubmissionMetadata?
    let commissionDetails: SubmissionCommissionDetails?
    let leadDetails: SubmissionLeadDetails?
    let agentDetails: SubmissionAgentDetails?
    let proposalState: String?
    let signedDoc: [String]?
    let contractDoc: [String]?
    let isDeleted: Bool?
    let createdBy, updatedBy, createdOn: String?
    let commissionDate : Int?
    let lastUpdatedOn: String?
}

struct SubmissionCommissionDetails:Codable  {
    let partnerCommission, partnerReserve, partnerGrossCommission, agentCommission: Double?
    let agentReserve, agentGrossCommission: Double?
    let frequency: String?
    let commissionDate : String?
}

struct SubmissionMemberDetails:Codable  {
    let memberId, firstName, lastName, email: String?
    let mobile, dob, address, country: String?
    let state, city, postCode: String?
}

struct SubmissionMetadata:Codable  {
    let type, buildingType, use, coverAs: String?
    let securityMeasures, roofConstruction, heatingSystem, yearOfConstruction: String?
    let realEstateValue: String?
    let blankets: [String]?
    let rcBuilding, franchise: String?
}

struct SubmissionPolicyDetails:Codable  {
    let policyId, offerId, policyType, startDate, endDate: String?
    let keyTags: [String]?
    let periodicity: String?
    let premiumAmount: Int?
    let policyDocs: [String]?
    let policyVisibility: String?
    let categoryDetails: SubmissionCategoryDetails?
    let productDetails: ProductDetails?
    let agentID, agentName: String?
    let totalAmount: Int?
    let keyFeatures, productBenefits: String?
}

struct SubmissionAgentDetails: Codable {
    let agentId, agentName, email, mobile:String?
}
// MARK: - LeadDetails
struct SubmissionLeadDetails: Codable {
    let leadId, memberId, memberName, relation:String?
    let agentNetCommission, agentCommission: Double?
}

struct SubmissionCategoryDetails:Codable  {
    let categoryId, categoryName, categoryLogo, subCategoryId: String?
    let subCategoryName: String?
}

struct ProductDetails:Codable  {
    let productList: [SubmissionProductList]?
}

struct SubmissionProductList:Codable {
    let productId, productName: String?
    let amount: Int?
}


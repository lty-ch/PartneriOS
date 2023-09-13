//
//  AgentCommission+Model.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation


struct AgentCommissionModel :Codable  {
    let status: String?
    let data: AgentCommissionData?
    let error: CatError?
}

struct AgentCommissionData :Codable {
    let feeDetailsList: [AgentCommissionDetailList]?
}

struct AgentCommissionDetailList :Codable  {
    let feeId, agentId, agentName, categoryID: String?
    let categoryName, subCategoryId, subCategoryName, commissionType: String?
    let commissionDetails: AgentCommissionDetails?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

struct AgentCommissionDetails :Codable {
    let agentReserve, companyReserve, agentCommission: Double?
}

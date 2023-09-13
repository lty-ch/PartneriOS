//
//  SearchCoverModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 17/07/23.
//

import Foundation

struct SCOverAllModel : Codable{
    let status: String?
    let data: SCOverAllData?
    let error: CatError?
}

struct SCOverAllData :Codable {
    let proposalShared, contractSigned: Int?
    let totalAmount, totalIncome: Double?
}


//MARK:- get customer List

struct SC_CustomerModel:Codable {
    let status: String?
    let data: SC_CustomerData?
    let error: CatError?
}

struct SC_CustomerData:Codable {
    let customersStatisticsList: [CustomersStatisticsList]?
}

struct CustomersStatisticsList :Codable {
    let customerId, customerName, agentId, agentName: String?
    let email, mobile: String?
    let proposalShared, contractSigned: Int?
    let totalAmount: Double?
}

//MARK:- get agent cover List

struct SC_AgentModel : Codable {
    let status: String?
    let data: SC_AgentData?
    let error: CatError?
}

struct SC_AgentData : Codable {
    let agentsStatisticsList: [AgentsStatisticsList]?
}

struct AgentsStatisticsList : Codable {
    let agentID, agentName, email, mobile: String?
    let customers, proposalShared, contractSigned: Int?
    let totalIncome, totalAmount: Double?
}

//MARK:- get analysis cover List

struct SC_AnalysisModel :Codable {
    let status: String?
    let data: SC_AnalysisData?
    let error: CatError?
}

// MARK: - DataClass
struct SC_AnalysisData :Codable {
    let proposalPerLead, signaturePerProposal, signaturePerCategory, signaturePerSubCategory: Double?
    let signaturePerLead: Double?
}

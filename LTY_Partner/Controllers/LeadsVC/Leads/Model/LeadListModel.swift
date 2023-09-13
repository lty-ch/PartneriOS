//
//  LeadListModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/06/23.
//

import Foundation


// MARK: - Welcome6
struct LeadModel:Codable {
    let status: String
    let data: LeadVCData?
    let error: SignUpError?
}

// MARK: - DataClass
struct LeadVCData:Codable {
    let leadsList: [LeadList]?
}

// MARK: - LeadsList
struct LeadList:Codable {
    let leadId, partnerId, agentId, agentName: String?
    let memberDetails: LeadMemberDetails?
    let memberId, relation, insuranceType: String?
    let metadata: LeadMetadata?
    var status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct LeadMemberDetails :Codable{
    let memberId, firstName, lastName, email: String?
    let mobile, address, countryCode,country, state: String?
    let city, postCode: String?
}

// MARK: - Metadata
struct LeadMetadata :Codable{
    let type, buildingType, use, coverAs: String?
    let securityMeasures, roofConstruction, heatingSystem, yearOfConstruction: String?
    let realEstateValue: String?
    let blankets: [String]?
    let rcBuilding, franchise: String?
}

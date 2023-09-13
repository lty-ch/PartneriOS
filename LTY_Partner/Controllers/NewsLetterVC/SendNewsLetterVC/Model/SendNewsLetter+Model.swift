//
//  SendNewsLetter+Model.swift
//  LTY_Partner
//
//  Created by Chawtech on 10/08/23.
//

import Foundation



struct SendNewsLetterModel :Codable {
    let status: String?
    let data: SendNewsLetterData?
    let error: CatError?
}

struct SendNewsLetterData :Codable {
    let templateList: [SendNewsLetterTemplateList]?
}


struct SendNewsLetterTemplateList :Codable {
    let templateId, partnerId, partnerName, agentId: String?
    let agentName, templateName, content: String?
    let templateSettingDetails: SendNewsLetterTemplateSettingDetails?
    let personalizationDetails: SendNewsLetterPersonalizationDetails?
    let companyDetails: SendNewsLetterCompanyDetails?
    let createdOn, lastUpdatedOn: String?
}

struct SendNewsLetterCompanyDetails :Codable {
    let title, address, mobile, copyRight: String?
}

struct SendNewsLetterPersonalizationDetails :Codable {
    let firstName, lastName, mobile, email: String?
}


struct SendNewsLetterTemplateSettingDetails :Codable {
    let title, name, email: String?
}



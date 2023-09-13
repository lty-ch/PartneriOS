//
//  AddNewTemplate+Model.swift
//  LTY_Partner
//
//  Created by Chawtech on 10/08/23.
//

import Foundation

struct AddNewTempModel :Codable {
    let status: String?
    let data: AddNewTempData?
    let error: CatError?
}

struct AddNewTempData :Codable {
    let templateID, status: String?
}

//MARK:- Get Tem Model

struct GetTempModel :Codable {
    let status: String?
    let data: GetTempData?
    let error: CatError?
}

struct GetTempData :Codable {
    let templateId, partnerId, partnerName, agentId: String?
    let agentName, templateName, content: String?
    let templateSettingDetails: GetTempTemplateSettingDetails?
    let personalizationDetails: GetTempPersonalizationDetails?
    let companyDetails: GetTempCompanyDetails?
    let createdOn, lastUpdatedOn: String?
}

struct GetTempCompanyDetails :Codable {
    let title, address, mobile, copyRight: String?
}


struct GetTempPersonalizationDetails :Codable {
    let firstName, lastName, mobile, email: String?
}

struct GetTempTemplateSettingDetails :Codable {
    let title, name, email: String?
}


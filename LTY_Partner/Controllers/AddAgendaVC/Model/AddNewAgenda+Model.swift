//
//  AddNewAgenda+Model.swift
//  LTY_Partner
//
//  Created by Chawtech on 25/07/23.
//

import Foundation

struct AddNewAgendaModel: Codable  {
    let status: String?
    let data: AddNewAgendaData?
    let error: CatError?
}

struct AddNewAgendaData: Codable {
    let status: String?
}

// MARK:- GetAgenda Detail

struct GetAgendaDModel :Codable{
    let status: String?
    let data: GetAgendaData?
    let error: CatError?
}

struct GetAgendaData :Codable {
    let id: Int?
    let partnerID, agentID: String?
    let users:[String:String]?// GetAgendaUsers?
    let date, timeFrom, timeTo, task: String?
    let description, createdOn, lastUpdatedOn: String?
}

struct GetAgendaUsers :Codable{
    let additionalProp1, additionalProp2, additionalProp3: String?
}



//
//  AgendaModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import Foundation



struct AgendaModel:Codable {
    let status: String?
    let data: AgendaModelData?
    let error: CatError?
}

struct AgendaModelData:Codable {
    let agendaList: [AgendaList]?
}

struct AgendaList:Codable {
    let id: Int?
    let partnerId, agentId: String?
    let users:  [String:String]?
    let date, timeFrom, timeTo, task: String?
    let agendaListDescription, createdOn, lastUpdatedOn: String?
}



//
//  RolesModel.swift
//  LTY_Partner
//
//  Created by CTS on 27/06/23.
//

import Foundation

struct RolesModel:Codable {
    let status: String?
    let data: rolesData?
    let error: CatError?
}

// MARK: - DataClass
struct rolesData:Codable {
    let rolesList: [rolesList]?
}


// MARK: - DataClass
struct rolesList:Codable {
    let id, name: String?
    let isDefault: Bool?
}

//MARK:- AgentListRoleModel

struct AgentListRoleModel:Codable {
    let status: String?
    let data: AgentListRoleData?
    let error: CatError?
}

struct AgentListRoleData:Codable {
    let usersList: [AgentListRoleList]?
}

struct AgentListRoleList:Codable {
    let userId, name , email: String?
    let roleId, roleName: String?
}



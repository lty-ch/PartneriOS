//
//  RoleDetailModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 27/06/23.
//

import Foundation
//MARK:- Role detail Model

struct RoleDetailModel:Codable {
    var status: String?
    var data: RoleDetailData?
    var error: CatError?
}

struct RoleDetailData:Codable {
    var useCasesList: [RoleDetailList]?
}

struct RoleDetailList:Codable {
    var useCaseId:Int?
    var name :String?
    var nameInFrench :String?
    var permissionIds:[Int]?
    var selectedPermissionIds:[Int]?
}

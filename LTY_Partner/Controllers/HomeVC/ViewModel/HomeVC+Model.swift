//
//  HomeVC+Model.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/07/23.
//

import Foundation
 
struct HomeVCModel :Codable{
    let status: String?
    let data: HomeVCModelData?
    let error: CatError?
}

struct HomeVCModelData :Codable {
    let newSignedContractCount, newRegisteredUserCount: Int?
}



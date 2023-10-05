//
//  ShowImageModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/10/23.
//

import Foundation

struct ShowImageModel: Codable {
    let status: String?
    let data: ShowImageModelData?
    let error: CatError?
}

struct ShowImageModelData: Codable {
    let preSignedUrl: String?
}

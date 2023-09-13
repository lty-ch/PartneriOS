//
//  DeleteAccountModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/09/23.
//

import Foundation

struct DeleteAccountModel:Codable {
    let status: String?
    let data: DeleteAccountData?
    let error: CatError?
}

struct DeleteAccountData:Codable {
    let isAccountClosed: Bool?
}

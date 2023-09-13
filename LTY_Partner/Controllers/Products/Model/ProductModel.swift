//
//  ProductModel.swift
//  LTY_Partner
//
//  Created by CTS on 24/05/23.
//

import Foundation

struct ProductModel:Codable {
    let status: String?
    let data: ProductData?
    let error: CatError?
}

// MARK: - DataClass
struct ProductData :Codable {
    let productList: [ProductListt]?
    let productListInFrench: [ProductListtInFrench]?
}

// MARK: - ProductList
struct ProductListt :Codable {
    let id: Int?
    let productId, productName, productNameInFrench, commissionType: String?
    let commission: Float?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

struct ProductListtInFrench :Codable {
    let id: Int?
    let productId, productName,productNameInFrench, commissionType: String?
    let commission: Float?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

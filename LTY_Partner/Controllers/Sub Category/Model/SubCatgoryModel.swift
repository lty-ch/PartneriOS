//
//  SubCatgoryModel.swift
//  LTY_Partner
//
//  Created by CTS on 24/05/23.
//

import Foundation

struct SubCategoryModel :Codable {
    let status: String?
    let data: SubCategoryData?
    let error: CategoryError?
}

// MARK: - DataClass
struct SubCategoryData:Codable  {
    let subCategoryList: [SubCategoryDataList]?
    let subCategoryListInFrench: [SubCategoryDataListInFrench]?
}

// MARK: - SubCategoryList
struct SubCategoryDataList :Codable {
    let subCategoryId, subCategoryName,subCategoryNameInFrench: String?
}

struct SubCategoryDataListInFrench :Codable {
    let subCategoryId, subCategoryName: String?
}

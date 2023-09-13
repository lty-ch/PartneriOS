//
//  SelectCatModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 23/05/23.
//

import Foundation

struct SuccessModel : Codable {
    let status: String?
    let data: DataClas?
    let error: CatError?
}

struct DataClas : Codable {
    let status: String?
}

struct SelectCatResponse : Codable {
    let status: String?
    let data: DataClasss?
    let error: CatError?
    
}

// MARK: - DataClass
struct DataClasss : Codable {
    let categoryList: [CategoryList]?
}

// MARK: - CategoryList
struct CategoryList : Codable {
    let categoryId, category , categoryInFrench , insuranceCompany, personOfContact: String?
    let mailOfContact, complainMailOfContact, phoneNumber, address: String?
    let logo, createdOn, lastUpdatedOn: String?
    var isSelected: String?
    let subCategoryAndProductList: [SubCategoryAndProductList]?
}



// MARK: - SubCategoryAndProductList
struct SubCategoryAndProductList : Codable {
    let subCategoryId, subCategory, subCategoryInFrench: String?
    let productCount: Int?
    let productList: [ProductList]?
}


// MARK: - ProductList
struct ProductList : Codable {
    let productId, productName, productNameInFrench, categoryId: String?
    let parentCategoryName, categoryName, createdBy, updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}



struct CatError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

// MARK:- Select Sub Cat Model


struct SelectSubCatModel:Codable {
    let status: String?
    let data: SelectSubCatData?
    let error: CatError?
}

struct SelectSubCatData :Codable{
    let productList: [SelectSubCatProductList]?
}

struct SelectSubCatProductList :Codable{
    let productId, productName, productNameInFrench,categoryId, parentCategoryName ,parentCategoryNameInFrench : String?
    let categoryName ,categoryNameInFrench : String?
    let createdBy, updatedBy: String?
    let createdOn, lastUpdatedOn: String?
    let commission: Double?
}


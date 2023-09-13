//
//  CategoryModel.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/23/23.
//

import Foundation



struct CategoryModel: Codable {
    let status: String?
    let data: DataCl?
    let error: CategoryError?
}

// MARK: - DataClass
struct DataCl: Codable {
    let categoryList: [MainCategoryList]?
    let categoryListInFrench: [MainCategoryListInFrench]?
}

// MARK: - CategoryList
struct MainCategoryList : Codable {
    let categoryId, categoryName ,categoryNameInFrench: String?
    let subCategoryList: [SubCategoryList]?
}

struct MainCategoryListInFrench : Codable {
    let categoryId, categoryName: String?
    let subCategoryListInFrench: [SubCategoryListInFrench]?
}

// MARK: - SubCategoryList
struct SubCategoryList: Codable {
    let subCategoryId, subCategoryName: String?
}

struct SubCategoryListInFrench: Codable {
    let subCategoryId, subCategoryName: String?
}


struct CategoryNewModel: Codable {
    let status: String?
    let data: CategoryNewDataCl?
    let error: CategoryError?
}

// MARK: - DataClass
struct CategoryNewDataCl: Codable {
    let categoryList: [MainCategoryNewList]?
    let categoryListInFrench: [MainCategoryNewListInFrench]?
}

// MARK: - CategoryList
struct MainCategoryNewList : Codable {
    let categoryId, categoryName, categoryNameInFrench: String?
    let subCategoryList: [SubCategoryNewList]?
    let subCategoryListInFrench: [SubCategoryNewListInFrench]?
}

// MARK: - CategoryList
struct MainCategoryNewListInFrench : Codable {
    let categoryId, categoryName: String?
    let subCategoryList: [SubCategoryNewList]?
    let subCategoryListInFrench: [SubCategoryNewListInFrench]?
}
// MARK: - SubCategoryList
struct SubCategoryNewList: Codable {
    let subCategoryId, subCategoryName, logo: String?
}
// MARK: - SubCategoryList
struct SubCategoryNewListInFrench: Codable {
    let subCategoryId, subCategoryName, logo: String?
}


//// MARK: - Welcome8
//struct CategoryModel : Codable {
//    let status: String?
//    let data: CategoryListModel?
//    let error: CategoryError?
//
//    init(){
//        status : nil
//         data : nil
//         error : nil
//    }
//}
//
//// MARK: - DataClass
//struct CategoryListModel : Codable{
//    let categoryList: [mainCategoryList]?
//}
//
//// MARK: - CategoryList
//struct mainCategoryList : Codable{
//    let categoryId, categoryName: String?
//    let subCategoryList: [SubCategoryList]?
//}
//
//// MARK: - SubCategoryList
//struct SubCategoryList : Codable{
//    let subCategoryId, subCategoryName: String?
//    let productList: [subCatProductList]?
//
////    init(){
////         subCategoryId : nil
////         subCategoryName : nil
////         productList : nil
////    }
//}
//
//// MARK: - ProductList
//struct subCatProductList : Codable{
//    let id: Int?
//    let productId, productName: String?
//    let commissionType: String? // CommissionType?
//    let commission: Double?
//    let createdBy, updatedBy:String? //AtedBy?
//    let createdOn, lastUpdatedOn: String?//AtedOn?
//}
// MARK: - Error
struct CategoryError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}
////MARK: -   CategoryVC Parameters
//
//struct CategoryVcParam : Encodable {
//    let partnerId : String?
//    let searchBy :String?
//}
//
////enum CommissionType {
////    case flat
////}
//
////enum AtedBy {
////    case otAyNjkyMjQzOTMwOTM3Nw
////}
////
////enum AtedOn {
////    case the20230519T113902
////    case the20230522T075122
////    case the20230522T075206
////}

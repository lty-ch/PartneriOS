//
//  CustomerMemberModel.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import Foundation

//struct CustomerMemberModel:Codable {
//    let status: String?
//    let data: CustomerMemberDataClass?
//    let error: CatError?
//}
//
//// MARK: - DataClass
//struct CustomerMemberDataClass:Codable {
//    let familyMemberId, userId, memberType, firstName: String?
//    let lastName, address, dob, email: String?
//    let mobile, gender: String?
//}

struct CustomerMemberModel:Codable {
    let status: String?
    let data: CustomerMemberDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct CustomerMemberDataClass:Codable {
    let familyMemberList: [FamilyMemberList]?
}

// MARK: - FamilyMemberList
struct FamilyMemberList:Codable {
    let registrationIds: [String]?
    let familyMemberId, userId, memberType, firstName: String?
    let lastName, address, dob, email: String?
    let mobile,countryCode , gender , profilePic: String?
}



// MARK:- Model for show document list

// MARK: - Welcome10
struct CustDocModel:Codable {
    let status: String?
    let data: CustDocData?
    let error: CatError?
}

struct CustDocData:Codable {
    let memberList: [CustDocMemberList]?
}

struct CustDocMemberList:Codable {
    let memberId, memberName, agentName, relation: String?
    let docCount: Int?
    let lastUploadedOn, uploadedBy: String?
}


struct CustMemberDocModel:Codable {
    let status: String?
    let data: CustMemberDocDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct CustMemberDocDataClass:Codable {
    let docList: [CustMemberDocDocList]?
}

// MARK: - DocList
struct CustMemberDocDocList:Codable {
    let id: Int?
    let userId, memberId, docName, docUrl, key: String?
    let uploadedOn, uploadedBy: String?
}

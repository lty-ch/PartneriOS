//
//  ContractDetailModel.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 20/06/23.
//

import Foundation

struct ContractDetailModel {
    var totalAmount:Int?
    var category:String?
    var subCategory:String?
    var name:String?
    var endDate:String?
    var startDate:String?
    var sumAssured:String?
    var totalDuration:String?
    var personCovered:String?
    var benifits:String?
    var premiumTerm:Int?
    var periodicity:String?
    var email:String?
    var agentName:String?
    var policyNumber:String?
    var policyName:String?
    var signedDoc:[String]?
    var policyDoc:[String]?
    var contractDoc:[String]?
}

struct ContractDetailModelForModifying {
    var name:String?
    var endDate:String?
    var startDate:String?
    var sumAssured:String?
    var totalDuration:String?
    var personCovered:String?
    var benifits:String?
    var premiumTerm:Int?
    var periodicity:String?
    var email:String?
    var agentName:String?
    var policyNumber:String?
    var policyName:String?
    var signedDoc:[String]?
    var policyDoc:[String]?
}

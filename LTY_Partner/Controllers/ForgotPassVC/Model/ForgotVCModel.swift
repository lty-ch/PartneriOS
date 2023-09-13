//
//  ForgotVCModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 15/05/23.
//

import Foundation

struct ForgotVCModel: Codable {
    let status: String?
    let data: ForgotVCData?
    let error: ForgotVCError?
}

struct ForgotVCData: Codable {
    let otpID, timeoutInSeconds: String?
    let remainingAttempts, resendOtpTime: Int?

    enum CodingKeys: String, CodingKey {
        case otpID = "otpId"
        case timeoutInSeconds, remainingAttempts, resendOtpTime
    }
}

// MARK: - Error
struct ForgotVCError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}



//MARK:- forgot VC Params

struct ForgotParams :Encodable {
    
    var email: String?
}

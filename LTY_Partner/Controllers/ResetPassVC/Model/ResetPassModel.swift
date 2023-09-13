//
//  ResetPassModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 15/05/23.
//

import Foundation

struct ResetPassModel: Codable {
    let status: String?
    let data: ResetPassData?
    let error: ResetPassError?
}

struct ResetPassData: Codable {
    let status: String?
}

// MARK: - Error
struct ResetPassError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}


//MARK:- Reeset pass params

struct ResetPassParam: Encodable {
    let email, password: String?
    let forgotPasswordOtpDetails: ResetPassOtpDetails?   

}

struct ResetPassOtpDetails: Encodable {
    let otpID, otp: String?

    enum CodingKeys: String, CodingKey {
        case otpID = "otpId"
        case otp
    }
}

//MARK:- this is used to save data after forgaot pass api

struct ForgotPassData {
    let otpID : String?
    let duration : String?
    let remainingAttempts : Int?
    let resendOtpTime : Int?

}

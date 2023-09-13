//
//  LoginModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation

struct LoginModel: Codable {
    let status: String?
    let data: LoginData?
    let error: LoginError?
}

// MARK: - DataClass
struct LoginData: Codable {
    let processStage: String?
    let processStageData: LoginProcessStageData?
}

// MARK: - ProcessStageData
struct LoginProcessStageData: Codable {
    let txnState: String?
    let txnStateData: LoginTxnStateData?
}

// MARK: - TxnStateData
struct LoginTxnStateData: Codable {
    let otpID, timeoutInSeconds, remainingAttempts, resendOtpTime: String?

      enum CodingKeys: String, CodingKey {
          case otpID = "otpId"
          case timeoutInSeconds, remainingAttempts, resendOtpTime
      }
}

// MARK: - Error
struct LoginError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

//MARK:- Login Params

struct LoginParams : Encodable {
    
     var email: String?
     var password: String?
    
}

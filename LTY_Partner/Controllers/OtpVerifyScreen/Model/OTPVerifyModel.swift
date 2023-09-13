//
//  OTPVerifyModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation

struct OtpVerifyModel: Codable {
    let status: String?
    let data: OtpVerifyDataClass?
    let error: OtpVerifyError?
}


// MARK: - DataClass
struct OtpVerifyDataClass: Codable {
    let processStage: String
    let processStageData: ProcessStageData
}

// MARK: - ProcessStageData
struct ProcessStageData: Codable {
    let txnState: String
    let txnStateData: TxnStateData
}

// MARK: - TxnStateData
struct TxnStateData: Codable {
    let userType, partnerID, state, token: String
    let isDefaultPasswordSet: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userType
        case partnerID = "partnerId"
        case state, token
        case isDefaultPasswordSet
    }
}

// MARK: - Error
struct OtpVerifyError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}

//MARK:- Otp verify params

struct OTPVerifyParams :Encodable {
    
        let email, action: String?
        var actionParams: ActionParams?
        var emailActionParams: EmailParams?
    }

  
struct ActionParams: Codable {
    let otpID, otp: String?
    
    enum CodingKeys: String, CodingKey {
        case otpID = "otpId"
        case otp
    }
}

struct EmailParams: Codable {
    let otpID, otp: String?
    
    enum CodingKeys: String, CodingKey {
        case otpID = "otpId"
        case otp
    }
}


//MARK:- Resend otp Model

// MARK: - Welcome
struct ResendOtpM: Codable {
    let status: String?
    let data: ResendOtpMDataClass?
    let error: ResendOtpMError?
}

// MARK: - DataClass
struct ResendOtpMDataClass: Codable {
    let otpID, timeoutInSeconds: String?
    let remainingAttempts, resendOtpTime: Int?

    enum CodingKeys: String, CodingKey {
        case otpID = "otpId"
        case timeoutInSeconds, remainingAttempts, resendOtpTime
    }
}



struct ResendOtpMError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}



//// MARK: - Updated Email Verify Model
//struct OTPVerifyEmailParams: Encodable {
//    let partnerId, newEmail: String
//    var newEmailOtpDetails: UpdatedOtpDetails?
//}
//
//// MARK: - Updated Phone Verify Model
//struct OTPVerifyPhoneParams: Encodable {
//    let partnerId, newMobile: String
//    var newMobileOtpDetails: UpdatedOtpDetails?
//}
//
//// MARK: - OtpDetails
//struct UpdatedOtpDetails: Codable {
//    let otpID, otp: String
//
//    enum CodingKeys: String, CodingKey {
//        case otpID = "otpId"
//        case otp
//    }
//}
//// MARK: - Updated Email Verify Model //////////////
//struct OTPVerifyPhoneEmailParams: Encodable {
//    let partnerId: String
//   // var newEmail: String?
//    var newMobile: String?
//    var newPhoneEmailOtpDetails: UpdatedOtpDetails
//}
//// MARK: - OtpDetails
//struct UpdatedOtpDetails: Codable {
//    let otpID, otp: String
//
//    enum CodingKeys: String, CodingKey {
//        case otpID = "otpId"
//        case otp
//    }
//}
// MARK: - Updated Email Verify Model
struct OTPVerifyPhoneParams: Encodable {
    let partnerId: String
    let newMobile: String
    let countryCode: String
    var newMobileOtpDetails: NewMobileOtpDetails
}
// MARK: - OtpDetails
struct NewMobileOtpDetails: Codable {
    let otpId, otp: String
}

// MARK: - Updated Email Verify Model
struct OTPVerifyEmailParams: Encodable {
    let partnerId: String
    let newEmail: String
    var newEmailOtpDetails: NewEmailOtpDetails
}
// MARK: - OtpDetails
struct NewEmailOtpDetails: Codable {
    let otpId, otp: String
}




//// MARK: - Welcome
//struct Welcome: Codable {
//    let partnerID, newMobile: String
//    let newMobileOtpDetails: NewMobileOtpDetails
//
//    enum CodingKeys: String, CodingKey {
//        case partnerID = "partnerId"
//        case newMobile, newMobileOtpDetails
//    }
//}
//
//// MARK: - NewMobileOtpDetails
//struct NewMobileOtpDetails: Codable {
//    let otpID, otp: String
//
//    enum CodingKeys: String, CodingKey {
//        case otpID = "otpId"
//        case otp
//    }
//}

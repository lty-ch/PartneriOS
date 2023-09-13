//
//  UpdatePhoneEmailModel.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 22/05/23.
//

import Foundation


//MARK:- UpdatePhoneEmail VC Params

struct UpdatePhoneEmailParams :Encodable {
    var partnerId: String?
    var newEmail: String?
}


struct UpdatePhoneParams :Encodable {
    var partnerId: String?
    var newMobile: String?
}

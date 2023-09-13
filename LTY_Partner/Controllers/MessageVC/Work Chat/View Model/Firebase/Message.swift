//
//  WorkChatDetailChatVC.swift
//  Skazule
//
//  Created by CTS-Jay Gupta on 28/06/23.
//

import Foundation

//struct Message: Encodable {
//    var content: String?
//    var fromID: String?
//    var timestamp: String?
//    var isRead: Bool?
//    var toID: String?
//    var type: String?
//    var queryId: String?
//    
//}

struct Message1: Encodable {
    var message    : String?
    var senderId   : String? //fromID
    var receiverId : String? //toID
    var timestamp  : String?
    var type       : String?
    var isSeen     : Bool?
//    var companyId  : String?
//    var email      : String?
//    var role       : String?
//    var profileImg : String?
}




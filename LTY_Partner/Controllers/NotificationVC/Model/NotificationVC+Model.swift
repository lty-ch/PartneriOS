//
//  NotificationVC+Model.swift
//  LTY_Partner
//
//  Created by Chawtech on 28/08/23.
//

import Foundation

struct NotificationModel :Codable {
    let status: String?
    let data: NotificationData?
    let error: CatError?
}

struct NotificationData :Codable {
    let notificationList: [NotificationList]?
}

struct NotificationList :Codable {
    let title, body, createdOn: String?
}

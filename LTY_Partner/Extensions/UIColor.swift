//
//  UIColor.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import Foundation
import UIKit

struct Color {
    
    static let lightBlue = UIColor(hexString: "#3A86FF")
    static let newsTitleColor = UIColor(hexString: "#f2f2f2")
    static let newsSubtitleColor = UIColor(hexString: "#bababa")
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}


//
//  CustomTextFiledExtension.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    var textPadding = UIEdgeInsets(
        top: 8,
        left: 10,
        bottom: 8,
        right: 10
    )
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

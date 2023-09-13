//
//  UILabelExtension.swift
//  LTY_Partner
//
//  Created by CTS on 18/05/23.
//

import Foundation
import UIKit

extension UILabel {
func makeTextMandatory() {
    let text = "\(self.text ?? "") *"
    let range = (text as NSString).range(of: " *")
    let attributedString = NSMutableAttributedString(string:text)
    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
    self.attributedText = attributedString
  }
}

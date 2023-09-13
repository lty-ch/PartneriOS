//
//  UIFontSize.swift
//  LTY_Partner
//
//  Created by CTS on 17/05/23.
//

import Foundation
import UIKit

struct FontSize {
    
    static let size12 = UIFont(name:"Helvetica",size:12)
    static let size14 = UIFont(name:"Helvetica",size:14)
    static let size16 = UIFont(name:"Helvetica",size:16)
    static let size28 = UIFont(name:"Helvetica",size:28)
    static let size20 =  UIFont(name:"Helvetica",size:20)
    static let size24 =  UIFont(name:"Helvetica",size:24)
    static let boldsize14 = UIFont(name:"Helvetica-Bold",size:14)
    static let boldsize32 = UIFont(name:"Helvetica-Bold",size:32)
}

struct DroverHeight {
    static let haveNotch = CGFloat(95)
    static let dontHaveNotch = CGFloat(60)

}


@IBDesignable
class CardView: UIView {
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1/2
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}



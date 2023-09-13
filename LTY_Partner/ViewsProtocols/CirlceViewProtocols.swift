//
//  CirlceViewProtocols.swift
//  LTY_Partner
//
//  Created by Chawtech on 30/05/23.
//

import UIKit

protocol ICircleViewDrawable {
    var circleBorderColor: UIColor { get set }
    var circleFilledColor: UIColor { get set }
    var circleRadius: CGFloat { get set }
    var circleBorderWidth: CGFloat { get set }
    
    func drawCircle()
}

protocol ITextCircleViewDrawable: ICircleViewDrawable {
    var text: String { get set }
    var textColor: UIColor? { get set }
    var textFont: UIFont { get set }
    
    func drawText()
}

protocol ILineDrawable {
    var lineBorderColor: UIColor? { get set }
    var lineBorderHeight: CGFloat { get set }
    var shouldShowLeftLine: Bool { get set }
    var shouldShowRightLine: Bool { get set }
    
    func drawLeftLine()
    func drawRightLine()
}

//
//  StepsViewContainer.swift
//  LTY_Partner
//
//  Created by Chawtech on 30/05/23.
//


import Foundation

public protocol StepViewContainer {
    var numberOfSteps: Int { get set }
    var selectedStep: Int { get set }
    
    func showNextStep()
    func showPreviousStep()
    func moveTo(step: Int)
}

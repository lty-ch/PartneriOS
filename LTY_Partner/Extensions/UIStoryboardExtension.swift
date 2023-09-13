//
//  UIStoryboardExtension.swift
//  LTY_Partner
//
//  Created by CTS on 17/05/23.
//

import Foundation

import UIKit

extension UIStoryboard{
    
    static func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func homeStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "HomeStoryboard", bundle: nil)
    }
    
    
}

enum AppStoryboard : String {
    
    case main = "Main"
    case home = "HomeStoryboard"
    case sideMenuStoryboard = "MenuStoryboard"
    case customerStoryboard = "Customer"
    case proposalStoryboard = "Proposals"
    case leadStoryboard = "LeadStoryboard"
    case ruleStoryboard = "RulesStoryboard"
    case submissionStoryboard = "SubmissionStoryboard"
    case chatStoryboard = "MessageStoryboard"
    case searchCoverStoryboard = "SearchCoverStoryboard"
    case agenda = "AgendaStoryboard"
    case Forms = "Forms"
    case newsLetter = "NewsLetter"
    



    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}




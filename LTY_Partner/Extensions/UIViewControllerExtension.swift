//
//  UIViewControllerExtension.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import Foundation
import UIKit

// ***** extension for alert

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func ShowAlert(message: String, title: String = LTY_AlterText.Alert.localized()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: LTY_AlterText.Ok.localized(), style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation extension
    func changeVC(item: Int) {
        DispatchQueue.main.async {
            self.tabBarController?.selectedIndex = item
        }
    }
    
    func popToRootVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func popToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    func popVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func pushToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func replaceWithVC(_ vc: UIViewController, animated: Bool, number: Int = 1) {
        DispatchQueue.main.async {
            if var viewControllers = self.navigationController?.viewControllers {
                viewControllers.removeLast(number)
                viewControllers.append(vc)
                self.navigationController?.setViewControllers(viewControllers, animated: animated)
            } else {
                self.navigationController?.pushViewController(vc, animated: animated)
            }
        }
    }
    
    func presentVC(_ vc: UIViewController, animated: Bool, presentationStyle: UIModalPresentationStyle) {
        DispatchQueue.main.async {
            vc.modalPresentationStyle = presentationStyle
            self.present(vc, animated: animated, completion: nil)
        }
    }
    
    func dismiss(animated: Bool) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var activeViewController: UIViewController {
        switch self {
        case let navigationController as UINavigationController:
            return navigationController.topViewController?.activeViewController ?? self
        case let tabBarController as UITabBarController:
            return tabBarController.selectedViewController?.activeViewController ?? self
        case let splitViewController as UISplitViewController:
            return splitViewController.viewControllers.last?.activeViewController ?? self
        default:
            return self
        }
    }
    
    var topMostViewController: UIViewController {
        let activeViewController = self.activeViewController
        return activeViewController.presentedViewController?.topMostViewController ?? activeViewController
    }
    
}

extension UIViewController {
    static var fromStoryboard: Self {
        let selfName = NSStringFromClass(self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: selfName, bundle: nil)
        let customViewController = storyboard.instantiateViewController(withIdentifier: selfName) as! Self
        
        return customViewController
    }
    
    func showOkAlert(_ msg: String) {
        let alert = UIAlertController(title:
                                        "LTY", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized(), style: .default, handler: nil)
        //        okAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showOkAlertWithHandler(_ msg: String,handler: @escaping ()->Void){
        let alert = UIAlertController(title: "Lty", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized(), style: .default) { (type) -> Void in
            handler()
        }
        //        okAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithActions( msg: String,titles:[String], handler:@escaping ( _ clickedIndex: Int) -> Void) {
        let alert = UIAlertController(title: "LTY", message: msg, preferredStyle: .alert)
        
        for title in titles {
            let action  = UIAlertAction(title: title, style: .default, handler: { (alertAction) in
                //Call back fall when user clicked
                
                let index = titles.firstIndex(of: alertAction.title!)
                if index != nil {
                    handler(index!+1)
                }
                else {
                    handler(0)
                }
            })
            //            action.setValue(AppColor.AppColor2, forKey: "titleTextColor")
            
            alert.addAction(action)
            
        }
        present(alert, animated: true, completion: nil)
    }
    
    func showOkCancelAlertWithAction( msg: String, handler:@escaping ( _ isOkAction: Bool) -> Void) {
        let alert = UIAlertController(title: "Craddle", message: msg, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "OK".localized(), style: .default) { (action) -> Void in
            return handler(true)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized().localized(), style: .cancel) { (action) -> Void in
            return handler(false)
        }
        //        cancelAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
        //        okAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func topMostController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController
    }
    
    //MARK:- show Toast
    
    
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
        toastLabel.backgroundColor = Asset.Colors.lightGray.color
        toastLabel.textColor = .white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func checkAccess(id:Int,useCaseArr:[RoleDetailList]?) -> (Bool,Bool,Bool){
        var haveReadAccess = false
        var haveWriteAccess = false
        var haveDeleteAccess = false
        for item in useCaseArr ?? [] {
            print(item.useCaseId)
            if item.useCaseId == id {
                for ite in item.permissionIds ?? [] {
                    if ite == 1 {
                        haveReadAccess = true
                    }
                    if ite == 2 {
                        haveWriteAccess = true
                    }
                    if ite == 3 {
                        haveDeleteAccess = true
                    }
                }
            }
        }
        return (haveReadAccess,haveWriteAccess,haveDeleteAccess)
    }

}

// this extension is used for back call on popup using completion

extension UINavigationController {
    func popViewControllerWithHandler(animated:Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(viewController: UIViewController, animated:Bool = true,  completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}

// to call this func using completion
/*
 navigationController?.popViewControllerWithHandler(animated: true, completion: {
 print("success")
 })
 
 */

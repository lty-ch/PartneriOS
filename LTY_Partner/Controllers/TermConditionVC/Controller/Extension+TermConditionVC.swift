//
//  Extension+TermConditionVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/09/23.
//

import Foundation
import UIKit

extension TermconditionVC : DeleteAccountProtocol{
  
    
    func setData(data: DeleteAccountModel) {
        if data.status == "SUCCESS" {
            let data = data.data
            DispatchQueue.main.async {
                if data?.isAccountClosed == true {
                    DispatchQueue.main.async {
                        self.setupAppropriateScreen()
                    }
                }else{
                    
                }
                
            }
        }
        else {
            DispatchQueue.main.async {
                if data.error?.errorCode == AppKeys.invalidTokenCode {
                    
                    LTY_AppDelegate.setRootVC()
                }else {
                    DispatchQueue.main.async {
                        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                        let result = language as! NSArray
                        
                        if result[0] as! String == "fr" {
                            self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")
                            
                        }else{
                            self.ShowAlert(message: data.error?.clientErrorMessage ?? "")
                            
                        }
                    }
                    
                }
            }
        }
    }
    func showMessage(message: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: message)
        }
    }
    
    
    func setupAppropriateScreen() {
        
        kUserDefaults.removeObject(forKey: AppKeys.state)
       // kUserDefaults.removeObject(forKey: AppKeys.token)
        kUserDefaults.set("Invalid", forKey: AppKeys.token)
        kUserDefaults.removeObject(forKey: AppKeys.email)
        kUserDefaults.removeObject(forKey: AppKeys.sourceId)
        kUserDefaults.removeObject(forKey: AppKeys.roleList)
        kUserDefaults.removeObject(forKey: AppKeys.password)
        kUserDefaults.removeObject(forKey: AppKeys.partnerID)
        kUserDefaults.removeObject(forKey: AppKeys.agentName)
        kUserDefaults.removeObject(forKey: AppKeys.totalNotification)
        
        let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        let nc = SwipeableNavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 13.0, *) {
            
            UIApplication.shared.windows.first?.rootViewController = nc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            let bounds = UIScreen.main.bounds
            LTY_AppDelegate.window = UIWindow(frame: bounds)
            LTY_AppDelegate.window?.rootViewController = nc
            LTY_AppDelegate.window?.makeKeyAndVisible()
        }
        
    }
}

//
//  AppDelegate+Helper.swift
//  LTY_Partner
//
//  Created by CTS on 23/05/23.
//

import Foundation
import FirebaseMessaging

import UIKit

extension AppDelegate {
    
    func checkToLoadScreen(){
        var token =  kUserDefaults.string(forKey: AppKeys.token)
        if token == nil{
            kUserDefaults.set(false, forKey: AppKeys.shouldActivateFaceId)
            
            L102Language.setAppleLAnguageTo(lang: "fr")
            change(selectedLanguage: "fr")
            
            switchWelcomeScreen()
        }
        else{
            if token != "Invalid" {
                kUserDefaults.set(true, forKey: AppKeys.shouldActivateFaceId)
                switchHomescreen()
            }else {
                kUserDefaults.set(false, forKey: AppKeys.shouldActivateFaceId)
                switchLoginScreen()
                
            }
        }
    }
    //MARK:- Home Screen
    func switchHomescreen() {
        
        let vc = HomeVC.instantiate(fromAppStoryboard:.home)
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
        
        
        
    }
    
  


    
    func change(selectedLanguage: String){
        L102Language.setAppleLAnguageTo(lang: selectedLanguage)
//        if L102Language.currentAppleLanguage() == "en" {
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        } else {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        }
        Bundle.setLanguage(selectedLanguage)
    }
    
    //MARK:- Login Screen
    func switchLoginScreen() {
        
        //let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        let vc = WelcomeScreenVC.instantiate(fromAppStoryboard: .main)
        // vc.selectedIndex = selectedIndex ?? 0
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            self.window?.rootViewController = vc
        }
    }
    
    //MARK:- Login Screen
    func switchWelcomeScreen() {
        
        //let vc = LoginVC.instantiate(fromAppStoryboard:.main)
        let vc = WelcomeScreenVC.instantiate(fromAppStoryboard:.main)
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
    }
    func switchToHomeVC() {
        
        let vc = TabBarController.instantiate(fromAppStoryboard: .home)
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            self.window?.rootViewController = vc
        }
    }
    
    func setRootVC() {
        
        
        kUserDefaults.removeObject(forKey: AppKeys.state)
        kUserDefaults.removeObject(forKey: AppKeys.token)
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


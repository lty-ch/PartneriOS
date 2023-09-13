//
//  Extension+SelectLanguage.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import Foundation
import UIKit

extension SelectLanguageVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectLang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(SelectLanguageTVC.self, for: indexPath)
        
        cell.selectionStyle = .none
        let name = selectLang[indexPath.row]
        cell.labelLanguageName.text = name.languageName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func switchToTab() {
        let vc = TabBarController.instantiate(fromAppStoryboard: .home)
    
       // vc.selectedIndex = selectedIndex ?? 0
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            LTY_AppDelegate.window?.rootViewController = vc
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  indexPath.row == 0 {
            
            L102Language.setAppleLAnguageTo(lang: "fr")
            change(selectedLanguage: "fr")
            
            
            self.dismiss(animated: false) {
                if self.isComingFrom == "HOMEVC" {
                    self.switchToTab()
                }else{
                    self.delegate?.dismissScreen(setValue: true)
                }
            }
        } else if indexPath.row == 1 {
            L102Language.setAppleLAnguageTo(lang: "en")
            change(selectedLanguage: "en")
 
            
            self.dismiss(animated: false) {
                if self.isComingFrom == "HOMEVC" {
                    self.switchToTab()
                }else{
                    self.delegate?.dismissScreen(setValue: true)
                }
            }
        }
        /*
        else if indexPath.row == 2 {
            
            L102Language.setAppleLAnguageTo(lang: "it")
            change(selectedLanguage: "it")
 
            
            self.dismiss(animated: false) {
                if self.isComingFrom == "HOMEVC" {
                    self.switchToTab()
                }else{
                    self.delegate?.dismissScreen(setValue: true)
                }
            }
        }
         */
        else {
            L102Language.setAppleLAnguageTo(lang: "en")
            change(selectedLanguage: "en")
 
            
            self.dismiss(animated: false) {
                if self.isComingFrom == "HOMEVC" {
                    self.switchToTab()
                }else{
                    self.delegate?.dismissScreen(setValue: true)
                }
            }
        }
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
    
}


let APPLE_LANGUAGE_KEY = "AppleLanguages"

class L102Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        var currentWithoutLocale = "Base"
        if let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? [String] {
            if var current = langArray.first {
                if let range = current.range(of: "-") {
                    current = String(current[..<range.lowerBound])
                }
                
                currentWithoutLocale = current
            }
        }
        return currentWithoutLocale
    }
    
    class func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }

    class var isRTL: Bool {
        return L102Language.currentAppleLanguage() == "en"
        return L102Language.currentAppleLanguage() == "fr"
        return L102Language.currentAppleLanguage() == "it"
  
    }
}


extension Bundle {
    
    class func setLanguage(_ language: String) {
        
        defer {
            
            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
    
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
              let bundle = Bundle(path: path) else {
            
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}




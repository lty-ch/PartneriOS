//
//  PrivacyPolicyVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 13/09/23.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPrivacyUrl()
        setDrowerHeight() 
        customNavDrower.titleLabel.text = "Privacy Policy".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    func callPrivacyUrl() {
   
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        var poliyUrl = ""
    https://lty.ch/privacy-policy/
        if result[0] as! String == "fr" {
            poliyUrl = "https://lty.ch/privacy-policy/"
        }else{
            poliyUrl = "https://lty.ch/privacy-policy/"
        }
     
        let url : NSString = poliyUrl as NSString
       let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
       let searchURL : NSURL = NSURL(string: urlStr as String)!
       
       let requestObj = URLRequest(url: searchURL as URL)
       myWebView.load(requestObj)
       
   }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
}

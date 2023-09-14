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
        customNavDrower.titleLabel.text = "Privacy Policy".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
     func callPrivacyUrl() {
        
        let url : NSString = "https://ltypartnerprod.chawtechsolutions.ch/privacy-policy"
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

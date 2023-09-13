//
//  LetsLoginVC.swift
//  LTY_Partner
//
//  Created by CTS on 09/06/23.
//

import UIKit

class LetsLoginVC: UIViewController {

    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDrowerHeight()
        customNavDrower.titleLabel.text = " Let's Login"
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let param:[String:Any] = ["leadId":leadId]
//        leadInsuranceViewModel.insuranceApiCall(param: param)
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

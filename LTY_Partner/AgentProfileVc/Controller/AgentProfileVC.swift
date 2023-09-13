//
//  AgentProfileVC.swift
//  LTY_Partner
//
//  Created by CTS on 01/06/23.
//

import UIKit

class AgentProfileVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAgentSubTitle: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    //MARK:- Comp outlets
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblUSerType: UILabel!
    @IBOutlet weak var lblPostCode: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    
    //MARK:- Company Outlets
    
    @IBOutlet weak var lblCompPO: UILabel!
    @IBOutlet weak var lblCompCity: UILabel!
    @IBOutlet weak var lblCompName: UILabel!
    @IBOutlet weak var lblCompState: UILabel!
    @IBOutlet weak var lblPrivateOP: UILabel!
    @IBOutlet weak var lblCompFinam: UILabel!
    @IBOutlet weak var lblCompEmail: UILabel!
    @IBOutlet weak var lblCompMobile: UILabel!
    @IBOutlet weak var lblCompCountry: UILabel!
    @IBOutlet weak var lblCompCirceo: UILabel!
    @IBOutlet weak var lblCompWebsite: UILabel!
    @IBOutlet weak var lblCompAddress: UILabel!
    @IBOutlet weak var lblCompPostCode: UILabel!
    @IBOutlet weak var lblCompCriminalRecord: UILabel!
 
    //MARK:- Bnak Outlets
    
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var lblIBAN: UILabel!
    @IBOutlet weak var lblSwiftBIC: UILabel!
    @IBOutlet weak var lblBankCountry: UILabel!
    @IBOutlet weak var lblBankAddress: UILabel!
    @IBOutlet weak var lblBAnkPostCode: UILabel!
    @IBOutlet weak var lblBankCity: UILabel!
    @IBOutlet weak var lblBankSate: UILabel!
    
    //MARK:- Variables
      var agentId  = ""
     var agentProfileViewModel = AgentProfileViewModel()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        agentProfileViewModel.delegate = self
        customNavDrower.titleLabel.text = "Profile".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
     
        let partnerId = kUserDefaults.value(forKey: "partnerID")
        let params :[String:Any] = ["entityId":agentId,"entityType":"PARTNER_ID"]
        agentProfileViewModel.getAgentProfile(params:params )

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
    
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }

}

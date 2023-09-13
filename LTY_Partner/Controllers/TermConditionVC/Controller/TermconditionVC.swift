//
//  TermconditionVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/09/23.
//

import UIKit

class TermconditionVC: UIViewController {

    @IBOutlet weak var lblTitle1: UILabel!
    
    @IBOutlet weak var lblTitle2: UILabel!
    
    @IBOutlet weak var lblTitle3: UILabel!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var btnDeleteAccount: UIButton!
    @IBOutlet weak var lblTitleReason: UILabel!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
   
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    
   var deleteAccountViewModel = DeleteAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        setLocalization()
        deleteAccountViewModel.delegate = self
        
        customNavDrower.titleLabel.text = "Term and Conditions".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

    }
    
    func setLocalization(){
        lblTitle1.text = "We are sorry to see you go!".localized()
       // lblTitle2.text = ""
        lblTitle3.text = "• You acknowledge that you have read our".localized()
        lblTitleReason.text = "Reason for deactivating your account ?".localized()
        btnDeleteAccount.setTitle("Delete Account".localized(), for: .normal)
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

    func checkValidation (){
        
        if reasonTextView.text.isEmpty == true{
            self.ShowAlert(message: "Please enter Reason first".localized())
            return
        }
        
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        
        if usertype as! String == "PARTNER"{
            
            let param : [String:Any] = [ "entityId": PartnerId,
                                         "entityType": "PARTNER_ID",
                                         "deleteReason": reasonTextView.text]
            deleteAccountViewModel.DeleteAccountApiCall(param: param)
        }else{
            
            let param : [String:Any] = [ "entityId": PartnerId,
                                         "entityType": "AGENT_ID",
                                         "deleteReason": reasonTextView.text]
            deleteAccountViewModel.DeleteAccountApiCall(param: param)
        }
        
    }

    @IBAction func btnDeleteAction(_ sender: UIButton) {
        checkValidation ()
    }
    
}

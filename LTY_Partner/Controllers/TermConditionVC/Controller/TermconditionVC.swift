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
        btnDeleteAccount.viewCorner(8)
        customNavDrower.titleLabel.text = "Term and Conditions".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

    }
    
    func setLocalization(){
        lblTitle1.text = "We are sorry to see you go!".localized()
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            lblTitle2.text = """
        Veuillez noter qu'une fois que vous aurez choisi de désactiver ou de supprimer votre compte chez LTY, votre compte ne sera plus disponible et vous ne pourrez plus l'activer ou l'utiliser.

        Suppression de compte :

        Si vous souhaitez procéder à une demande de suppression de compte, veuillez vous assurer d'avoir lu et compris ce qui suit :

        Il ne devrait y avoir aucune réclamation d’assurance en attente, aucune annulation de police, aucun remboursement ou autre demande en attente associée à votre compte.
        Vous avez épuisé ou n'avez pas l'intention d'utiliser les points de fidélité, récompenses ou bonus associés à votre compte. Veuillez noter qu'une fois votre compte supprimé, vous ne pourrez plus accéder à de telles récompenses.
        Vous ne pourrez pas accéder ou demander l'accès à l'historique de vos polices d'assurance, à votre historique de réclamations, à vos polices enregistrées, à vos méthodes de paiement enregistrées, ni utiliser l'un des services proposés par LTY. Vous devrez créer un nouveau compte si vous souhaitez utiliser nos services à l'avenir.
        LTY se réserve le droit de refuser la suppression de votre compte si vous avez des obligations financières impayées, des réclamations d'assurance non résolues ou d'autres problèmes liés à votre compte.
        En procédant à la suppression du compte, vous reconnaissez avoir lu et compris notre Politique de confidentialité.
        """
        }
        else {
            
            lblTitle2.text = """
        Please note that once you choose to deactivate or delete your account with LTY, your account will no longer be available to you, and you will not be able to activate or use the account again.
        
        Account Deletion:

        If you wish to proceed with an account deletion request, please ensure that you have read and understood the following:

        There should be no pending insurance claims, policy cancellations, refunds, or other pending requests associated with your account.
        You have exhausted or do not intend to use any loyalty points, rewards, or bonuses associated with your account. Please note that once your account is deleted, you will not be able to access any such rewards.
        You will not be able to access or request access to your insurance policy history, claims history, saved policies, saved payment methods, or use any of the services offered by LTY. You will need to create a new account if you wish to use our services in the future.
        LTY reserves the right to refuse the deletion of your account if you have any outstanding financial obligations, unresolved insurance claims, or other issues related to your account.
        By proceeding with the account deletion, you acknowledge that you have read and understood our Privacy Policy.
"""
        }
        
        lblTitleReason.text = "Reason for deactivating your account?".localized()
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

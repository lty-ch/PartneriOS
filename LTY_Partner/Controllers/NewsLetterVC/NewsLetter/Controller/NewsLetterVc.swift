//
//  NewsLetterVc.swift
//  LTY_Partner
//
//  Created by Chawtech on 09/08/23.
//

import UIKit

class NewsLetterVc: UIViewController {
    
    @IBOutlet weak var lblTemplateTitle: UILabel!
    @IBOutlet weak var lblNewsLatterTitle: UILabel!
    @IBOutlet weak var lblTotalTemplate: UILabel!
    @IBOutlet weak var lblTotalSubscriber: UILabel!
    @IBOutlet weak var btnAddNewTemp: UIButton!
    @IBOutlet weak var btnSendNewsLetter: UIButton!
    @IBOutlet weak var AddNewTemplateView: UIView!
    @IBOutlet weak var sendNewsLetterView: UIView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddNewTemplateView.viewCorner(6)
        sendNewsLetterView.viewCorner(6)
        btnAddNewTemp.viewCorner(6)
        btnSendNewsLetter.viewCorner(6)
        setDrowerHeight()
        customNavDrower.titleLabel.text = "News Letter".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        steUpLocaliztion()
    }
    
    func steUpLocaliztion(){
        lblTotalTemplate.text = "Number of template".localized()
        lblTotalSubscriber.text = "Total subscriber".localized()
        btnAddNewTemp.setTitle("   Add new Template   ".localized(), for: .normal)
        btnSendNewsLetter.setTitle("   Send Newsletter   ".localized(), for: .normal)
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
    @IBAction func sendNewLetterActionBtn(_ sender: UIButton) {
        let vc = ShowUserListVC.instantiate(fromAppStoryboard: .newsLetter)
        pushToVC(vc, animated: true)
    }
    
    @IBAction func addNewTemplateActionBtn(_ sender: UIButton) {
        
        let vc = SendNewsLetterVC.instantiate(fromAppStoryboard: .newsLetter)
        pushToVC(vc, animated: true)
    }
    
}

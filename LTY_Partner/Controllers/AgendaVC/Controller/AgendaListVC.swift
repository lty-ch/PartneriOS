//
//  AgendaListVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import UIKit

class AgendaListVC: UIViewController {
    
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var agendaTableView: UITableView!

    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var agendaViewModel = AgendaViewModel()
    var agendaListArr = [AgendaList]()
    
    
    override func viewDidLoad() {
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        agendaViewModel.delegate = self
        
        
        setDrowerHeight()
        SetUpView()

        ApiCallingFunc ()
    }
    
    func ApiCallingFunc () {
        
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let param :[String:Any] = [ "entityType": entityType, "entityId": partnerID, "pageSize": 25, "pageCount": 1]
        agendaViewModel.agendaListApi(param: param)
        
    }
    //MARK:- SetUpView
    
    func SetUpView() {
   
        customNavDrower.titleLabel.text = "Agenda".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    @IBAction func btnAddAgendaAction(_ sender: UIButton) {
        let vc = AddNewAgendaVC.instantiate(fromAppStoryboard: .agenda)
        vc.reloadAgendaListDelegate = self
        pushToVC(vc, animated: true)
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

extension AgendaListVC: ReloadAgendaListDelegate {
    func reloadAgendaList(setValue: String) {
        if setValue == "done"{
            ApiCallingFunc()
        }
    }
}

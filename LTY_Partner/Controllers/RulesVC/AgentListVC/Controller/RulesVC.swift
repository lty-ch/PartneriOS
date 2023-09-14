//
//  RulesVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import UIKit

class RulesVC: UIViewController {
    
    @IBOutlet weak var lblAddNewRole: UILabel!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var rolesTableView: UITableView!
    @IBOutlet weak var lblAgentList: UILabel!
    @IBOutlet weak var viewAgentList: UIView!
    @IBOutlet weak var lblUserRules: UILabel!
    @IBOutlet weak var viewUserRules: UIView!
    @IBOutlet weak var agentListTableView: UITableView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var rolesVM = RolesViewModel()
    var rolesArr = [rolesList]()
    var agentListArr = [AgentListRoleList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agentListTableView.delegate = self
        agentListTableView.dataSource = self
        rolesTableView.delegate = self
        rolesTableView.dataSource = self
        
        setDrowerHeight()
        
        lblAddNewRole.text = "Add new role +".localized()
        customNavDrower.titleLabel.text = "Roles & access".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        rolesVM.delegate = self
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let param:[String:Any] = ["partnerId":partnerId]
        rolesVM.getRolesApi(param: param)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        
        viewUserRules.backgroundColor = Asset.Colors.blueColor.color
        viewAgentList.backgroundColor = Asset.Colors.grayColor.color
        lblAgentList.textColor = .black
        lblUserRules.textColor = .white
        
        lblAgentList.text = "Agent List".localized()
        lblUserRules.text = "Agent Roles".localized()
        lblAddNewRole.text = "Add new role +".localized()
        
        agentListTableView.isHidden = true
        rolesTableView.isHidden = false

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
        }
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    @IBAction func btnUserRulesAction(_ sender: UIButton) {
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let param:[String:Any] = ["partnerId":partnerId]
        rolesVM.getRolesApi(param: param)
        viewUserRules.backgroundColor = Asset.Colors.blueColor.color
        viewAgentList.backgroundColor = Asset.Colors.grayColor.color
        lblAgentList.textColor = .black
        lblUserRules.textColor = .white
        agentListTableView.isHidden = true
        rolesTableView.isHidden = false
    }
    
    @IBAction func btnAgentListAction(_ sender: UIButton) {
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let param:[String:Any] = ["partnerId":partnerId]
        rolesVM.getAgentRolesListApi(param: param)
        viewAgentList.backgroundColor = Asset.Colors.blueColor.color
        viewUserRules.backgroundColor = Asset.Colors.grayColor.color
        lblUserRules.textColor = .black
        lblAgentList.textColor = .white
        agentListTableView.isHidden = false
        rolesTableView.isHidden = true
    }
    
    @IBAction func onClickAddNew(_ sender: UIButton) {
        let vc = AddRoleVC.instantiate(fromAppStoryboard: .ruleStoryboard)
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
}

extension RulesVC: RolesListProtocolDelegate, RoleAddedCallback, AgentAssignedCallback {
    
    func setAssignedData() {
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let param:[String:Any] = ["partnerId":partnerId]
        self.rolesVM.getAgentRolesListApi(param: param)
    }
    
    
    func setAddRoleData() {
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let param:[String:Any] = ["partnerId":partnerId]
        self.rolesVM.getRolesApi(param: param)
    }
    
    
    func setDeleteRoleData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
                let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                let param:[String:Any] = ["partnerId":partnerId]
                self.rolesVM.getRolesApi(param: param)
            }
        }
        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
        
    }
    
    
    func setAgentRolesList(data: AgentListRoleModel) {
        
        self.agentListArr.removeAll()
        if data.status == "SUCCESS" {
            self.agentListArr = data.data?.usersList ?? []
            if agentListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.agentListTableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                }
            } else {
                DispatchQueue.main.async {
                    self.agentListTableView.isHidden = false
                    self.noDataFoundView.isHidden = true
                    self.agentListTableView.reloadData()
                }
            }
            
        }
        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
        
    }
    
    
    func setRolesList(data: RolesModel) {
        
        self.rolesArr.removeAll()
        if data.status == "SUCCESS" {
            self.rolesArr = data.data?.rolesList ?? []
            if rolesArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.rolesTableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                }
            } else {
                DispatchQueue.main.async {
                    self.rolesTableView.isHidden = false
                    self.noDataFoundView.isHidden = true
                    self.rolesTableView.reloadData()
                }
            }
            
        }
        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
        
    }
    
    func popupMsg(msg: String) {
        ShowAlert(message: msg)
    }
    

}

//
//  LeadProposalsVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 13/06/23.
//

import UIKit

class LeadProposalsVC: UIViewController {
      
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sendProposalsBottomView: UIView!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    var leadId = ""
    var leadProposalViewModel = LeadProposalViewModel()
    var proposalsArr = [LeadProposalsList]()
    var insurnceType = ""
    var agentName = ""
    var agentId = ""
    var status = ""
    var proposalIdArr = [String]()
    
    var categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    var categoryListNewData = [MainCategoryNewList]()
    var isCategoryAdded = false
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leadProposalViewModel.delegate = self
        
        leadProposalViewModel.sendLeadProposalDelegate = self
        leadProposalViewModel.sendMultipleProposalDelegate = self
        
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Send Proposals".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        collectionView.register(UINib(nibName: "LeadProposalCollectionCell", bundle: .main), forCellWithReuseIdentifier: "LeadProposalCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.status == "CLOSED" || self.status == "ACCEPTED"{
            self.sendProposalsBottomView.isHidden = true
            self.bottomViewHeight.constant = 0
        }
        self.tabBarController?.tabBar.isHidden = true
        let param:[String:Any] = ["leadId":self.leadId]
        leadProposalViewModel.leadProposalApi(param: param)
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
    
    @IBAction func onClickAddProposal(_ sender: UIButton) {
        
        categoryViewModel.delegate = self
        categoryViewModel.categoryListByAgentDelegate = self
        dispatchGroup.enter()
        if self.agentId == "" {
            let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
            let param :[String:Any]  = ["partnerId":PartnerId]
            categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)
        } else {
            let param :[String:Any]  = ["agentId":self.agentId]
            categoryViewModel.getCatByAgent(param: param, url: LTY_END_POINT_URL.getCategoryByAgent)
        }
        
        
        dispatchGroup.notify(queue: .main) {
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            if !self.isCategoryAdded {
                if userType == "PARTNER"{
                    self.showAlertWithActions(msg: "Please add category commission of the agent.", titles: ["Yes", "Not Now"]) { (value) in
                        if value == 1{
                            let vc = AgentVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                            self.pushToVC(vc, animated: true)
                        }
                    }
                }else{
                    self.showOkAlertWithHandler("Please contact your partner") {
                        self.popVC(animated: true)
                    }
                }


                return
            }
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
               // vc.isComingFrom = "LeadProposalVC"
                vc.shouldAddLead = true
                vc.leadId = self.leadId
                vc.insurnceType = self.insurnceType
                vc.agentId = self.agentId
                vc.agentName = self.agentName
                shouldEditMembers = false
                UserDefaults.standard.set("yes", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

            let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
         //   let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

            if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER" {
           
                
                let vc = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
               // vc.isComingFrom = "LeadProposalVC"
                vc.shouldAddLead = true
                vc.leadId = self.leadId
                vc.insurnceType = self.insurnceType
                vc.agentId = self.agentId
                vc.agentName = self.agentName
                shouldEditMembers = false
                UserDefaults.standard.set("yes", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
            }
            else{
                self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
                
            }

            
        }
        

    }
    
    @IBAction func onClickSendAllProposal(_ sender: UIButton) {
        
        guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
            if self.proposalIdArr.count == 0 {
                self.showOkAlert("You have no proposals saved to send.".localized())
            } else {
                let params:[String: Any] = ["proposalIds": self.proposalIdArr]
                leadProposalViewModel.sendMultipleProposalApi(param: params)
            }
            return
        }

        let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

        let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

        if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
        
            if self.proposalIdArr.count == 0 {
                self.showOkAlert("You have no proposals saved to send.".localized())
            } else {
                let params:[String: Any] = ["proposalIds": self.proposalIdArr]
                leadProposalViewModel.sendMultipleProposalApi(param: params)
            }
        }
        else{
            self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
            
        }

    }
    
    
    @IBAction func editActions(_ sender: UIButton) {
        
        let indexPath: IndexPath? = tableView.indexPathForRow(at: (sender as AnyObject).convert(CGPoint.zero, to: tableView))
        let info = self.proposalsArr[indexPath!.row]
        
        if sender.tag == 101 || sender.tag == 102 {
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.proposalId = self.proposalsArr[indexPath!.row].proposalId ?? ""
                vc.leadId = self.leadId
                vc.fromWhichVC = sender.tag == 101 ? "LeadProposalVC" : "ForEditProposal"
                UserDefaults.standard.set(sender.tag == 102 ? "yes" : "no", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

            let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

            if (checkAccess.1 && userType == "AGENT" && sender.tag == 102) || (userType == "PARTNER")  || (checkAccess.0 && userType == "AGENT" && sender.tag == 101){
           
                
                let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.proposalId = self.proposalsArr[indexPath!.row].proposalId ?? ""
                vc.leadId = self.leadId
                vc.fromWhichVC = sender.tag == 101 ? "LeadProposalVC" : "ForEditProposal"
                UserDefaults.standard.set(sender.tag == 102 ? "yes" : "no", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
            }
            else{
                if sender.tag == 101 {
                    self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                }else{
                    self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
                }
                
                
            }
 
        } else if sender.tag == 103 {
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                self.showAlertWithActions(msg: "Are you sure you want to delete this Proposal ?".localized(), titles: ["Yes".localized(), "No".localized()]) { (value) in
                    if value == 1{
                  
                        let params:[String: Any] = ["proposalIds": [info.proposalId]]
                        self.leadProposalViewModel.deleteProposalApi(param: params)
                    }
                }
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

            let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

            if (checkAccess.2 && userType == "AGENT") || userType == "PARTNER"{ 
                self.showAlertWithActions(msg: "Are you sure you want to delete this Proposal ?".localized(), titles: ["Yes".localized(), "No".localized()]) { (value) in
                    if value == 1{
                  
                        let params:[String: Any] = ["proposalIds": [info.proposalId]]
                        self.leadProposalViewModel.deleteProposalApi(param: params)
                    }
                }
            }
            else{
                self.ShowAlert(message: LTY_AlterText.messageNoDeleteAccess.localized())
                
            }
            
            
         
        } else {
            let params:[String: Any] = ["proposalId": info.proposalId ?? "", "partnerId": info.partnerId ?? "", "proposalState": "OFFER_CREATED", "signedDoc": []]
            print(params)
            leadProposalViewModel.sendLeadProposalApi(param: params)
        }
    }
    
    
}

extension LeadProposalsVC : LeadProposalDelegate, SendLeadProposalDelegate,SendMultipleProposalDelegate {
    
    func setMultipleProposalData(data: SuccessModel, from: String) {
        if data.status == "SUCCESS"{
            if from == "SendMultipleLead" {
                DispatchQueue.main.async {
                    self.ShowAlert(message: "Proposal sent successfully.".localized())
                }
                
            }
            let param:[String:Any] = ["leadId":self.leadId]
            leadProposalViewModel.leadProposalApi(param: param)

        }else{
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
    
    func showMultipleProposalMessage(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
    func setLeadData(data: SuccessModel, from: String) {
        if data.status == "SUCCESS"{
            if from == "DeleteLead" {
                DispatchQueue.main.async {
                    self.ShowAlert(message: "Proposal deleted successfully.".localized())
                }
                
            } else {
                DispatchQueue.main.async {
                    self.ShowAlert(message: "Proposal sent successfully.".localized())
                }
                
            }
            let param:[String:Any] = ["leadId":self.leadId]
            leadProposalViewModel.leadProposalApi(param: param)

        }else{
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
    
    func showLeadMessage(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
    
    func createProposalIdArr(_ arr: [LeadProposalsList]) {
        for i in 0..<arr.count {
            if arr[i].proposalState == "PROPOSAL_SAVED" {
                self.proposalIdArr.append(arr[i].proposalId ?? "")
            }
        }
    }
    
    func setData(data: LeadProposalModel) {
        if data.status == "SUCCESS"{
            self.proposalsArr.removeAll()
            self.proposalIdArr.removeAll()
            self.createProposalIdArr(data.data?.proposalsList ?? [])
            self.proposalsArr = data.data?.proposalsList ?? []
            let basicInfo = data.data?.proposalsList


            DispatchQueue.main.async {
                if self.proposalsArr.count != 0 {
                    self.emptyView.isHidden = true
                    self.collectionView.isHidden = false

                    self.collectionView.reloadData()
                }else {
                    self.emptyView.isHidden = false
                    self.collectionView.isHidden = true
                }
                

            }
        }else{
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
    
    func showMessage(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
    
}

extension LeadProposalsVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
    func setCategoryListByAgent(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListNewData.removeAll()

            self.categoryListNewData = data.data?.categoryList ?? []
            self.isCategoryAdded = self.categoryListNewData.count > 0 ? true : false
            
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
        
        dispatchGroup.leave()
      
    }
   
    func setCategoryList(data: CategoryModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()

            self.categoryListData = data.data?.categoryList ?? []
            self.isCategoryAdded = self.categoryListData.count > 0 ? true : false
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
        dispatchGroup.leave()
      
    }
    
    
    func setCategoryNewList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()

            self.categoryListNewData = data.data?.categoryList ?? []
            self.isCategoryAdded = self.categoryListNewData.count > 0 ? true : false
            
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
        dispatchGroup.leave()
      
    }
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
        
    }
    
//    func setActiveUsersList(data: AddProposalMembersModel) {
//
//        if data.status == "SUCCESS" {
//
//
//            var memberList = data.data?.usersList ?? []
//            if memberList.count == 0 {
//                self.showOkAlert("This Agent does not have members associated. You can't proceed with proposal creation. Please select any other Agent.")
//            }
//
//        } else {
//            DispatchQueue.main.async {
//                  if data.error?.errorCode == AppKeys.invalidTokenCode {
//
//                      LTY_AppDelegate.setRootVC()
//                  }else {
//                      self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
//                  }
//              }
//          }
//    }
    
    
}

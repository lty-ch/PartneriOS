//
//  MemberVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 30/05/23.
//

import UIKit

class ProposalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var personalizedView: UIView!
    @IBOutlet weak var btnPersonlazied: UIButton!
    @IBOutlet weak var btnGeneralized: UIButton!
    @IBOutlet weak var genralizedView: UIView!
    @IBOutlet weak var btnAddProposal: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var searchCloseBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var lblAllProposal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    var categoryListNewData = [MainCategoryNewList]()
    var isCustomerAdded = false
    var isCategoryAdded = false
    var AddProposalVM = AddProposalViewModel()
    let dispatchGroup = DispatchGroup()
    
    var proposalVM = ProposalViewModel()
    var proposalListArr = [ProposalsList]()
    var AllProposalArr = ["ALL PROPOSAL".localized(),"ACCEPTED".localized(),"PENDING".localized(),"REJECTED".localized(),"POLICY CREATED".localized()]
    var offerType = "GENERALIZED"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchTf.delegate = self
        
        self.lblAllProposal.text = "All Proposal".localized()
        proposalVM.delegate = self
        btnAddProposal.setTitle("Add Proposal".localized(), for: .normal)
        btnGeneralized.setTitle("Generalized".localized(), for: .normal)
        btnPersonlazied.setTitle("Personalized".localized(), for: .normal)
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Proposal".localized()
        genralizedView.backgroundColor = Asset.Colors.blueColor.color
        btnGeneralized.setTitleColor(.white, for: .normal)
     
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        categoryViewModel.delegate = self
        categoryViewModel.categoryListByAgentDelegate = self
        AddProposalVM.activeUsersDelegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        self.ApiCallingFunc(state: "", offerType: self.offerType)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
    
    
  //MARK:- Api call func
    
    func ApiCallingFunc(state:String, offerType:String) {
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
        let param:[String: Any] = ["entityType": entityType,"entityId": partnerId, "proposalState": state, "pageSize": 50, "pageCount": 1, "offerType": offerType]
        proposalVM.proposalListApi(param: param)
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
    
    @IBAction func onClickSearch(_ sender: UIButton) {
                
        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            //self.searchView.isHidden = false
            self.searchCloseBtn.isHidden = false
            self.searchBtn.isHidden = true
//            self.viewHeaderBar.isHidden = false

//            self.consSearchViewWidth.constant = 0

            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func onClickSearchClose(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) {
           // self.searchBtn.setImage(UIImage.init(named: "search"), for: .normal)
            //self.searchView.isHidden = true
            self.searchCloseBtn.isHidden = true
            self.searchBtn.isHidden = false


            self.view.layoutIfNeeded()
        }

    }
    
    
    @IBAction func onClickAllProposal(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in AllProposalArr {
            
            let action = UIAlertAction(title: cat, style: .default) { (action) in
                self.lblAllProposal.text = cat
                
                if cat == "ALL PROPOSAL".localized(){
                    self.ApiCallingFunc(state: "", offerType: self.offerType)
                } else if cat == "PENDING".localized(){
                    self.ApiCallingFunc(state: "OFFER_CREATED", offerType: self.offerType)
                }
                else if cat == "POLICY CREATED".localized(){
                    self.ApiCallingFunc(state: "POLICY_CREATED", offerType: self.offerType)
                }else {
                    self.ApiCallingFunc(state: cat, offerType: self.offerType)
                }
               
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickAddProposal(_ sender: UIButton) {
        
        
        dispatchGroup.enter()
        let agentId = addProposalDic.value(forKey: "agentId") ?? ""
        let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId) ?? ""
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
//        let param: [String: Any] = ["agentId": agentId,"partnerId": partnerId, "searchBy": ""]
                
        if userType as! String == "AGENT"{
                        
            let param: [String: Any] = ["agentId": partnerId,"partnerId": sourceId, "searchBy": ""]
            AddProposalVM.getActiveUsers(param: param)

        }else{
            let param: [String: Any] = ["agentId": "","partnerId": partnerId, "searchBy": ""]
            AddProposalVM.getActiveUsers(param: param)

        }
        
        
//        dispatchGroup.leave()
        
        dispatchGroup.enter()
        self.checkIfCustomerIsAdded()
        
        
       
        
        dispatchGroup.notify(queue: .main) {
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
           
                if !self.isCategoryAdded {
                    if userType == "PARTNER"{
                        self.showAlertWithActions(msg: "Please add Category first.".localized(), titles: ["Yes".localized(), "Not Now".localized()]) { (value) in
                            if value == 1{
                                let vc = CategoryVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                                self.pushToVC(vc, animated: true)
                            }
                        }
                    }else{
                        self.showOkAlertWithHandler("Please contact your partner".localized()) {
                            self.popVC(animated: true)
                        }
                    }
                    
                    return
                }
        
            if !self.isCustomerAdded {
                self.showAlertWithActions(msg: "Please add Customer first.".localized(), titles: ["Yes".localized(), "Not Now".localized()]) { (value) in
                    if value == 1{
                        let vc = CustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
                        self.pushToVC(vc, animated: true)
                    }
                }
//                self.showOkAlertWithHandler("Please add Customer first.") {
//                    self.popVC(animated: true)
//                }

                return
            }
            
            
            if self.isCustomerAdded && self.isCategoryAdded {
                guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                    let vc = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
        //            vc.agentId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
                    vc.agentName = kUserDefaults.value(forKey: AppKeys.agentName)as! String
                    shouldEditMembers = true
                    UserDefaults.standard.set("no", forKey: "fromLead")
                    self.pushToVC(vc, animated: true)
                    return
                }

                let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
                let checkAccess = self.checkAccess(id: 2, useCaseArr: userRole?.useCasesList)
                let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

                if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
                    let vc = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
                    vc.agentId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
                    vc.agentName = kUserDefaults.value(forKey: AppKeys.agentName)as! String
                    shouldEditMembers = true
                    UserDefaults.standard.set("no", forKey: "fromLead")
                    self.pushToVC(vc, animated: true)

                } else {
                    self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())

                }
            }
            
        }



 
    }
    
    func checkIfCustomerIsAdded() {
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        
        if userType as! String == "AGENT"{
                        
            let param :[String:Any]  = ["agentId":PartnerId]
            categoryViewModel.getCatByAgent(param: param, url: LTY_END_POINT_URL.getCategoryByAgent)

        }else{
            let param :[String:Any]  = ["partnerId":PartnerId]
            categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)

        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended writing")
    }

    @IBAction func btnPersonalizedaction(_ sender: UIButton) {
        genralizedView.backgroundColor = Asset.Colors.grayColor.color
        personalizedView.backgroundColor = Asset.Colors.blueColor.color
        btnGeneralized.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        btnPersonlazied.setTitleColor(.white, for: .normal)
        self.offerType = "PERSONALIZED"
        self.ApiCallingFunc(state: "", offerType: self.offerType)
    }
    
    @IBAction func btnGeneralizedAction(_ sender: UIButton) {
        
        genralizedView.backgroundColor = Asset.Colors.blueColor.color
        personalizedView.backgroundColor = Asset.Colors.grayColor.color
        btnGeneralized.setTitleColor(.white, for: .normal)
        btnPersonlazied.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        self.offerType = "GENERALIZED"
        self.ApiCallingFunc(state: "", offerType: self.offerType)
    }
    
    
}

extension ProposalVC: ProposalListProtocolDelegate {
    
    func setProposalList(data: ProposalModel) {
        if data.status == "SUCCESS"{
            self.proposalListArr = data.data?.proposalsList ?? []
            
            if self.proposalListArr.count > 0 {
                self.emptyView.isHidden = true
                self.tableView.isHidden = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.emptyView.isHidden = false
                self.tableView.isHidden = true
            }
        }
        else{
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

extension ProposalVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.proposalListArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProposalListCell", for: indexPath) as! ProposalListCell
        
        let info = self.proposalListArr[indexPath.row]
    
        let leadId = info.leadDetails?.leadId ?? "NA"
        let offerId = info.policyDetails?.offerId ?? ""
        if offerType == "GENERALIZED"{
            cell.leadView.isHidden = true
        }else{
            cell.leadView.isHidden = false
        }
        cell.cellLeadId.text = leadId
        cell.cellPolicyIdLbl.text = offerId
        cell.cellAgentLbl.text = info.agentDetails?.agentName ?? "Unassigned".localized()
      
//        cell.cellPartnerLbl.text = info.policyDetails?.par ?? ""
        //cell.cellAddedOnLbl.text = info.lastUpdatedOn ?? ""
        
        var createdOnStr = info.createdOn ?? ""
        createdOnStr = createdOnStr.components(separatedBy: "T")[0]
        cell.cellAddedOnLbl.text = returnDOB(date: createdOnStr)
       
        var addedOnStr = info.lastUpdatedOn ?? ""
        addedOnStr = addedOnStr.components(separatedBy: "T")[0]
        cell.cellUpdatedLbl.text = returnDOB(date: addedOnStr)
        
        cell.cellMailLbl.text = info.memberDetails?.email ?? ""
        let countryCode = info.memberDetails?.countryCode ?? ""
        
        cell.cellPhoneLbl.text = "\(countryCode) \(info.memberDetails?.mobile ?? "")"
       // cell.cellPhoneLbl.text = info.memberDetails?.mobile ?? ""
        let cat = info.policyDetails?.categoryDetails?.categoryName ?? ""
        let subCat = info.policyDetails?.categoryDetails?.subCategoryName ?? ""
        cell.cellSubcatLbl.text = cat+"/"+subCat
        cell.cellAddressLbl.text = info.memberDetails?.address ?? ""
        
        let fName = info.memberDetails?.firstName?.capitalized ?? ""
        let lName = info.memberDetails?.lastName?.capitalized ?? ""
        cell.cellNameLbl.text = fName + " " + lName
        cell.cellPartnerLbl.text = fName + " " + lName

        cell.cellMenuBtn.tag = indexPath.row
        cell.cellMenuBtn.addTarget(self, action: #selector(menuActionBtn(_:)), for: .touchUpInside)
        
        if info.proposalState ?? "" == "OFFER_CREATED" {
            cell.cellStatusLbl.text = "Pending".localized()
            cell.cellStatusLbl.textColor = .systemYellow
        } else if info.proposalState ?? "" == "SIGNED_DOCS" {
            cell.cellStatusLbl.text = "Accepted".localized()
            cell.cellStatusLbl.textColor = .green
        } else if info.proposalState ?? "" == "REJECTED" {
            cell.cellStatusLbl.text = "Rejected".localized()
            cell.cellStatusLbl.textColor = .red
        } else if info.proposalState ?? "" == "POLICY_CREATED" {
            cell.cellStatusLbl.text = "Policy Created".localized()
            cell.cellStatusLbl.textColor = .systemYellow
        } else {
            cell.cellStatusLbl.text = ""
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
//        self.pushToVC(vc, animated: true)
    }
    
    @objc func menuActionBtn(_ sender: UIButton ){
        let vc = EditProposalVC.instantiate(fromAppStoryboard: .proposalStoryboard)
        vc.delegateEditProposal = self
        vc.index = sender.tag
        vc.allowModification = self.proposalListArr[sender.tag].proposalState == "OFFER_CREATED" ? true : false
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

extension ProposalVC:EditProposalProtocolDelegate {
    
    
    func passData(sendValue: String, index: Int) {
        print(sendValue)
        
        switch sendValue {
        case "Edit":
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.proposalId = self.proposalListArr[index].proposalId ?? ""
                vc.fromWhichVC = "ProposalVC"
                UserDefaults.standard.set("no", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
            let checkAccess = self.checkAccess(id: 2, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            
            if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
                let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.proposalId = self.proposalListArr[index].proposalId ?? ""
                vc.fromWhichVC = "ProposalVC"
                UserDefaults.standard.set("no", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
                
            } else {
                self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
            }
     
        case "View":
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.proposalId = self.proposalListArr[index].proposalId ?? ""
                vc.fromWhichVC = "ViewVC"
                self.pushToVC(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
            let checkAccess = self.checkAccess(id: 2, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            
            if (checkAccess.0 && userType == "AGENT") || userType == "PARTNER"{
                let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                vc.proposalId = self.proposalListArr[index].proposalId ?? ""
                vc.fromWhichVC = "ViewVC"
                self.pushToVC(vc, animated: true)
            } else {
                self.ShowAlert(message: "You don't have write permissions. Please contact your partner")
                
            }

        default:
            print("")
        }
    }

    func dateFromWebtoApp(_ inDate: String) -> String? {
        let inFormatter = ISO8601DateFormatter()
        if let date = inFormatter.date(from: inDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//"MM-dd-yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}


extension ProposalVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate, ActiveUsersProtocolDeleagte {
    
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
    
//    func popupMsg(msg: String) {
//        DispatchQueue.main.async {
//            self.ShowAlert(message: msg)
//        }
//
//    }
    
    func setActiveUsersList(data: AddProposalMembersModel) {
        
        if data.status == "SUCCESS" {
            
            
            var memberList = data.data?.usersList ?? []
            isCustomerAdded = memberList.count > 0 ? true : false
            
        } else {
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
    
}

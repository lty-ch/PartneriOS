//
//  CustomerVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

class CustomerVC: UIViewController, CustomerListProtocolDelegate, CustomerAssignCallback {
    
    func setCustomerAssignAgentData(data: SuccessModel) {
        if data.data?.status == "SUCCESS" {
            let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
           
            self.customerVM.delegate = self
            
            let usertype = kUserDefaults.value(forKey: AppKeys.userType)

            if usertype as! String == "PARTNER"{
                let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": "", "pageSize": pageSize]
                let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
                customerVM.customerListApi(param: param,url: url)
            }else{
                
                let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
                let param:[String:Any] = ["agentId": partnerId, "searchBy": "", "pageSize": pageSize]
                customerVM.customerListApi(param: param,url: url)
            }
           
        }
    }

    @IBOutlet weak var lblSelectPartnerAgent: UILabel!
    @IBOutlet weak var lblAddPartnerCustomer: UILabel!
    @IBOutlet weak var lblAddCustomer: UILabel!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var searchTfAgent: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchCloseBtn: UIButton!
    @IBOutlet weak var searchBtnPartner: UIButton!
    @IBOutlet weak var searchCloseBtnPartner: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewPartner: UIView!
    
    @IBOutlet weak var PartnerSearchbarView: UIView!
    @IBOutlet weak var customerSearchView: UIView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var addCustomerView: UIView!
    @IBOutlet weak var addCustomerInPartner: UIView!
    @IBOutlet weak var btnAddAgent: UIButton!
    @IBOutlet weak var selectAgentView: UIView!
    @IBOutlet weak var btnSelctAgent: UIButton!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    @IBOutlet weak var tableView: UITableView!
    
    var customerVM = CustomerViewModel()
    var customerListArr = [UsersList]()
    var customerAgentArr = [CustomerActiveAgentsList]()
    var timer = Timer()
    var pageSize = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUpView()
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Customer".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
         self.customerVM.delegate = self
         
         let usertype = kUserDefaults.value(forKey: AppKeys.userType)

         if usertype as! String == "PARTNER"{
           //  selectAgentView.isHidden = false
             self.searchTf.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
             let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": "", "pageSize": pageSize]
             let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
             customerVM.customerListApi(param: param,url: url)
         }else{
            // selectAgentView.isHidden = true
             self.searchTfAgent.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
             let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
             let param:[String:Any] = ["agentId": partnerId, "searchBy": "", "pageSize": pageSize]
             customerVM.customerListApi(param: param,url: url)
         }
        
        
        let agentParam:[String:Any] = ["partnerId": partnerId, "searchBy": ""]
        customerVM.getCustomerActiveAgent(param: agentParam)
  
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
    //MARK:- SetUpView
    
    func SetUpView() {
        lblAddCustomer.text = "Add Customer  + ".localized()
        lblAddPartnerCustomer.text = "Add Customer  + ".localized()
        lblSelectPartnerAgent.text = "Select Agent".localized()
 
        selectAgentView.viewCorner(8)
        addCustomerView.viewCorner(8)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        if userType == "AGENT" {
            PartnerSearchbarView.isHidden = true
            customerSearchView.isHidden = false
        }else{
            PartnerSearchbarView.isHidden = false
            customerSearchView.isHidden = true
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setCustomerList(data: CustomerModel) {
        
        if data.status == "SUCCESS" {
            self.customerListArr = data.data?.usersList ?? []
            
            if customerListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.noDataFoundView.isHidden = false
                    self.tableView.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self.noDataFoundView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
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
    
//    func setBlockCustomerdata(data: SuccessModel) {
//        print("User Blocked")
//    }
    
    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        
        if data.status == "SUCCESS" {
            
            self.customerAgentArr = data.data?.agentsList ?? []
            
            if customerAgentArr.count == 0 {
                DispatchQueue.main.async {
                    
//                    self.noDataFoundView.isHidden = false
//                    self.tableView.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
//                    self.noDataFoundView.isHidden = true
//                    self.tableView.isHidden = false
//                    self.tableView.reloadData()
                }
            }
        }
        else{
            //self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
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
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    @IBAction func onClickSelectAgent(_ sender: Any) {
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for item in customerAgentArr {
            let fName = item.firstName?.capitalized   ?? ""
            let lName = item.lastName?.capitalized   ?? ""
            
            let action = UIAlertAction(title: "\(fName) \(lName)", style: .default) { (action) in
   
                let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                
                 self.customerVM.delegate = self
                 
                 let usertype = kUserDefaults.value(forKey: AppKeys.userType)

                 if usertype as! String == "PARTNER"{
                     let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": item.partnerId ?? ""]
                     let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
                     self.customerVM.customerListApi(param: param,url: url)
                 }else{
                     
                     let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
                     let param:[String:Any] = ["agentId": partnerId, "searchBy": ""]
                     self.customerVM.customerListApi(param: param,url: url)
                 }

          }

//              let icon = UIImage.init(named: cat.icon)

//              action.setValue(icon, forKey: "image")
              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            }

            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    
    @IBAction func btnAddAgentAction(_ sender: UIButton) {
        
        guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
            let vc = AddNewCustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
            vc.delegate = self
            vc.isComingFrom = "New"
            self.pushToVC(vc, animated: true)
            return
        }

        let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
        let checkAccess = self.checkAccess(id: 1, useCaseArr: userRole?.useCasesList)
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        
        if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
            let vc = AddNewCustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
            vc.delegate = self
            vc.isComingFrom = "New"
            self.pushToVC(vc, animated: true)
        } else {
            self.ShowAlert(message: "You don't have write permissions. Please contact your partner".localized())
            
        }
        
    }
    
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            self.searchView.isHidden = false
            self.searchViewPartner.isHidden = false
            self.selectAgentView.isHidden = true
            self.addCustomerInPartner.isHidden = true
            
            self.addCustomerView.isHidden = true
            self.searchCloseBtn.isHidden = false
            self.searchBtn.isHidden = true
            self.searchCloseBtnPartner.isHidden = false
            self.searchBtnPartner.isHidden = true
//            self.viewHeaderBar.isHidden = false

//            self.consSearchViewWidth.constant = 0

            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func onClickSearchClose(_ sender: Any) {
        
        if self.searchTf.text != "" || self.searchTfAgent.text != ""{
            let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                         
             let usertype = kUserDefaults.value(forKey: AppKeys.userType)

             if usertype as! String == "PARTNER"{
                 let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": ""]
                 let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
                 customerVM.customerListApi(param: param,url: url)
             }else{
                 let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
                 let param:[String:Any] = ["agentId": partnerId, "searchBy": ""]
                 customerVM.customerListApi(param: param,url: url)
             }
        }
        

        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            self.searchView.isHidden = true
            self.searchViewPartner.isHidden = true
            self.selectAgentView.isHidden = false
            self.addCustomerInPartner.isHidden = false
            self.addCustomerView.isHidden = false
            self.searchCloseBtn.isHidden = true
            self.searchBtn.isHidden = false
            self.searchCloseBtnPartner.isHidden = true
            self.searchBtnPartner.isHidden = false
            self.searchTf.text = ""
            self.searchTfAgent.text = ""
//            self.viewHeaderBar.isHidden = false

//            self.consSearchViewWidth.constant = 0

            self.view.layoutIfNeeded()
        }
        



    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("searchText \(textField.text)")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.output), userInfo: textField.text, repeats: false)
    }
    
    @objc func output(){
        if timer.userInfo != nil {
            let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                         
             let usertype = kUserDefaults.value(forKey: AppKeys.userType)

             if usertype as! String == "PARTNER"{
                 let param:[String:Any] = ["partnerId": partnerId, "searchBy": self.searchTf.text! ,"agentId": ""]
                 let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
                 customerVM.customerListApi(param: param,url: url)
             }else{
                 let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
                 let param:[String:Any] = ["agentId": partnerId, "searchBy": self.searchTfAgent.text!]
                 customerVM.customerListApi(param: param,url: url)
             }
        }
        timer.invalidate()
    }
    
}

extension CustomerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customerListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerListCell", for: indexPath) as! CustomerListCell
        
        let info = self.customerListArr[indexPath.row]
        print(info)
        cell.cellMenuBtn.tag = indexPath.row
        cell.cellMenuBtn.addTarget(self, action: #selector(menuAction(sender:)), for: .touchUpInside)
        
        cell.cellDobLbl.text = returnDOB(date: info.dob ?? "")
        let fName = info.firstName?.capitalized ?? ""
        let lName = info.lastName?.capitalized ?? ""
        cell.cellNameLbl.text = fName + " " + lName
        cell.cellTypeLbl.text = info.type
        cell.cellAgentLbl.text = info.agentName ?? "Unassigned".localized()
        cell.cellAddressLbl.text = info.address
        cell.cellEmailLbl.text = info.email
        let countryCode = info.countryCode ?? ""
        cell.cellPhoneLbl.text = "\(countryCode) \(info.mobile ?? "")"
       // cell.cellPhoneLbl.text = info.mobile
        if info.userState == "ACTIVE" {
            cell.cellStatusLbl.textColor = UIColor.systemGreen
        } else {
            cell.cellStatusLbl.textColor = UIColor.red
        }
        cell.cellStatusLbl.text = info.userState?.localized()
        
        return cell
    }
    
    @objc func menuAction(sender: UIButton){
        let buttonTag = sender.tag
        DispatchQueue.main.async {
            
            let vc = EditCustomerOptionsVC.instantiate(fromAppStoryboard: .customerStoryboard)
            vc.delegate = self
            vc.userId = self.customerListArr[sender.tag].userId ?? ""
            vc.index = sender.tag
            
            vc.currentUserStatus = self.customerListArr[sender.tag].userState ?? ""
//            vc.type = "cat"
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
     
            self.present(vc, animated: true)
        }
        
    }
    
    
}

extension CustomerVC: CustomerEditTappedProtocolDelegate, AddNewCustomerCallback {
    
    func removeView() {
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
         self.customerVM.delegate = self
         
         let usertype = kUserDefaults.value(forKey: AppKeys.userType)

         if usertype as! String == "PARTNER"{
             let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": ""]
             let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
             customerVM.customerListApi(param: param,url: url)
         }else{
             
             let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
             let param:[String:Any] = ["agentId": partnerId, "searchBy": ""]
             customerVM.customerListApi(param: param,url: url)
         }

    }
    
    
    func removeOptionsView() {
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
         self.customerVM.delegate = self
         
         let usertype = kUserDefaults.value(forKey: AppKeys.userType)

         if usertype as! String == "PARTNER"{
             let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": ""]
             let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
             customerVM.customerListApi(param: param,url: url)
         }else{
             
             let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
             let param:[String:Any] = ["agentId": partnerId, "searchBy": ""]
             customerVM.customerListApi(param: param,url: url)
         }

        
    }
    
    func actionsTappedIndex(editActionTappedIndex: Int, listIndex: Int) {
       if editActionTappedIndex == 102 {
            let vc = CustomerMemberVC.instantiate(fromAppStoryboard: .customerStoryboard)
           vc.customerListObj = self.customerListArr[listIndex]
            vc.userId = self.customerListArr[listIndex].userId ?? ""
            vc.familyMemberId = self.customerListArr[listIndex].familyMemberId ?? ""
            vc.userName = self.customerListArr[listIndex].firstName?.capitalized   ?? ""
            self.pushToVC(vc, animated: true)
            
        } else if editActionTappedIndex == 103 {
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = CustomerAssignVC.instantiate(fromAppStoryboard: .customerStoryboard)
                vc.customerAssignDelegate = self
                vc.customerAgentArr = self.customerAgentArr
                vc.userId = self.customerListArr[listIndex].userId ?? ""
                
    //            vc.type = "cat"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
         
                self.present(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
            let checkAccess = self.checkAccess(id: 1, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            
            if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
                
                let vc = CustomerAssignVC.instantiate(fromAppStoryboard: .customerStoryboard)
                vc.customerAssignDelegate = self
                vc.customerAgentArr = self.customerAgentArr
                vc.userId = self.customerListArr[listIndex].userId ?? ""
                
    //            vc.type = "cat"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
         
                self.present(vc, animated: true)
            } else {
                self.ShowAlert(message: "You don't have write permissions. Please contact your partner".localized())
                
            }

            
        } else if editActionTappedIndex == 104 {
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = AddNewCustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
                vc.delegate = self
                vc.agentId = self.customerListArr[listIndex].agentId ?? ""
                vc.isComingFrom = "Edit"
                vc.entityId = self.customerListArr[listIndex].userId ?? ""
                self.pushToVC(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
            let checkAccess = self.checkAccess(id: 1, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            
            if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
                
                let vc = AddNewCustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
                vc.delegate = self
                vc.agentId = self.customerListArr[listIndex].agentId ?? ""
                vc.isComingFrom = "Edit"
                vc.entityId = self.customerListArr[listIndex].userId ?? ""
                self.pushToVC(vc, animated: true)
                
            } else {
                self.ShowAlert(message: "You don't have write permissions. Please contact your partner".localized())
                
            }

            
        } else if editActionTappedIndex == 105 {
            print("User Blocked")
        }
    }
    
    
}

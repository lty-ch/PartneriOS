//
//  AllUsersVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/07/23.
//

import UIKit

class AllUsersVC: UIViewController {
  
    
    @IBOutlet weak var userListTable: UITableView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var customerVM = CustomerViewModel()
    var customerListArr = [UsersList]()
    var customerAgentArr = [CustomerActiveAgentsList]()

    override func viewDidLoad() {
        super.viewDidLoad()

//        customerListArr.append(UsersList.init(userId: "MzU2MzA2NzA1NTI1NzQwNQ", source: "", type: "User", firstName: "tanuj", lastName: "bansal", mobile: "", isMobileVerified: true, email: "tanuj@yopmail.com", isEmailVerified: false, dob: "tanuj@yopmail.com", country: "tanuj@yopmail.com", state: "tanuj@yopmail.com", city: "tanuj@yopmail.com", address: "tanuj@yopmail.com", postCode: "tanuj@yopmail.com", maritalStatus: "tanuj@yopmail.com", gender: "tanuj@yopmail.com", registrationId: "tanuj@yopmail.com", agentId: "tanuj@yopmail.com", agentName: "tanuj@yopmail.com", partnerId: "tanuj@yopmail.com", partnerName: "tanuj@yopmail.com", profilePic: "https://lty-platform.s3.eu-central-2.amazonaws.com/dev/document-store/fc3e54d5-be2f-4e43-890f-a697d13136d9.jpeg", companyDetails: nil, bankDetails: nil, isDefaultPasswordSet: false, userState: "tanuj@yopmail.com", reason: "tanuj@yopmail.com", createdOn: "tanuj@yopmail.com", lastUpdatedOn: "tanuj@yopmail.com"))
        
        setDrowerHeight()
        setupTableView()
        customNavDrower.titleLabel.text = "User List".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
//
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


        let agentParam:[String:Any] = ["partnerId": partnerId, "searchBy": ""]
        customerVM.getCustomerActiveAgent(param: agentParam)
    }

    func setupTableView(){
        
        userListTable.delegate = self
        userListTable.dataSource = self
        userListTable.register(UINib(nibName: "AllUserTableViewCell", bundle: .main), forCellReuseIdentifier: "AllUserTableViewCell")
        
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
    

}

extension AllUsersVC :CustomerListProtocolDelegate{
    
    func setCustomerList(data: CustomerModel) {
        
        if data.status == "SUCCESS" {
            self.customerListArr = data.data?.usersList ?? []
            
            if customerListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.noDataFoundView.isHidden = false
                    self.userListTable.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self.noDataFoundView.isHidden = true
                    self.userListTable.isHidden = false
                    self.userListTable.reloadData()
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
                    
                    self.noDataFoundView.isHidden = false
                    self.userListTable.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self.noDataFoundView.isHidden = true
                    self.userListTable.isHidden = false
                    self.userListTable.reloadData()
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
}

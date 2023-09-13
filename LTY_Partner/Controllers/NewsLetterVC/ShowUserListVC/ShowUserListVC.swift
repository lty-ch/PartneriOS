//
//  ShowUserListVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/08/23.
//

import UIKit

class ShowUserListVC: UIViewController, SendNewLetterProtocol, SendNewsLetterProtocol {

    @IBOutlet weak var lblSelectAll: UILabel!
    @IBOutlet weak var textChooseTemp: UITextField!
    @IBOutlet weak var selectAllView: UIView!
    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var addNewTemplateViewModel = AddNewTemplateViewModel()
    var tempId = ""
    var userList = NSMutableArray()
    var isUserSelected = false
    var newLetterViewModel = NewLetterViewModel()
    var newsTemplateArr = [SendNewsLetterTemplateList]()
    var customerVM = CustomerViewModel()
    var customerListArr = [UsersList]()
    var customerAgentArr = [CustomerActiveAgentsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        setupTableView()
        selectAllView.viewCorner(6)
        addNewTemplateViewModel.SendNewsLetterDelegate = self
        customNavDrower.titleLabel.text = "Send News Letter".localized()
        textChooseTemp.text = "Choose Template".localized()
        lblSelectAll.text = "Select All".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        newLetterViewModel.delegate = self
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
        self.customerVM.delegate = self
        
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        
        if usertype as! String == "PARTNER"{
            entityType = "PARTNER_ID"
            let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": ""]
            let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
            customerVM.customerListApi(param: param,url: url)
        }else{
            entityType = "AGENT_ID"
            let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
            let param:[String:Any] = ["agentId": partnerId, "searchBy": ""]
            customerVM.customerListApi(param: param,url: url)
        }
        
        
        
        let param:[String: Any] = ["entityType": entityType,"entityId": partnerId]
        newLetterViewModel.getNewTemplateApiCall(param: param)
        
    }
    
    func setupTableView(){
        
        userListTableView.delegate = self
        userListTableView.dataSource = self
        userListTableView.separatorStyle = .none
  
        userListTableView.register(UINib(nibName: "ShowUserListTVC", bundle: .main), forCellReuseIdentifier: "ShowUserListTVC")
        
        
        let headerNib = UINib(nibName: "ShowUserListFooterView", bundle: .main)
      
 
        userListTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ShowUserListFooterView")
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
    @IBAction func openTemplateActionBtn(_ sender: UIButton) {
        openActionSheet()
    }
    
    
    @IBAction func btnselectAllAction(_ sender: UIButton) {
        //select_check
        sender.isSelected = !sender.isSelected
        
        /*
         let fName = info.firstName ?? ""
         let lName = info.lastName ?? ""
         
         let userExists = self.ifUserExists(info.email ?? "")
         
         if userExists.0 {
             info.isSelected = "no"
             self.customerListArr.remove(at: indexPath.row)
             self.customerListArr.insert(info, at: indexPath.row)
             self.userList.removeObject(at: userExists.1)
         } else {
             let dic = NSMutableDictionary()
             dic["name"] = fName + " " + lName
             dic["email"] = info.email ?? ""
             self.userList.add(dic)
             info.isSelected = "yes"
             self.customerListArr.remove(at: indexPath.row)
             self.customerListArr.insert(info, at: indexPath.row)
         }
         */
        
        if sender.isSelected == true {
            var info = customerListArr[sender.tag]
            
            
            for i in 0..<customerListArr.count {
                
                customerListArr[i].isSelected = "yes"
                
//                item.isSelected = "yes"
                let dic = NSMutableDictionary()
                let fName = customerListArr[i].firstName?.capitalized   ?? ""
                let lName = customerListArr[i].lastName?.capitalized   ?? ""
                dic["name"] = fName + " " + lName
                dic["email"] = customerListArr[i].email ?? ""
                self.userList.add(dic)
//                self.customerListArr.remove(at: i)
//                self.customerListArr.insert(info, at: sender.tag)
            }
            
            imgCheckMark.image = UIImage(named: "select_check")
        }else{
            var info = customerListArr[sender.tag]
       
            
            for i in 0..<customerListArr.count {
                
                customerListArr[i].isSelected = "no"
                
                self.userList.removeAllObjects()
//                self.customerListArr.remove(at: i)
//                self.customerListArr.insert(info, at: sender.tag)
            }
            
            imgCheckMark.image = UIImage(named: "select_uncheck")

        }
        userListTableView.reloadData()

   
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
    func openActionSheet() {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in newsTemplateArr {
            
            
            let action = UIAlertAction(title: cat.templateName ?? "", style: .default) { (action) in
                self.textChooseTemp.text = cat.templateName ?? ""
                self.tempId = cat.templateId ?? ""
                
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
            
        }
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    func sendTemplate() {
        let param : [String:Any] = ["templateId":tempId, "userList": self.userList]
        addNewTemplateViewModel.sendTemplateApi(param: param)
    }
    
    func ifUserExists(_ email: String) -> (Bool, Int) {
        var isExist = false
        var count = -1
        for items in self.userList {
            count += 1
            let item = items as! NSMutableDictionary
            if item["email"] as! String == email {
                isExist = true
                break
            }
        }
        return (isExist, count)
    }
    
    func setNewsLetterData(data: SendNewsLetterModel) {
        
        if data.status == "SUCCESS" {
            self.newsTemplateArr.removeAll()
            self.newsTemplateArr = data.data?.templateList ?? []
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
    
    func showMessage(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }

    func SendNewsLetterData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
                self.showOkAlertWithHandler("Sent successfully.") {
                    self.popVC(animated: true)
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
    
 
}

extension ShowUserListVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: "ShowUserListTVC", for: indexPath) as! ShowUserListTVC
        cell.selectionStyle = .none

      var info = customerListArr[indexPath.row]
        let fName = info.firstName?.capitalized  ?? ""
        let lName = info.lastName?.capitalized  ?? ""
        
        cell.lblTitle.text = fName + " " + lName
        cell.lblStatus.text = info.userState?.localized()
        cell.lblEmail.text = info.email
        
        if info.isSelected == "yes"{
            isUserSelected = true
            cell.imgCheckMark.isHidden = false
        }else{
            cell.imgCheckMark.isHidden = true
        }

        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var info = customerListArr[indexPath.row]
        
        let fName = info.firstName?.capitalized  ?? ""
        let lName = info.lastName?.capitalized  ?? ""
        
        let userExists = self.ifUserExists(info.email ?? "")
        
        if userExists.0 {
            info.isSelected = "no"
            self.customerListArr.remove(at: indexPath.row)
            self.customerListArr.insert(info, at: indexPath.row)
            self.userList.removeObject(at: userExists.1)
        } else {
            let dic = NSMutableDictionary()
            dic["name"] = fName + " " + lName
            dic["email"] = info.email ?? ""
            self.userList.add(dic)
            info.isSelected = "yes"
            self.customerListArr.remove(at: indexPath.row)
            self.customerListArr.insert(info, at: indexPath.row)
        }
        userListTableView.reloadData()
        
        
    }
    
    
    //  MARK:-  view for footer in section func in tableview
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "ShowUserListFooterView") as! ShowUserListFooterView
        footerView.btnSend.layer.cornerRadius = 4
        
        //let showBtn = categories[section].loadSection
        
        footerView.btnSend.tag = section
        footerView.btnSend.addTarget(self, action:#selector(buttonFooterAction(_:)), for: .touchUpInside)
        
        return footerView
        
    }
    
    @objc func buttonFooterAction(_ sender:UIButton){
        print(sender.tag)
        if tempId == ""{
            self.ShowAlert(message: "Please choose template.")
            return
        }else if self.userList.count == 0{
            self.ShowAlert(message: "Please select User.")
            return
        }
        self.sendTemplate()
        
   
    }
   
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 65
    }

}

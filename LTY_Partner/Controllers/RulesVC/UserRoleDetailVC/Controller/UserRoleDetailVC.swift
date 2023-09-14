//
//  UserRoleDetailVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import UIKit

class UserRoleDetailVC: UIViewController {
    
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var lblSelectAll: UILabel!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var userRoleTableView: UITableView!
    
    @IBOutlet weak var selectAllBtn: UISwitch!
    
    var roleDetailVM = RoleDetailViewModel()
    var useCaseArr = [RoleDetailList]()
    var duplicateUseCaseArr = NSMutableArray()
    var selectedUseCaseArr = [RoleDetailList]()
    var useCaseArrForParams = NSMutableArray()
    var useCaseObjForParams = NSMutableDictionary()
    var roleId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        userRoleTableView.delegate = self
        userRoleTableView.dataSource = self
        
        customNavDrower.titleLabel.text = "Agent Role".localized()
        btnUpdate.setTitle("Update".localized(), for: .normal)
        
        lblSelectAll.text = "Select All".localized()
        
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        roleDetailVM.delegate = self
        roleDetailVM.getAllRoleDetailApi()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
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

    @IBAction func onClickUpDate(_ sender: UIButton) {
        print(self.useCaseArr)
        
        for item in self.useCaseArr {
            var obj = NSMutableDictionary()
            obj.setValue(item.useCaseId, forKey: "useCaseId")
            var arr = NSMutableArray()
            for it in item.selectedPermissionIds ?? [] {
                arr.add(it)
            }
            obj.setValue(arr, forKey: "permissionIds")
            self.duplicateUseCaseArr.add(obj)
        }
        print(self.duplicateUseCaseArr)
        print(self.useCaseArr)
        
        let params:[String:Any] = ["roleId": self.roleId, "useCasesDetails": self.duplicateUseCaseArr]
        
        roleDetailVM.updateRoleAPI(param: params)
        
    }
    
    func createDuplicateArr() {
        for item in self.useCaseArr {
            var obj = NSMutableDictionary()
            obj.setValue(item.useCaseId, forKey: "useCaseId")
            obj.setValue(item.name, forKey: "name")
            var arr = NSMutableArray()
            obj.setValue(arr, forKey: "permissionIds")
            self.duplicateUseCaseArr.add(obj)
        }
        createArrForParams()
    }
    
    func createArrForParams() {
        for item in self.useCaseArr {

//            let item = ite as! NSDictionary
            var count = -1
            
            for selectedItem in self.selectedUseCaseArr {
                
                var obj = NSMutableDictionary()
                count += 1
                
                if item.useCaseId == selectedItem.useCaseId {
                    obj.setValue(item.useCaseId, forKey: "useCaseId")
                    obj.setValue(item.name, forKey: "name")
                    var arr = NSMutableArray()
                    for val in selectedItem.permissionIds ?? [] {
                        arr.add(val)
                    }
                    obj.setValue(arr, forKey: "permissionIds")
                    
                    self.duplicateUseCaseArr.removeObject(at: count)
                    self.duplicateUseCaseArr.insert(obj, at: count)
                    break
                    
                }
            }
        }
    }
    
    
    @IBAction func onClickSelectAll(_ sender: UISwitch) {
        if selectAllBtn.isOn {
            for i in 0..<self.useCaseArr.count {
                self.useCaseArr[i].selectedPermissionIds = self.useCaseArr[i].permissionIds
                
            }
        } else {
            for i in 0..<self.useCaseArr.count {
                self.useCaseArr[i].selectedPermissionIds = nil
            }
        }
        
        
        DispatchQueue.main.async {
            self.userRoleTableView.isHidden = false
            self.noDataFoundView.isHidden = true
            self.userRoleTableView.reloadData()
        }
    }
    
}

extension UserRoleDetailVC: RoleDetailDelegate {
    
    func setUpdateRolesData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            self.showToast(message: "Role updated successfully", font: FontSize.size12!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.popVC(animated: true)
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
    
    func checkAllSelectedForSelectAllBtn() -> Bool {
        
        var ShouldBeSelected = true
        
        for item in self.useCaseArr {
            if item.permissionIds != item.selectedPermissionIds {
                print(item)
                ShouldBeSelected = false
                break
            }
        }
        return ShouldBeSelected
    }
    
    func setSelectedRolesData(data: RoleDetailModel) {
        
        self.selectedUseCaseArr = data.data?.useCasesList ?? []
        print(self.useCaseArr)
        
        if self.selectedUseCaseArr.count > 0 {
            
            for item in self.useCaseArr {
                var count = -1
                for selectedItem in self.selectedUseCaseArr {
                    count += 1
                    if item.useCaseId == selectedItem.useCaseId {
                        self.useCaseArr[count].selectedPermissionIds = selectedItem.permissionIds
                    }
                }
            }
        }
        print(self.useCaseArr)
        
        if self.checkAllSelectedForSelectAllBtn() {
            self.selectAllBtn.isOn = true
        } else {
            self.selectAllBtn.isOn = false
        }

        if useCaseArr.count == 0 {
            DispatchQueue.main.async {
                
                self.userRoleTableView.isHidden = true
                self.noDataFoundView.isHidden = false
            }
        } else {
            DispatchQueue.main.async {
                self.userRoleTableView.isHidden = false
                self.noDataFoundView.isHidden = true
                self.userRoleTableView.reloadData()
            }
        }
        
        
    }
    
    
    func setAllRolesData(data: RoleDetailModel) {
        
        self.useCaseArr.removeAll()
        if data.status == "SUCCESS" {
            self.useCaseArr = data.data?.useCasesList ?? []
            let param: [String:Any] = ["roleId": self.roleId]
            roleDetailVM.getSelectedRoleAPI(param: param)
            

            
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

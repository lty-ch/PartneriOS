//
//  AddRoleVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 27/06/23.
//

import UIKit

protocol RoleAddedCallback : AnyObject {
    func setAddRoleData()
}

class AddRoleVC: UIViewController {
    
    @IBOutlet weak var lblMarkDefault: UILabel!
    @IBOutlet weak var lblTitleAddRole: UILabel!
    @IBOutlet weak var textRole: UITextField!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var btnAddRole: UIButton!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    
    var addRoleVm = AddRoleViewModel()
    weak var delegate : RoleAddedCallback?
    var roleId = ""
    var roleName = ""
    var isDefault = false
    var isComing = ""
    var defaultValue : Bool?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        addRoleVm.delegate = self
        
    }
    
    func setUpUI() {
        if isComing == "Update Role" {
            
            if defaultValue == true {
                imgCheck.image = UIImage(named: "check")
                self.isDefault = true
            }else{
                imgCheck.image = UIImage(named: "uncheck")
                self.isDefault = false
            }
            textRole.placeholder = "Update Role".localized()
            lblTitleAddRole.text = "Update Role".localized()
            textRole.text = roleName
            textRole.isUserInteractionEnabled = false
            lblRole.text = "Update Role".localized()
            btnAddRole.setTitle("Update Role".localized(), for: .normal)
            
            
        }else{
            textRole.isUserInteractionEnabled = true
            textRole.placeholder = "Add Role".localized()
            lblTitleAddRole.text = "Add Role".localized()
            lblRole.text = "Add Role".localized()
            lblMarkDefault.text = "Mark as Default".localized()
            btnAddRole.setTitle("Add Role".localized(), for: .normal)
        }
    }
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func onClickSelctCheckBox(_ sender: UIButton) { // uncheck ,check
        sender.isSelected = isDefault
        if sender.isSelected == true {
            imgCheck.image = UIImage(named: "uncheck")
            sender.isSelected = false
            self.isDefault = false
        }else{
            sender.isSelected = true
            imgCheck.image = UIImage(named: "check")
            self.isDefault = true
        }
    }
    
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        guard let firstName = textRole.text, !firstName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageRoleName, title: LTY_AlterText.roleName)
            return
        }
        let param:[String:Any] = ["roleId": self.roleId, "name": self.textRole.text!, "isDefault": self.isDefault]
        print(param)
        addRoleVm.addRoleAPI(param: param)
    }
    
}

extension AddRoleVC: AddRoleListProtocolDelegate {
    
    
    func setAddRoleData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
                
                self.dismiss(animated: true) {
                    self.delegate?.setAddRoleData()
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

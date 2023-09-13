//
//  EditCustomerOptionsVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

protocol CustomerEditTappedProtocolDelegate : AnyObject {
    func actionsTappedIndex(editActionTappedIndex : Int, listIndex : Int)
    func removeOptionsView()
}


class EditCustomerOptionsVC: UIViewController {
    
    @IBOutlet weak var assignAgentView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var unblockView: UIView!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var confirmationLbl: UILabel!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var optionsView: UIView!
    
    var editCustomerVM = EditCustomerOptionsViewModel()
    var productIdArr = [String]()
    var productId = ""
    var type = ""
    var confirmationMsg = "Do you want to block this user ?".localized()
    var userId = ""
    var userState = ""
    var currentUserStatus = ""
    var showMsg = ""
    
    
    
    weak var delegate:CustomerEditTappedProtocolDelegate?
    var index = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editCustomerVM.delegatee = self
//        self.productIdArr.append(self.productId)
        
        if currentUserStatus == "ACTIVE" {
            self.unblockView.isHidden = true
            self.blockView.isHidden = false
            self.userState = "BLOCKED"
            self.confirmationMsg = "Do you want to block this user ?".localized()
        } else {
            self.blockView.isHidden = true
            self.unblockView.isHidden = false
            self.userState = "ACTIVE"
            self.confirmationMsg = "Do you want to Unblock this user ?".localized()
        }
        self.confirmationLbl.text = self.confirmationMsg

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)

        if usertype as! String == "PARTNER"{
            assignAgentView.isHidden = false
        }else {
            assignAgentView.isHidden = true
        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }

    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete, 104 - edit
        
        if sender.tag == 101 {
            self.dismiss(animated: true)
            delegate?.actionsTappedIndex(editActionTappedIndex: 101, listIndex: self.index)
        } else if sender.tag == 102 {
            self.dismiss(animated: true) {
                self.delegate?.actionsTappedIndex(editActionTappedIndex: 102, listIndex: self.index)
            }
        } else if sender.tag == 103 {
            self.dismiss(animated: true) {
                self.delegate?.actionsTappedIndex(editActionTappedIndex: 103, listIndex: self.index)
            }
            
        } else if sender.tag == 104 {
            self.dismiss(animated: true) {
                self.delegate?.actionsTappedIndex(editActionTappedIndex: 104, listIndex: self.index)
            }
            
        } else if sender.tag == 105 {
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                self.optionsView.isHidden = true
                self.deleteView.isHidden = false
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)
            let checkAccess = self.checkAccess(id: 1, useCaseArr: userRole?.useCasesList)
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            
            if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER"{
                self.optionsView.isHidden = true
                self.deleteView.isHidden = false
                
            } else {
                self.ShowAlert(message: "You don't have write permissions. Please contact your partner".localized())
                
            }
            
        } else if sender.tag == 108 {
            self.optionsView.isHidden = true
            self.deleteView.isHidden = false
            
            
        }
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        //101 - n0, 102 - yes
        if sender.tag == 102 {
                let param = ["userId": self.userId, "userState": self.userState]
                editCustomerVM.blockCustomerApi(param: param)
            
        } else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
    
    func deleteProductProtocol(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            self.showOkAlertWithHandler("Product deleted Successfully.".localized()) {
                DispatchQueue.main.async {
//                    self.delegate?.deleteProductProtocolWithIndex(data: self.index)

                }
                self.dismiss(animated: true)
            }
            
        }
    }
    
    func popupMsg(msg: String) {
        print("")
    }
    

}

extension EditCustomerOptionsVC:  EditCustomerOptionsProtocolDelegate {

    func setBlockCustomerdata(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
                if self.userState == "BLOCKED" {
                    self.showMsg = "User blocked Successfully.".localized()
                }
                else{
                    self.showMsg = "User Unblocked Successfully.".localized()
                }
                self.showOkAlertWithHandler(self.showMsg) {
                        self.delegate?.removeOptionsView()

                    self.dismiss(animated: true)
                }

            }
            
        }
    }
    
    func setCustomerList(data: CustomerModel) {
        print("")
    }

    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        print("")
    }
    
    
    
    
}

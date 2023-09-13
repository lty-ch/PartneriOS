//
//  AssignAgentVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import UIKit

protocol AgentAssignedCallback : AnyObject {
    func setAssignedData()
}

class AssignAgentVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var lblRoleType: UILabel!
    
    var roleListArr = [rolesList]()
    var addRoleVm = AddRoleViewModel()
    var agentObj : AgentListRoleList?
    var roleId = ""

    weak var delegate : AgentAssignedCallback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true

    }
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    

    @IBAction func onClickSelectAgent(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in roleListArr {
            
            let action = UIAlertAction(title: cat.name, style: .default) { (action) in
                self.lblRoleType.text = cat.name
                self.roleId = cat.id ?? ""
                
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        addRoleVm.assignRoleDelegate = self
        let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
        let param:[String:Any] = ["partnerId": partnerId, "userId": agentObj?.userId ?? "", "roleId": self.roleId]
        print(param)
        addRoleVm.assignRoleAPI(param: param)
    }
}

extension AssignAgentVC: AssignRoleListProtocolDelegate {
    
    func setAssignRoleData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
                
                self.dismiss(animated: true) {
                    self.delegate?.setAssignedData()
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

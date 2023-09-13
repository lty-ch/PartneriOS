//
//  CustomerAssignVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

protocol CustomerAssignCallback : AnyObject {
    func setCustomerAssignAgentData(data : SuccessModel)
}

protocol LeadAgentAssignCallback : AnyObject {
    func onLeadAssignAgentData(data : SuccessModel)
}

class CustomerAssignVC: UIViewController, CustomerAssignAgentProtocolDelegate {

    @IBOutlet weak var agentTxt: UITextField!
    
    var customerAgentArr = [CustomerActiveAgentsList]()
    var customerAssignVM = CustomerAssignViewModel()
    var customerAssignDelegate: CustomerAssignCallback?
    var leadAgentAssignDelegate: LeadAgentAssignCallback?
    var userId = ""
    var agentId = ""
    var leadId = ""
    var partnerId = ""
    var isComingFrom = ""
     

    override func viewDidLoad() {
        super.viewDidLoad()

        customerAssignVM.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func setCustomerAssignAgentApi(data: SuccessModel) {
        if data.status == "SUCCESS" {
            
            self.dismiss(animated: true) {
                self.customerAssignDelegate?.setCustomerAssignAgentData(data: data)
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
    
    func onLeadAssignAgentApi(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            
            self.dismiss(animated: true) {
                self.leadAgentAssignDelegate?.onLeadAssignAgentData(data: data)
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
    
    func customerAssignAgentApi(data: SuccessModel) {
        if data.status == "SUCCESS" {
            self.dismiss(animated: true)
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
        self.ShowAlert(message: msg)
    }
    
    @IBAction func onClickClosePopup(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onClickSelectAgent(_ sender: UIButton) {
        
        let vc = AgentListSearchVC.instantiate(fromAppStoryboard: .customerStoryboard)
        vc.customerAgentArr = self.customerAgentArr
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
        
//        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        for item in customerAgentArr {
//            let fName = item.firstName ?? ""
//            let lName = item.lastName ?? ""
//
//            let action = UIAlertAction(title: fName + lName, style: .default) { (action) in
//
//                self.agentTxt.text = fName + lName
//                self.agentId = item.partnerId ?? ""
//          }
//
////              let icon = UIImage.init(named: cat.icon)
//
////              action.setValue(icon, forKey: "image")
//              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
//
//              actionSheetAlertController.addAction(action)
//            }
//
//            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
//            actionSheetAlertController.addAction(cancelActionButton)
//
//            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    
    @IBAction func onClickAssignAgent(_ sender: UIButton) {
        if self.agentTxt.text!.isEmpty {
            ShowAlert(message: "Please select agent.".localized())
            return
        }
        if isComingFrom == "LeadVC"{
  
            let param: [String:Any] = ["leadId": self.leadId, "agentId": self.agentId, "partnerId": self.partnerId]
            customerAssignVM.assignAgentApiUsingLead(param: param)
        }else {
            
            let param: [String:Any] = ["userId": self.userId, "agentId": self.agentId]
            customerAssignVM.customerAssignAgentApi(param: param)
        }
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        self.dismiss(animated: true)

    }
    
    
}

extension CustomerAssignVC:AgentCallbackNameAndId {
    
    func setSelectedAgentData(name: String, id: String) {
        self.agentTxt.text = name
        self.agentId = id
    }
    
    
}

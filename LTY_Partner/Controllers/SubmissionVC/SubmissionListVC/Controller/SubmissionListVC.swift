//
//  SubmissionListVC.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import UIKit

class SubmissionListVC: UIViewController {
    
    @IBOutlet weak var selectAgentView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAllProposal: UILabel!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!

    //MARK:- Variables
    
    var AllProposalArr = ["Completed".localized(),"Pending".localized(),"All contracts submission".localized()]
    var submissionListViewModel = SubmissionListViewModel()
    var submissionListArr = [SubmissionProposalsList]()
    var agentId = ""
    var state = ""
    var pageSize = 50
    var customerVM = CustomerViewModel()
    var agentListArr = [CustomerActiveAgentsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submissionListViewModel.delegate = self

        
        setDrowerHeight()
        self.lblSelectedDate.text = "Select Agent".localized()
        customNavDrower.titleLabel.text = "Contract submission".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        let userType =  kUserDefaults.string(forKey:AppKeys.userType) as! String
        
        if userType == "AGENT"{
            self.selectAgentView.isHidden = true
        }else {
            self.selectAgentView.isHidden = false
        }
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let agentParam:[String:Any] = ["partnerId": partnerId, "searchBy": ""]
        customerVM.delegate = self
        customerVM.getCustomerActiveAgent(param: agentParam)
        
        ApiCallingFunc()
        
    }
    
  //MARK:- Api call func
    
    func ApiCallingFunc() {
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerID = kUserDefaults.value(forKey: "partnerID")
        
        let param: [String : Any] = [ "entityType": entityType as Any,
                                      "entityId": partnerID as Any,
                                      "pageSize": pageSize,
                                      "pageCount": 1, "state": self.state, "agentId": agentId]
        submissionListViewModel.submissionListApiCall(param:param)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

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
    
    
    @IBAction func onClickAllProposal(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in AllProposalArr {
            
            let action = UIAlertAction(title: cat, style: .default) { (action) in
                self.lblAllProposal.text = cat
                if cat == "All contracts submission"{
                    self.state = ""
                    self.ApiCallingFunc()
                }else if cat == "Completed"{
                    self.state = "POLICY_CREATED"
                    self.ApiCallingFunc()
                }else{
                    self.state = "SIGNED_DOCS"
                    self.ApiCallingFunc()
                }
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickAgent(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in agentListArr {
            let fName = item.firstName?.capitalized   ?? ""
            let lName = item.lastName?.capitalized   ?? ""
            
            let action = UIAlertAction(title: "\(fName) \(lName)", style: .default) { (action) in
   
                self.lblSelectedDate.text = "\(fName) \(lName)"
                self.agentId = item.partnerId ?? ""
                self.ApiCallingFunc()
//                let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
//                let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": item.partnerId ?? ""]
//                self.customerVM.delegate = self
//                self.customerVM.customerListApi(param: param)
                
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
    
    
    @IBAction func onClickAddProposal(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(next , animated: true)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended writing")
    }

}


extension SubmissionListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.submissionListArr.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmissionListTableViewCell", for: indexPath) as! SubmissionListTableViewCell
        
        let info = submissionListArr[indexPath.row]
        
        cell.AgentType.text = info.agentDetails?.agentName ?? "Unassigned".localized()
        cell.lblRequestType.text = info.insuranceType ?? ""
        cell.lblRelation.text = info.leadDetails?.relation ?? ""
        
        let fName = info.memberDetails?.firstName?.capitalized ?? ""
        let lName = info.memberDetails?.lastName?.capitalized ?? ""
        cell.lblMemberName.text = fName + " " + lName
        cell.cellNameLbl.text = fName + " " + lName

        var startDate = info.policyDetails?.startDate ?? ""
        startDate = startDate.components(separatedBy: "T")[0]
        cell.lblStartDate.text = returnDOB(date: startDate)

        var endDate = info.policyDetails?.endDate ?? ""
        endDate = endDate.components(separatedBy: "T")[0]
        cell.lblEndDate.text =  returnDOB(date: endDate)

        var lastAddedOn = info.createdOn ?? ""
        lastAddedOn = lastAddedOn.components(separatedBy: "T")[0]
        cell.lblAddedOn.text = returnDOB(date: lastAddedOn)

        var enquiredOn = info.lastUpdatedOn ?? ""
        enquiredOn = enquiredOn.components(separatedBy: "T")[0]
        cell.lblEnquiredOn.text = returnDOB(date: enquiredOn)
       
  

        if info.proposalState == "SIGNED_DOCS" {
            cell.lblAccepted.text = "Pending"
            cell.lblAccepted.textColor = .systemYellow
        } else {
            cell.lblAccepted.text = "Completed"
            cell.lblAccepted.textColor = Asset.Colors.greenColor.color
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SubmissionDetailVC.instantiate(fromAppStoryboard: .submissionStoryboard)
        let info = submissionListArr[indexPath.row]
        if info.proposalState == "SIGNED_DOCS" {
            vc.isPending = true
        } else {
            vc.isPending = false
        }
        vc.proposalId = info.proposalId ?? ""
        vc.commissionStartDate = info.commissionDetails?.commissionDate ?? ""
        self.pushToVC(vc, animated: true)
    }

}

extension SubmissionListVC: CustomerListProtocolDelegate {
    
    func setCustomerList(data: CustomerModel) {
        
        print("")
      
    }
    
    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        
        if data.status == "SUCCESS" {
            
            self.agentListArr = data.data?.agentsList ?? []
            
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
    
    
}

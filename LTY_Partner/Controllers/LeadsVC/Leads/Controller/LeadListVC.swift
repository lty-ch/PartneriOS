//
//  LeadListVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/06/23.
//

import UIKit

class LeadListVC: UIViewController, CustomerListProtocolDelegate {

    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchCloseBtn: UIButton!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAllProposal: UILabel!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!

    //MARK:- Variables
    
    var AllProposalArr = ["ACTIVE".localized(),"PENDING".localized(),"ACCEPTED".localized(),"CLOSED".localized(),"ALL".localized()]
    var leadListViewModel = LeadListViewModel()
    var leadListArr = [LeadList]()
    var customerVM = CustomerViewModel()
    var customerAgentArr = [CustomerActiveAgentsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leadListViewModel.delegate = self
        self.customerVM.delegate = self
        
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Leads List".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
        let agentParam:[String:Any] = ["partnerId": partnerId, "searchBy": ""]
        customerVM.getCustomerActiveAgent(param: agentParam)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            widthConstant.constant = 80
        }else{
            widthConstant.constant = 150
        }
        
            ApiCallingFunc(status: "")
        }
    
  //MARK:- Api call func
    
    func ApiCallingFunc(status:String) {
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerID = kUserDefaults.value(forKey: "partnerID")
        let param: [String : Any] = [ "entityType": entityType, "entityId": partnerID as Any, "status": status, "pageSize": 50, "pageCount": 1]
        
      
        leadListViewModel.leadListApiCall(param:param)
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
    
    @IBAction func onClickSearch(_ sender: UIButton) {
                
        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            self.searchView.isHidden = false
            self.stackView.isHidden = true
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
            self.searchView.isHidden = true
            self.stackView.isHidden = false
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
                if cat == "ALL"{
                    self.ApiCallingFunc(status: "")
                }else {
                    self.ApiCallingFunc(status: cat)
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
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(next , animated: true)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended writing")
    }

}


extension LeadListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leadListArr.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeadTableViewCell", for: indexPath) as! LeadTableViewCell
        
        let info = leadListArr[indexPath.row]
        cell.leadID.text = info.leadId
        if info.agentName == nil{
            cell.AgentType.text = "Unassigned".localized()
            
        }
        else{
           // cell.cellNameLbl.text = info.agentName
            cell.AgentType.text = info.agentName
        }
        let fname = info.memberDetails?.firstName?.capitalized   ?? ""
        let lname = info.memberDetails?.lastName?.capitalized   ?? ""
        cell.partner.text = fname + " " + lname

        cell.cellNameLbl.text = fname + " " + lname
        
        
        cell.cellMailLbl.text = info.memberDetails?.email
        cell.cellPhoneLbl.text = "\(info.memberDetails?.countryCode ?? "") \(info.memberDetails?.mobile ?? "")"
        cell.requestType.text = info.metadata?.type
        var createdOnStr = info.createdOn ?? ""
        createdOnStr = createdOnStr.components(separatedBy: "T")[0]
        cell.date.text = returnDOB(date: createdOnStr)
        
        cell.lblAccepted.text = info.status?.localized()
        cell.lblAccepted.textColor =  Asset.Colors.redColor.color
        cell.acceptedView.backgroundColor = Asset.Colors.grayColor.color
        
        cell.cellMenuBtn.tag = indexPath.row
        cell.cellMenuBtn.addTarget(self, action: #selector(menuActionBtn(_:)), for: .touchUpInside)

        /*
         cell.acceptedView
         cell.lblAccepted
         cell.btncheckBox
         */


        return cell
    }

    @objc func menuActionBtn(_ sender: UIButton ){
        let vc = ViewLeadVC.instantiate(fromAppStoryboard: .leadStoryboard)
        let index = sender.tag
        
        let info = leadListArr[index]
        vc.index = sender.tag
        vc.insuranceType = info.metadata?.type ?? ""
        vc.checkInsuranceDelegate = self
        vc.checkProposalDelegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    

}

extension LeadListVC : checkInsuranceTypeDelegate, checkProposalDelegate{
    func checkInsuranceType(index: Int, insuranceType: String) {
        
        if insuranceType == "HEALTH"{
//            let vc = HealthInsuranceVC.instantiate(fromAppStoryboard: .leadStoryboard)
//            let info = leadListArr[index]
//            vc.leadId = info.leadId ?? ""
//            pushToVC(vc, animated: true)
            let vc = HealthFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.agentId = info.agentId ?? ""
            vc.status = info.status ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "TERM_LIFE"{
            let vc = TermLifeVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
           // vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "GENERAL"{
            let vc = GeneralRequestVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            //vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "TRAVEL"{
//            let vc = TravelInsuranceVC.instantiate(fromAppStoryboard: .leadStoryboard)
//            let info = leadListArr[index]
//            vc.leadId = info.leadId ?? ""
//            pushToVC(vc, animated: true)
            let vc = TravelFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.agentId = info.agentId ?? ""
            vc.status = info.status ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "BUILDING"{
            let vc = BuildingFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.agentId = info.agentId ?? ""
            vc.status = info.status ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "BUSINESS_LEGAL_PROTECTION"{
            let vc = LegalProtectionBusinessFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "THIRD_PILLAR"{
            let vc = ThirdPillarFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        } else if insuranceType == "BUSINESS_COMPANY_THINGS"{
            let vc = CompaniesThingsVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "ANIMAL"{
            let vc = AnimalFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "RC_HOUSEHOLD"{
            let vc = HouseHoldRcVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "HOUSING_RENTAL"{
            let vc = HousingRentalVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "QUOTATION_REQUEST"{
            let vc = QuotationFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "LEGAL_PROTECTION"{
            let vc = LegalProtectionVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "MOTOR_VEHICLE"{
            let vc = MotorVehicleFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "CONSTRUCTION"{
            let vc = ConstructionVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            vc.status = info.status ?? ""
            vc.agentId = info.agentId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "Proposal"{
            let vc = LeadProposalsVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.insurnceType = info.metadata?.type ?? ""
            vc.leadId = info.leadId ?? ""
            vc.agentName = info.agentName ?? ""
            
            vc.agentId = info.agentId ?? ""
            vc.status = info.status ?? ""
            
            var memberNames = NSMutableArray()
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            
            memberNames.add(fName + " " + lName)
            UserDefaults.standard.set(fName + " " + lName, forKey: "memebrNameArr")
            
            var memberIds = NSMutableArray()
            
            memberIds.add(info.memberDetails?.memberId ?? "")
//            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(memberIds), forKey: "memberIds")

            UserDefaults.standard.set(memberIds, forKey: "memberIds")
            
            
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "SelectAgent" {
         
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                
                let vc = CustomerAssignVC.instantiate(fromAppStoryboard: .customerStoryboard)
                vc.leadAgentAssignDelegate = self
                let info = leadListArr[index]
                vc.customerAgentArr = self.customerAgentArr
                vc.isComingFrom = "LeadVC"
                vc.agentId = info.agentId ?? "" //self.customerListArr[listIndex].userId ?? ""
                vc.leadId = info.leadId ?? ""
                vc.partnerId = info.partnerId ?? ""
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
                  vc.leadAgentAssignDelegate = self
                  let info = leadListArr[index]
                  vc.customerAgentArr = self.customerAgentArr
                  vc.isComingFrom = "LeadVC"
                  vc.agentId = info.agentId ?? "" //self.customerListArr[listIndex].userId ?? ""
                  vc.leadId = info.leadId ?? ""
                  vc.partnerId = info.partnerId ?? ""
         
    
                  vc.modalTransitionStyle = .crossDissolve
                  vc.modalPresentationStyle = .overFullScreen
           
                  self.present(vc, animated: true)
              } else {
                  self.ShowAlert(message: "You don't have write permissions. Please contact your partner".localized())

              }

        }
        
        else {
            print(index,insuranceType)
            
        }
        
    }
    
    
}

//MARK:- extension for assign agent

extension LeadListVC : LeadAgentAssignCallback{
   
    
    func setCustomerList(data: CustomerModel) {
        print("customer")
    }
    
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
    
    func onLeadAssignAgentData(data: SuccessModel) {
        if data.data?.status == "SUCCESS" {
            let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
            print("success")
            ApiCallingFunc(status: "")
            //
        }
    }

}

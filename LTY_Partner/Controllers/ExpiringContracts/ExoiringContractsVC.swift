//
//  ExoiringContractsVC.swift
//  LTY_Partner
//
//  Created by CTS on 01/08/23.
//

import UIKit

class ExoiringContractsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var tableVieww: UITableView!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNvaBar: CustomNavigationBarForDrawer!
    
    var proposalVM = ProposalViewModel()
    var expiredLisArr = [SubmissionProposalsList]()
    var withinMonth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setDrowerHeight()
        customNvaBar.titleLabel.text = "Expiring Contracts".localized()
        customNvaBar.titleLabel.textAlignment = .center
        customNvaBar.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNvaBar.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        tableVieww.register(UINib(nibName: "HomeExpiringTVC", bundle: .main), forCellReuseIdentifier: "HomeExpiringTVC")
        
        proposalVM.expireDelegate = self
        proposalListApiCall(state: "", withInMonth: self.withinMonth)
        if withinMonth == 1 {
            self.filterLbl.text = "Expiring in 1 Month".localized()
        } else if withinMonth == 2 {
            self.filterLbl.text = "Expiring in 2 Month".localized()
        }else if withinMonth == 0 {
            self.filterLbl.text = "Expired".localized()
        } else {
            self.filterLbl.text = "Expiring in 3 Month".localized()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true

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
    
    @IBAction func onClickFilter(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let martialArr = ["Expired".localized(),"Expiring in 1 Month".localized(), "Expiring in 2 Month".localized(), "Expiring in 3 Month".localized()]
        
        for item in martialArr {
            
            let action = UIAlertAction(title: item, style: .default) { (action) in
                
                self.filterLbl.text = item
                if item == "Expiring in 1 Month".localized() {
                    self.proposalListApiCall(state: "", withInMonth: 1)
                } else if item == "Expiring in 2 Month".localized() {
                    self.proposalListApiCall(state: "", withInMonth: 2)
                } else if item == "Expiring in 3 Month".localized(){
                    self.proposalListApiCall(state: "", withInMonth: 3)
                } else if item == "Expired".localized(){
                    self.proposalListApiCall(state: "", withInMonth: 0)
                }else {
                    self.proposalListApiCall(state: "", withInMonth: 0)
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
    
    
    //MARK:- Api call func
      
    func proposalListApiCall(state:String, withInMonth: Int) {
        print("success3",withInMonth)
          var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
          if entityType as! String == "AGENT"{
              entityType = "AGENT_ID"
          } else if entityType as! String == "PARTNER"{
              entityType = "PARTNER_ID"
          }
          let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
          let param:[String: Any] = ["entityType": entityType,"entityId": partnerId, "expiringWithinMonth": withInMonth, "pageSize": 25, "pageCount": 1]
          
        proposalVM.expiredProposalListApi(param: param, withInMonth: withInMonth)
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expiredLisArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableVieww.dequeueReusableCell(withIdentifier: "HomeExpiringTVC", for: indexPath) as! HomeExpiringTVC
        cell.selectionStyle = .none
        
        let info = self.expiredLisArr[indexPath.row]
    
        let fName = info.memberDetails?.firstName?.capitalized   ?? ""
        let lName = info.memberDetails?.lastName?.capitalized   ?? ""
        cell.cellAgentNameLbl.text = fName + " " + lName
        cell.lblType.text = info.insuranceType ?? ""
        cell.lblAgentName.text = info.agentDetails?.agentName ?? "Unassigned".localized()
        cell.lblPolicyNo.text = info.policyDetails?.policyId ?? ""
        cell.lblSubCat.text = info.policyDetails?.categoryDetails?.subCategoryName ?? ""
        
        var dob = "\(info.memberDetails?.dob ?? "")"
        dob = dob.components(separatedBy: "T")[0]
        cell.lblDate.text = returnDOB(date: dob)
        var StartDob = "\(info.policyDetails?.startDate ?? "" ?? "")"
        StartDob = StartDob.components(separatedBy: "T")[0]
        var endDob = "\(info.policyDetails?.endDate ?? "")"
        endDob = endDob.components(separatedBy: "T")[0]
        cell.lblStartDate.text = returnDOB(date: StartDob)
        cell.lblEndDate.text = returnDOB(date: endDob)
        
        
        cell.cellViewBtn.tag = indexPath.row
        cell.cellViewBtn.addTarget(self, action: #selector(expiryMenuAction(_:)), for: .touchUpInside)
        
        return cell
        
        
    }

    //MARK:-  expiry menu action btn
    
    @objc func expiryMenuAction(_ sender: UIButton ){
        let vc = ContractDetailVC.instantiate(fromAppStoryboard: .customerStoryboard)
        
//        let info = expiredLisArr[sender.tag]
//
//        let fName = info.memberDetails?.firstName ?? ""
//        let lName = info.memberDetails?.lastName ?? ""
//        let signedDocs = info.signedDoc ?? []
//        let policyDocs = info.policyDetails?.policyDocs ?? []
//        vc.contractDictArr.append(ContractDetailModel.init(name: fName + " " + lName, endDate: info.policyDetails?.endDate ?? "", startDate:  info.policyDetails?.startDate ?? "", sumAssured: "", totalDuration: "", personCovered: "", benifits:info.policyDetails?.productBenefits ?? "", premiumTerm: info.policyDetails?.premiumAmount ?? 0, periodicity: info.commissionDetails?.frequency ?? "", email:  info.memberDetails?.email ?? "", agentName:  info.agentDetails?.agentName ?? "", policyNumber:  info.policyDetails?.policyId ?? "", policyName:info.policyDetails?.policyType ?? "", signedDoc: signedDocs, policyDoc: policyDocs))
//
//        pushToVC(vc, animated: true)
        
        let info = self.expiredLisArr[sender.tag]
        
        let fName = info.memberDetails?.firstName?.capitalized   ?? ""
        let lName = info.memberDetails?.lastName?.capitalized   ?? ""
        let signedDocs = info.signedDoc ?? []
        let policyDocs = info.policyDetails?.policyDocs ?? []
        let contractDoc = info.contractDoc ?? []
        vc.contractDictArr.append(ContractDetailModel.init(totalAmount:info.policyDetails?.totalAmount ?? 0, category:info.policyDetails?.categoryDetails?.categoryName ?? "", subCategory:info.policyDetails?.categoryDetails?.subCategoryName ?? "", name: fName + " " + lName, endDate: info.policyDetails?.endDate ?? "", startDate:  info.policyDetails?.startDate ?? "", sumAssured: "", totalDuration: "", personCovered: "", benifits:info.policyDetails?.productBenefits ?? "", premiumTerm: info.policyDetails?.premiumAmount ?? 0, periodicity:  info.policyDetails?.periodicity ?? "", email:  info.memberDetails?.email ?? "", agentName:  info.agentDetails?.agentName ?? "", policyNumber:  info.policyDetails?.policyId ?? "", policyName:info.policyDetails?.policyType ?? "", signedDoc: signedDocs, policyDoc: policyDocs,contractDoc: contractDoc))
        self.pushToVC(vc, animated: true)
    }
}

extension ExoiringContractsVC: ExpiredProposalListProtocolDelegate {
    //MARK:- set expired Data
    
    func setExpiredProposalList(data: SubmissionModel, withInMonth: Int) {
        
        if data.status == "SUCCESS"{
            self.expiredLisArr.removeAll()
            self.expiredLisArr = data.data?.proposalsList ?? []
            
            DispatchQueue.main.async {
                self.tableVieww.reloadData()
            }
        } else{
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

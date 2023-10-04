//
//  HouseHoldRcVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/08/23.
//

import UIKit

class HouseHoldRcVC: UIViewController {
    //MARK:- title outlets
    @IBOutlet weak var lblTitlePersnalInfo: UILabel!

    @IBOutlet weak var lblTitlePersnalInfoFullName: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoEmail: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoMobile: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoDob: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoNationality: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoCity: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoAddress: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoPartner: UILabel!
    @IBOutlet weak var lblTitlePersnalInfoagent: UILabel!
    @IBOutlet weak var lblTitleMemberInfoFullName: UILabel!
    @IBOutlet weak var lblHeadingMemberInfo: UILabel!
    @IBOutlet weak var lblTitleMemberInfoRelation: UILabel!
    @IBOutlet weak var lblTitleMemberInfoInsuranceType: UILabel!
    
    @IBOutlet weak var lblHeadingCustomerData: UILabel!
    @IBOutlet weak var titleLblFullName: UILabel!
    @IBOutlet weak var titleLblAddress: UILabel!
    @IBOutlet weak var titleLblDob: UILabel!
    @IBOutlet weak var titleLblNationality: UILabel!
    @IBOutlet weak var titleLblMaterialStatus: UILabel!
    @IBOutlet weak var titleLblDuration: UILabel!
    @IBOutlet weak var titleLblEffectiveDate: UILabel!
    @IBOutlet weak var lblHeadeingFurniture: UILabel!
    @IBOutlet weak var lblHeadingRiskPlace: UILabel!
    @IBOutlet weak var titleLblBonusProtection: UILabel!
    @IBOutlet weak var titleLblSumInsured: UILabel!
    @IBOutlet weak var titleLblConstruction: UILabel!
    @IBOutlet weak var titleLblBenifits: UILabel!
    @IBOutlet weak var titleLblCivil: UILabel!
    @IBOutlet weak var titleLblsum: UILabel!
    @IBOutlet weak var titleLblFranchisesum: UILabel!
    @IBOutlet weak var titleLblOwnwer: UILabel!
    @IBOutlet weak var lblHeadingRC: UILabel!
    @IBOutlet weak var titleLblRC: UILabel!
    @IBOutlet weak var lblHeadingQuiz: UILabel!
    @IBOutlet weak var titleLblPastInsured: UILabel!
    @IBOutlet weak var titleLblClaims: UILabel!
    @IBOutlet weak var titleLblInsuranceProposal: UILabel!

    @IBOutlet weak var titleLblRemarks: UILabel!

    @IBOutlet weak var titleLblcopmpanyNamePolicy: UILabel!
    @IBOutlet weak var titleLblNonInsurance: UILabel!
    @IBOutlet weak var titleLblSpecifyClaim: UILabel!
    
    //MARK:- text outlets
    @IBOutlet weak var lblPersnalInfoFullName: UILabel!
    @IBOutlet weak var lblPersnalInfoEmail: UILabel!
    @IBOutlet weak var lblPersnalInfoMobile: UILabel!
    @IBOutlet weak var lblPersnalInfoDob: UILabel!
    @IBOutlet weak var lblPersnalInfoNationality: UILabel!
    @IBOutlet weak var lblPersnalInfoCity: UILabel!
    @IBOutlet weak var lblPersnalInfoAddress: UILabel!
    @IBOutlet weak var lblPersnalInfoPartner: UILabel!
    @IBOutlet weak var lblPersnalInfoagent: UILabel!
    @IBOutlet weak var lblMemberInfoFullName: UILabel!
    @IBOutlet weak var lblMemberInfoRelation: UILabel!
    @IBOutlet weak var lblMemberInfoInsuranceType: UILabel!
    
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblMaterialStatus: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblBonusProtection: UILabel!
    @IBOutlet weak var lblSumInsured: UILabel!
    @IBOutlet weak var lblConstruction: UILabel!
    @IBOutlet weak var lblBenifits: UILabel!
    @IBOutlet weak var lblCivil: UILabel!
    @IBOutlet weak var lblsum: UILabel!
    @IBOutlet weak var lblFranchisesum: UILabel!
    @IBOutlet weak var lblOwnwer: UILabel!
    @IBOutlet weak var lblRC: UILabel!
    @IBOutlet weak var lblPastInsured: UILabel!
    @IBOutlet weak var lblClaims: UILabel!
    @IBOutlet weak var lblInsuranceProposal: UILabel!
    @IBOutlet weak var SpecifyClaimView: UIView!
    @IBOutlet weak var nonInsuranceview: UIView!
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var lblRemarks: UILabel!

    @IBOutlet weak var lblcopmpanyNamePolicy: UILabel!
    @IBOutlet weak var lblNonInsurance: UILabel!
    @IBOutlet weak var lblSpecifyClaim: UILabel!
    
    var leadId = ""
    var leadInsuranceViewModel = LeadInsuranceViewModel()
    
    
    var categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    var categoryListNewData = [MainCategoryNewList]()
    var isCategoryAdded = false
    var insurnceType = ""
    var agentName = ""
    var agentId = ""
    var status = ""
    var proposalIdArr = [String]()
    
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDrowerHeight()
        if self.status == "CLOSED" || self.status == "ACCEPTED"{
           
        }else{
            floatingButton()
        }
        setUpLocalization()
        
        leadInsuranceViewModel.homeHoldRCDelegate = self
        
        customNavDrower.titleLabel.text = "Basic Insurance information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    
    func setUpLocalization() {
        self.lblTitlePersnalInfo.text = "Personal Information".localized()
        self.lblTitlePersnalInfoFullName.text = "Full Name".localized()
        self.lblTitlePersnalInfoEmail.text = "Email".localized()
        self.lblTitlePersnalInfoMobile.text = "Phone Number".localized()
        self.lblTitlePersnalInfoDob.text = "Date of Birth".localized()
        self.lblTitlePersnalInfoNationality.text = "Nationality".localized()
        self.lblTitlePersnalInfoCity.text = "City".localized()
        self.lblTitlePersnalInfoAddress.text = "Street Address".localized()
        self.lblTitlePersnalInfoPartner.text = "Partner".localized()
        self.lblTitlePersnalInfoagent.text = "Agent".localized()
        self.lblTitleMemberInfoFullName.text = "Member name".localized()
        self.lblTitleMemberInfoRelation.text = "Relation".localized()
        self.lblTitleMemberInfoInsuranceType.text = "insurance Type".localized()
        self.lblHeadingMemberInfo.text = "Member Information".localized()
        
        self.lblHeadingCustomerData.text = "Customer Data".localized()
        self.titleLblFullName.text = "Full Name".localized()
        self.titleLblAddress.text = "Address".localized()
        self.titleLblDob.text = "Date of Birth".localized()
        self.titleLblNationality.text = "Nationality/Permit".localized()
        self.titleLblMaterialStatus.text = "Marital Status".localized()
        self.titleLblDuration.text = "Duration".localized()
        self.titleLblEffectiveDate.text = "Effective Date".localized()
        self.lblHeadeingFurniture.text = "Furniture Inventory".localized()
        self.lblHeadingRiskPlace.text = "PLACE OF RISK".localized()
        self.titleLblBonusProtection.text = "Bonus Protection".localized()
        self.titleLblSumInsured.text = "Sum insured".localized()
        self.titleLblConstruction.text = "Type of Construction".localized()
        self.titleLblBenifits.text = "Benefits".localized()
        self.titleLblCivil.text = "Civil Liability".localized()
        self.titleLblsum.text = "Sum".localized()
        self.titleLblFranchisesum.text = "Franchise Sum".localized()
        self.titleLblOwnwer.text = "Are You the Owner?".localized()
        self.lblHeadingRC.text = "RC complementary covers".localized()
        self.titleLblRC.text = "Occasional use of motor vehicles belonging to third parties:".localized()
        self.lblHeadingQuiz.text = "Quiz (concerns the last 5 years)".localized()
        self.titleLblPastInsured.text = "Are you or were you in the past insured for the branches offered? If so, with which company, police no?".localized()
        self.titleLblClaims.text = "Have you suffered any claims in the proposed branches?".localized()
        self.titleLblInsuranceProposal.text = "Were you refused an insurance proposal for the branches offered or was its acceptance/continuation of the contract dependent on aggravated conditions?".localized()

        self.titleLblRemarks.text = "Remarks".localized()

        self.titleLblcopmpanyNamePolicy.text = "Company Name/Policy Number".localized()
        self.titleLblNonInsurance.text = "What is the reason for this non-insurance (if age over 35)?".localized()
        self.titleLblSpecifyClaim.text = "Specify the Claims".localized()
    }
    
    func floatingButton(){
        let btn = UIButton(type: .custom)
        let width = UIScreen.main.bounds.width - 20
        let height = UIScreen.main.bounds.height - 50
        btn.frame = CGRect(x: 10, y: height, width: width, height: 50)
        btn.setTitle("Add Proposal".localized(), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.2343253941, green: 0.4656714117, blue: 0.891181947, alpha: 1)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 3.0
        btn.addTarget(self,action: #selector(addProposalBtn(_:)), for:.touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func addProposalBtn(_ sender: UIButton){
        print("Add Proposal")
        categoryViewModel.delegate = self
        categoryViewModel.categoryListByAgentDelegate = self
        dispatchGroup.enter()
        if self.agentId == "" {
            let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
            let param :[String:Any]  = ["partnerId":PartnerId]
            categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)
        } else {
            let param :[String:Any]  = ["agentId":self.agentId]
            categoryViewModel.getCatByAgent(param: param, url: LTY_END_POINT_URL.getCategoryByAgent)
        }
        
        
        dispatchGroup.notify(queue: .main) {
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            if !self.isCategoryAdded {
                if userType == "PARTNER"{
                    self.showAlertWithActions(msg: "Please add category commission of the agent.".localized(), titles: ["Yes".localized(), "Not Now".localized()]) { (value) in
                        if value == 1{
                            let vc = AgentVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                            self.pushToVC(vc, animated: true)
                        }
                    }
                }else{
                    self.showOkAlertWithHandler("Please contact your partner".localized()) {
                        self.popVC(animated: true)
                    }
                }


                return
            }
            
            guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                let vc = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
               // vc.isComingFrom = "LeadProposalVC"
                vc.shouldAddLead = true
                vc.leadId = self.leadId
                vc.insurnceType = self.insurnceType
                vc.agentId = self.agentId
                vc.agentName = self.agentName
                shouldEditMembers = false
                UserDefaults.standard.set("yes", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
                return
            }

            let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

            let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
         //   let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

            if (checkAccess.1 && userType == "AGENT") || userType == "PARTNER" {
           
                
                let vc = SecondViewController.instantiate(fromAppStoryboard: .proposalStoryboard)
               // vc.isComingFrom = "LeadProposalVC"
                vc.shouldAddLead = true
                vc.leadId = self.leadId
                vc.insurnceType = self.insurnceType
                vc.agentId = self.agentId
                vc.agentName = self.agentName
                shouldEditMembers = false
                UserDefaults.standard.set("yes", forKey: "fromLead")
                self.pushToVC(vc, animated: true)
            }
            else{
                self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
                
            }

            
        }
        

    }


    
    override func viewWillAppear(_ animated: Bool) {
        let param:[String:Any] = ["leadId":leadId]
        leadInsuranceViewModel.HouseHoldRCApiCall(param: param)
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

extension HouseHoldRcVC : HomeHoldRCProtectionData {

  
    func setData(data: HouseHoldRCModel) {
        
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                
                
                let persnalInfo = data.data?.memberDetails
                let fName =  persnalInfo?.firstName?.capitalized   ?? ""
                let lName =  persnalInfo?.lastName?.capitalized    ?? ""
                
                self.lblPersnalInfoFullName.text = fName + " " + lName
                self.lblPersnalInfoEmail.text = persnalInfo?.email  ?? ""
                let countryCode = persnalInfo?.countryCode ?? ""
                self.lblPersnalInfoMobile.text = "\(countryCode) \(persnalInfo?.mobile ?? "")"
             //   self.lblPersnalInfoMobile.text = persnalInfo?.mobile  ?? ""
                self.lblPersnalInfoDob.text =  returnDOB(date: persnalInfo?.dob  ?? "")//persnalInfo?.dob  ?? ""
                self.lblPersnalInfoNationality.text = persnalInfo?.country  ?? ""
                self.lblPersnalInfoCity.text = persnalInfo?.city  ?? ""
                self.lblPersnalInfoAddress.text = persnalInfo?.address  ?? ""
                self.lblPersnalInfoPartner.text = data.data?.partnerName
                self.lblPersnalInfoagent.text = data.data?.agentName   ?? ""
                self.lblMemberInfoFullName.text = data.data?.memberName
                self.lblMemberInfoRelation.text = data.data?.relation  ?? ""
                self.lblMemberInfoInsuranceType.text = data.data?.insuranceType?.localized() ?? ""
                
                let responseData = data.data?.metadata?.personalDetails
                let fname =  responseData?.firstName?.capitalized   ?? ""
                let lname =  responseData?.lastName?.capitalized    ?? ""
                
                let metaData = data.data?.metadata
                
                self.lblFullName.text = fName + " " + lname ?? ""
                self.lblAddress.text = responseData?.address ?? ""
                self.lblDob.text = responseData?.dob ?? ""
                self.lblNationality.text = responseData?.countryCode ?? ""
                self.lblMaterialStatus.text = responseData?.maritalStatus ?? ""
                self.lblDuration.text = responseData?.duration ?? ""
                self.lblEffectiveDate.text = responseData?.effectiveDate ?? ""
                self.lblSumInsured.text = metaData?.sumInsured ?? ""
                self.lblConstruction.text = metaData?.typeOfConstruction ?? ""
                self.lblCivil.text = responseData?.civilStatus ?? ""
                self.lblsum.text = metaData?.sum ?? ""
                self.lblFranchisesum.text = metaData?.franchise ?? ""
                self.lblOwnwer.text = metaData?.areYouOwner ?? ""
                let covers = metaData?.complementaryCovers ?? []
                var coversArr = NSMutableArray()
                for item in covers {
                    coversArr.add(item)
                }
                self.lblRC.text = coversArr.componentsJoined(by: ", ")
                self.lblPastInsured.text = metaData?.pastInsured ?? ""
                self.lblClaims.text = metaData?.anyClaim ?? ""
                self.lblRemarks.text = metaData?.remarks ?? ""
                
                self.lblInsuranceProposal.text = metaData?.wereYouRefused ?? ""
//                self.lblBonusProtection.text = metaData.
                let benefits = metaData?.benefits ?? []
                var benefitsCoversArr = NSMutableArray()
                for item in benefits {
                    benefitsCoversArr.add(item)
                }
                self.lblBenifits.text = benefitsCoversArr.componentsJoined(by: ", ")
                
                self.lblcopmpanyNamePolicy.text = metaData?.company
                self.lblNonInsurance.text = metaData?.reason
                self.lblSpecifyClaim.text = metaData?.specifyTheClaim

                if metaData?.pastInsured ?? ""  == "Yes" {
                    self.companyNameView.isHidden = false
                }else{
                    self.companyNameView.isHidden = true
                }
                if metaData?.anyClaim ?? "" == "Yes" {
                    self.SpecifyClaimView.isHidden = false
                }else{
                    self.SpecifyClaimView.isHidden = true
                }

                
                
             
            }
        }else{
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
    
    
}

extension HouseHoldRcVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
    func setCategoryListByAgent(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListNewData.removeAll()

            self.categoryListNewData = data.data?.categoryList ?? []
            self.isCategoryAdded = self.categoryListNewData.count > 0 ? true : false
            
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
        
        dispatchGroup.leave()
      
    }
   
    func setCategoryList(data: CategoryModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()

            self.categoryListData = data.data?.categoryList ?? []
            self.isCategoryAdded = self.categoryListData.count > 0 ? true : false
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
        dispatchGroup.leave()
      
    }
    
    
    func setCategoryNewList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()

            self.categoryListNewData = data.data?.categoryList ?? []
            self.isCategoryAdded = self.categoryListNewData.count > 0 ? true : false
            
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
        dispatchGroup.leave()
      
    }
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
        
    }
    
//    func setActiveUsersList(data: AddProposalMembersModel) {
//
//        if data.status == "SUCCESS" {
//
//
//            var memberList = data.data?.usersList ?? []
//            if memberList.count == 0 {
//                self.showOkAlert("This Agent does not have members associated. You can't proceed with proposal creation. Please select any other Agent.")
//            }
//
//        } else {
//            DispatchQueue.main.async {
//                  if data.error?.errorCode == AppKeys.invalidTokenCode {
//
//                      LTY_AppDelegate.setRootVC()
//                  }else {
//                      self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
//                  }
//              }
//          }
//    }
    
    
}

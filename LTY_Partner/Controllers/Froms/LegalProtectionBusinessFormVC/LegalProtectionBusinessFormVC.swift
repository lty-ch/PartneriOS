//
//  LegalProtectionBusinessFormVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/08/23.
//

import UIKit

class LegalProtectionBusinessFormVC: UIViewController {
    // MarK:- Title Outlets
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
    
    @IBOutlet weak var titleLblProposalType: UILabel!
    @IBOutlet weak var titleLblFontData: UILabel!
    @IBOutlet weak var titleLblReplcaeFonts: UILabel!
    @IBOutlet weak var lblHeadingCompData: UILabel!
    @IBOutlet weak var titleLblBusiness: UILabel!
    @IBOutlet weak var titleLblEmail: UILabel!
    @IBOutlet weak var titleLblphone: UILabel!
    @IBOutlet weak var titleLblStreetNo: UILabel!
    @IBOutlet weak var titleLblZipLocation: UILabel!
    @IBOutlet weak var titleLblResponsible: UILabel!
    @IBOutlet weak var titleLblSatrtOfContract: UILabel!
    @IBOutlet weak var titleLblEffectiveDate: UILabel!
    @IBOutlet weak var lblHeadingProposalQuestion: UILabel!
    @IBOutlet weak var titleLblInsuredPerson: UILabel!

    @IBOutlet weak var titleLblReasonContract: UILabel!
    @IBOutlet weak var titleLblFromCompName: UILabel!
    @IBOutlet weak var titleLblRisk: UILabel!
    @IBOutlet weak var titleLblInsuredCurrently: UILabel!
    @IBOutlet weak var lblHEadingDurationContract: UILabel!
    @IBOutlet weak var titleLblStartDate: UILabel!
    @IBOutlet weak var titleLblEndDate: UILabel!
    @IBOutlet weak var titleLblExpiryDate: UILabel!
    
    //MARK:- Text outlets
    
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
    
    
    @IBOutlet weak var lblProposalType: UILabel!
    @IBOutlet weak var lblFontData: UILabel!
    @IBOutlet weak var lblReplcaeFonts: UILabel!
    @IBOutlet weak var lblBusiness: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblStreetNo: UILabel!
    @IBOutlet weak var lblZipLocation: UILabel!
    @IBOutlet weak var lblResponsible: UILabel!
    @IBOutlet weak var lblSatrtOfContract: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblInsuredPerson: UILabel!
    @IBOutlet weak var riskView: UIView!
    @IBOutlet weak var fromCompanyView: UIView!
    @IBOutlet weak var reasonForterminatView: UIView!
    @IBOutlet weak var lblReasonContract: UILabel!
    @IBOutlet weak var lblFromCompName: UILabel!
    @IBOutlet weak var lblRisk: UILabel!
    @IBOutlet weak var lblInsuredCurrently: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDrowerHeight()
        
        if self.status == "CLOSED" || self.status == "ACCEPTED"{
            
        }else{
            floatingButton()
        }
        setLocalization()
        
        leadInsuranceViewModel.buildingLegalProtectionDelgate = self
        
        customNavDrower.titleLabel.text = "Basic Insurance information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    func setLocalization () {
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
        
        self.titleLblProposalType.text = "Proposal Type".localized()
        self.titleLblFontData.text = "Font Data".localized()
        self.titleLblReplcaeFonts.text = "Replace font(s)".localized()
        self.lblHeadingCompData.text = "Company Data".localized()
        self.titleLblBusiness.text = "Business".localized()
        self.titleLblEmail.text = "Email".localized()
        self.titleLblphone.text = "Phone".localized()
        self.titleLblStreetNo.text = "Street/No. ".localized()
        self.titleLblZipLocation.text = "ZIP Location".localized()
        self.titleLblResponsible.text = "Responsible".localized()
        self.titleLblSatrtOfContract.text = "Start of the Contract:".localized()
        self.titleLblEffectiveDate.text = "Effective Date ".localized()
        self.lblHeadingProposalQuestion.text = "Proposal Questions".localized()
        self.titleLblInsuredPerson.text = "Have you or has an “insured person” insured for legal protection in the last three years and has the policy been canceled by the insurance company?".localized()

        self.titleLblReasonContract.text = "Reason for terminating the contract?".localized()
        self.titleLblFromCompName.text = "From which company?".localized()
        self.titleLblRisk.text = "For what risks?".localized()
        self.titleLblInsuredCurrently.text = "Is a person to be insured currently involved in litigation or has it been in the last three years or do you know that a person to be insured will soon be?".localized()
        self.lblHEadingDurationContract.text = "Duration of the contract".localized()
        self.titleLblStartDate.text = "Start Date".localized()
        self.titleLblEndDate.text = "End Date".localized()
        self.titleLblExpiryDate.text = "Expire Date".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let param:[String:Any] = ["leadId":leadId]
        leadInsuranceViewModel.leagalBusinessProtectionApiCall(param: param)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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

extension LegalProtectionBusinessFormVC : SetBuildingLegalProtectionData {
    func setData(data: BusinessLegalProModel) {
        
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                
                
                let persnalInfo = data.data?.memberDetails
                let fName =  persnalInfo?.firstName?.capitalized   ?? ""
                let lName =  persnalInfo?.lastName?.capitalized    ?? ""
                
                self.lblPersnalInfoFullName.text = fName + " " + lName
                self.lblPersnalInfoEmail.text = persnalInfo?.email  ?? ""
                let countryCode = persnalInfo?.countryCode ?? ""
                self.lblPersnalInfoMobile.text = "\(countryCode) \(persnalInfo?.mobile ?? "")"
            //    self.lblPersnalInfoMobile.text = persnalInfo?.mobile  ?? ""
                self.lblPersnalInfoDob.text = returnDOB(date: persnalInfo?.dob  ?? "")//persnalInfo?.dob  ?? ""
                self.lblPersnalInfoNationality.text = persnalInfo?.country  ?? ""
                self.lblPersnalInfoCity.text = persnalInfo?.city  ?? ""
                self.lblPersnalInfoAddress.text = persnalInfo?.address  ?? ""
                self.lblPersnalInfoPartner.text = data.data?.partnerName
                self.lblPersnalInfoagent.text = data.data?.agentName   ?? ""
                self.lblMemberInfoFullName.text = data.data?.memberName
                self.lblMemberInfoRelation.text = data.data?.relation  ?? ""
                self.lblMemberInfoInsuranceType.text = data.data?.insuranceType?.localized() ?? ""
                
                
                
                let responseData = data.data
                
                self.lblProposalType.text =  responseData?.metadata?.type ?? ""
                self.lblFontData.text =  responseData?.metadata?.fontData ?? ""
                self.lblReplcaeFonts.text = responseData?.metadata?.replaceFont ?? ""
                
                let companyDetails = responseData?.metadata?.companyDetails
                
                self.lblBusiness.text = companyDetails?.business ?? ""
                self.lblEmail.text = companyDetails?.email ?? ""
                let countryCode12 = companyDetails?.countryCode ?? ""
                self.lblphone.text = "\(countryCode12) \(companyDetails?.phone ?? "")"
               // self.lblphone.text = companyDetails?.phone ?? ""
                self.lblStreetNo.text = companyDetails?.streetNo ?? ""
                self.lblZipLocation.text = companyDetails?.zipLocation ?? ""
                self.lblResponsible.text = companyDetails?.responsible ?? ""
                self.lblSatrtOfContract.text = companyDetails?.startOfContract ?? ""
                self.lblEffectiveDate.text = companyDetails?.effectiveDate ?? ""
              
                self.lblInsuredCurrently.text = responseData?.metadata?.involvedInLitigation ?? ""
                self.lblStartDate.text = responseData?.metadata?.startDate ?? ""
                self.lblEndDate.text = responseData?.metadata?.endDate ?? ""
                self.lblExpiryDate.text = responseData?.metadata?.expireDate ?? ""
                
                self.lblInsuredPerson.text = ""
                
                if responseData?.metadata?.insuredForLegal == "yes" {
                    self.riskView.isHidden = false
                    self.fromCompanyView.isHidden = false
                    self.reasonForterminatView.isHidden = false
                    
                    self.lblRisk.text = responseData?.metadata?.insuredDetails?.risk ?? ""
                    self.lblFromCompName.text = responseData?.metadata?.insuredDetails?.company ?? ""
                    self.lblReasonContract.text = responseData?.metadata?.insuredDetails?.reason ?? ""
                }
                else {
                    self.riskView.isHidden = true
                    self.fromCompanyView.isHidden = true
                    self.reasonForterminatView.isHidden = true
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

extension LegalProtectionBusinessFormVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

//
//  LegalProtectionVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/08/23.
//

import UIKit

class LegalProtectionVC: UIViewController {
    
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
    
    @IBOutlet weak var TitleLblProposalType: UILabel!
    @IBOutlet weak var TitleLblFontData: UILabel!
    @IBOutlet weak var TitleLblReplcaeFonts: UILabel!
    @IBOutlet weak var lblHeadingPersnalData: UILabel!
    


    @IBOutlet weak var TitleLblFullName: UILabel!
    @IBOutlet weak var TitleLblGender: UILabel!
    @IBOutlet weak var TitleLblMaterialStatus: UILabel!

    @IBOutlet weak var TitleLblBusiness: UILabel!
    @IBOutlet weak var TitleLblEmail: UILabel!
    @IBOutlet weak var TitleLblphone: UILabel!
    @IBOutlet weak var TitleLblFax: UILabel!
    @IBOutlet weak var TitleLblResidencePermit: UILabel!
    @IBOutlet weak var TitleLblNationality: UILabel!
    @IBOutlet weak var TitleLblStreetNo: UILabel!
    @IBOutlet weak var TitleLblzipLocation: UILabel!
    @IBOutlet weak var TitleLblOccupation: UILabel!
    @IBOutlet weak var TitleLblBankCC: UILabel!
    @IBOutlet weak var TitleLblEffectiveDate: UILabel!
    @IBOutlet weak var lblHeadingCobtract: UILabel!
    @IBOutlet weak var TitleLblContract: UILabel!
    @IBOutlet weak var lblHeadingTypeCover: UILabel!
    @IBOutlet weak var TitleLblCoverType: UILabel!


    @IBOutlet weak var lblHeadingProposalQuest: UILabel!
    @IBOutlet weak var TitleLblInsuredPerson: UILabel!
    @IBOutlet weak var TitleLblInsuredCurrently: UILabel!
    @IBOutlet weak var lblHeadingDuration: UILabel!
    @IBOutlet weak var TitleLblStartDate: UILabel!
    @IBOutlet weak var TitleLblEndDate: UILabel!
    @IBOutlet weak var TitleLblExpiryDate: UILabel!

    
    // MARK:- text outlets
    
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
    @IBOutlet weak var lblFax: UILabel!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMaterialStatus: UILabel!
    
    @IBOutlet weak var lblResidencePermit: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblStreetNo: UILabel!
    @IBOutlet weak var lblzipLocation: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var lblBankCC: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblContract: UILabel!
    @IBOutlet weak var lblCoverType: UILabel!
    
    
    @IBOutlet weak var lblInsuredPerson: UILabel!
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
        customNavDrower.titleLabel.text = "Basic Insurance information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        leadInsuranceViewModel.legalProtectionlDelegate = self
    }
    
    func setLocalization() {
        
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
        
        
        self.TitleLblProposalType.text = "Proposal Type".localized()
        self.TitleLblFontData.text = "Font Data".localized()
        self.TitleLblReplcaeFonts.text = "Replace font(s)".localized()
        self.lblHeadingPersnalData.text = "Personal Data".localized()



        self.TitleLblFullName.text = "Full Name".localized()
        self.TitleLblGender.text = "Gender".localized()
        self.TitleLblMaterialStatus.text = "Marital status".localized()

        self.TitleLblBusiness.text = "Marital status".localized()
        self.TitleLblEmail.text = "E-mail".localized()
        self.TitleLblphone.text = "Phone".localized()
        self.TitleLblFax.text = "Fax".localized()
        self.TitleLblResidencePermit.text = "Residence permit".localized()
        self.TitleLblNationality.text = "Nationality".localized()
        self.TitleLblStreetNo.text = "Street/No. ".localized()
        self.TitleLblzipLocation.text = "ZIP Location".localized()
        self.TitleLblOccupation.text = "Occupation".localized()
        self.TitleLblBankCC.text = "Bank/CC".localized()
        self.TitleLblEffectiveDate.text = "Effective Date ".localized()
        self.lblHeadingCobtract.text = "Contract data".localized()
        self.TitleLblContract.text = "Contract".localized()
        self.lblHeadingTypeCover.text = "Type of Covers".localized()
        self.TitleLblCoverType.text = "Cover Type".localized()


        self.lblHeadingProposalQuest.text = "Proposal Questions".localized()
        self.TitleLblInsuredPerson.text = "Have you or has an “insured person” insured for legal protection in the last three years and has the policy been canceled by the insurance company?".localized()
        self.TitleLblInsuredCurrently.text = "Is a person to be insured currently involved in litigation or has it been in the last three years or do you know that a person to be insured will soon be?".localized()
        self.lblHeadingDuration.text = "Duration of the contract".localized()
        self.TitleLblStartDate.text = "Start Date".localized()
        self.TitleLblEndDate.text = "End Date".localized()
        self.TitleLblExpiryDate.text = "Expire Date".localized()
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
        leadInsuranceViewModel.LegalProtectionApiCall(param: param)
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

extension LegalProtectionVC : LegalProtectionProtocolData {
    
    func setData(data: LegalProtectionModel) {
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                
                let persnalInfo = data.data?.memberDetails
                let fName =  persnalInfo?.firstName?.capitalized   ?? ""
                let lName =  persnalInfo?.lastName?.capitalized    ?? ""
                
                self.lblPersnalInfoFullName.text = fName + " " + lName
                self.lblPersnalInfoEmail.text = persnalInfo?.email  ?? ""
                let countryCode = persnalInfo?.countryCode ?? ""
                self.lblPersnalInfoMobile.text = "\(countryCode) \(persnalInfo?.mobile ?? "")"
                // self.lblPersnalInfoMobile.text = persnalInfo?.mobile  ?? ""
                self.lblPersnalInfoDob.text = returnDOB(date: persnalInfo?.dob  ?? "")//persnalInfo?.dob  ?? ""
                self.lblPersnalInfoNationality.text = persnalInfo?.country  ?? ""
                self.lblPersnalInfoCity.text = persnalInfo?.city  ?? ""
                self.lblPersnalInfoAddress.text = persnalInfo?.address  ?? ""
                self.lblPersnalInfoPartner.text = data.data?.partnerName
                self.lblPersnalInfoagent.text = persnalInfo?.agentName   ?? ""
                self.lblMemberInfoFullName.text = data.data?.memberName
                self.lblMemberInfoRelation.text = data.data?.relation  ?? ""
                self.lblMemberInfoInsuranceType.text = data.data?.insuranceType ?? ""
                
                let basicInfo = data.data?.memberDetails
                let fname =  basicInfo?.firstName?.capitalized   ?? ""
                let lname =  basicInfo?.lastName?.capitalized    ?? ""
                self.lblMemberInfoFullName.text = fname + " " + lname
                
                let insuranceInfo = data.data?.metadata
                self.lblProposalType.text = insuranceInfo?.proposalFor ?? ""
                self.lblFontData.text = insuranceInfo?.fontData ?? ""
                self.lblReplcaeFonts.text = insuranceInfo?.replaceFont ?? ""
                self.lblContract.text = insuranceInfo?.contractData ?? ""
                self.lblCoverType.text = insuranceInfo?.typeOfCovers ?? ""
                self.lblInsuredPerson.text = insuranceInfo?.insuredForLegal ?? ""
                self.lblInsuredCurrently.text = insuranceInfo?.involvedInLitigation ?? ""
                self.lblStartDate.text = insuranceInfo?.startDate ?? ""
                self.lblEndDate.text = insuranceInfo?.endDate ?? ""
                self.lblExpiryDate.text = insuranceInfo?.expireDate ?? ""
                
                
                let info = insuranceInfo?.personalDetails
                let personalfname =  info?.firstName?.capitalized   ?? ""
                let personallname =  info?.lastName?.capitalized    ?? ""
                self.lblFullName.text = personalfname + " " + personallname
                self.lblGender.text = info?.gender ?? ""
                self.lblEmail.text = info?.email ?? ""
                self.lblphone.text = info?.mobile ?? ""
                self.lblMaterialStatus.text = info?.maritalStatus ?? ""
                self.lblFax.text = info?.fax ?? ""
                self.lblResidencePermit.text = info?.residencePermit ?? ""
                self.lblNationality.text = info?.nationality ?? ""
                self.lblStreetNo.text = info?.streetNo ?? ""
                self.lblzipLocation.text = info?.postCode ?? ""
                self.lblOccupation.text = info?.occupation ?? ""
                self.lblBankCC.text = info?.bankCc ?? ""
                self.lblEffectiveDate.text = info?.effectiveDate ?? ""
                
                
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


extension LegalProtectionVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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


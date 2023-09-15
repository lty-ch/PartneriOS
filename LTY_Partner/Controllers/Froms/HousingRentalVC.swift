//
//  HousingRentalVC.swift
//  LTY_Partner
//
//  Created by CTS on 09/08/23.
//

import UIKit

class HousingRentalVC: UIViewController {
    
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
//
    @IBOutlet weak var lblHeadingInsuranceData: UILabel!
    @IBOutlet weak var TitleLblFont: UILabel!
    @IBOutlet weak var TitleLblExistingFont: UILabel!
    @IBOutlet weak var TitleLblPaymentMethod: UILabel!
    @IBOutlet weak var TitleLblStartDate: UILabel!
    @IBOutlet weak var TitleLblpremiumDueDate: UILabel!
    @IBOutlet weak var lblTitleApplicant: UILabel!
    @IBOutlet weak var TitleLblLanguage: UILabel!
    @IBOutlet weak var TitleLblApplicantFullName: UILabel!
    @IBOutlet weak var TitleLblApplicantPhone: UILabel!
    @IBOutlet weak var TitleLblApplicantDob: UILabel!
    @IBOutlet weak var TitleLblApplicantEmail: UILabel!
    @IBOutlet weak var TitleLblApplicantOccupation: UILabel!
    @IBOutlet weak var TitleLblApplicantAddress: UILabel!
    @IBOutlet weak var TitleLblApplicantZip: UILabel!
    @IBOutlet weak var TitleLblApplicantNationality: UILabel!
    @IBOutlet weak var TitleLblApplicantResidentPermit: UILabel!
    @IBOutlet weak var TitleLblApplicantEffectiveDate: UILabel!

    @IBOutlet weak var TitleLblOtherUserFullName: UILabel!
    
    @IBOutlet weak var TitleLblOtherUserDob: UILabel!
    @IBOutlet weak var TitleLblOtherUserEmail: UILabel!
    @IBOutlet weak var TitleLblOtherUserMobile: UILabel!
    @IBOutlet weak var TitleLblOtherUserOccupation: UILabel!

    @IBOutlet weak var lblHeadingRentedObject: UILabel!
    @IBOutlet weak var TitleLblRentedAddress: UILabel!
    @IBOutlet weak var TitleLblRentedZip: UILabel!
    @IBOutlet weak var lblHeadingOwner: UILabel!
    @IBOutlet weak var TitleLblLessor: UILabel!
    @IBOutlet weak var TitleLblLessorPhone: UILabel!
    @IBOutlet weak var TitleLblLessorEmail: UILabel!
    @IBOutlet weak var TitleLblLessorStreet: UILabel!
    @IBOutlet weak var TitleLblLessorContactPerson: UILabel!
    @IBOutlet weak var TitleLblLessorZip: UILabel!

    @IBOutlet weak var lblHeadingStewardShip: UILabel!
    @IBOutlet weak var TitleLblStewardManagement: UILabel!
    @IBOutlet weak var TitleLblStewardPhone: UILabel!
    @IBOutlet weak var TitleLblStewardEmail: UILabel!
    @IBOutlet weak var TitleLblStewardStreet: UILabel!
    @IBOutlet weak var TitleLblStewardContact: UILabel!
    @IBOutlet weak var TitleLblStewardZip: UILabel!

    @IBOutlet weak var lblHeadingRentSecurity: UILabel!
    @IBOutlet weak var TitleLblMonthlyRent: UILabel!
    @IBOutlet weak var TitleLblAmountOfDeposit: UILabel!

    @IBOutlet weak var lblHeadingQoestionRelate: UILabel!
    @IBOutlet weak var TitleLblSued: UILabel!
    @IBOutlet weak var TitleLblPattern: UILabel!
    
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
    
    @IBOutlet weak var lblFont: UILabel!
    @IBOutlet weak var lblExistingFont: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblpremiumDueDate: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblApplicantFullName: UILabel!
    @IBOutlet weak var lblApplicantPhone: UILabel!
    @IBOutlet weak var lblApplicantDob: UILabel!
    @IBOutlet weak var lblApplicantEmail: UILabel!
    @IBOutlet weak var lblApplicantOccupation: UILabel!
    @IBOutlet weak var lblApplicantAddress: UILabel!
    @IBOutlet weak var lblApplicantZip: UILabel!
    @IBOutlet weak var lblApplicantNationality: UILabel!
    @IBOutlet weak var lblApplicantResidentPermit: UILabel!
    @IBOutlet weak var lblApplicantEffectiveDate: UILabel!
    
    @IBOutlet weak var lblOtherUserFullName: UILabel!
    @IBOutlet weak var lblOtherUserEmail: UILabel!
    @IBOutlet weak var lblOtherUserMobile: UILabel!
    @IBOutlet weak var lblOtherUserDob: UILabel!
    @IBOutlet weak var lblOtherUserOccupation: UILabel!

    @IBOutlet weak var lblRentedAddress: UILabel!
    @IBOutlet weak var lblRentedZip: UILabel!
    @IBOutlet weak var lblLessor: UILabel!
    @IBOutlet weak var lblLessorPhone: UILabel!
    @IBOutlet weak var lblLessorEmail: UILabel!
    @IBOutlet weak var lblLessorStreet: UILabel!
    @IBOutlet weak var lblLessorContactPerson: UILabel!
    @IBOutlet weak var lblLessorZip: UILabel!
    
    @IBOutlet weak var lblStewardManagement: UILabel!
    @IBOutlet weak var lblStewardPhone: UILabel!
    @IBOutlet weak var lblStewardEmail: UILabel!
    @IBOutlet weak var lblStewardStreet: UILabel!
    @IBOutlet weak var lblStewardContact: UILabel!
    @IBOutlet weak var lblStewardZip: UILabel!
    
    @IBOutlet weak var lblMonthlyRent: UILabel!
    @IBOutlet weak var lblAmountOfDeposit: UILabel!
    
    @IBOutlet weak var lblSued: UILabel!
    @IBOutlet weak var lblPattern: UILabel!
    
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

        leadInsuranceViewModel.houseRentalDelegate = self
        
        setDrowerHeight()
        
        if self.status == "CLOSED" || self.status == "ACCEPTED"{
            
        }else{
            floatingButton()
        }
        setLocalization ()
        customNavDrower.titleLabel.text = "Basic Insurance Information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

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
        leadInsuranceViewModel.HousingRentalApiCall(param: param)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
        
        self.lblHeadingInsuranceData.text = "Insurance Data".localized()
        self.TitleLblFont.text = "Font Data".localized()
        self.TitleLblExistingFont.text = "Existing Font".localized()
        self.TitleLblPaymentMethod.text = "Payment Method".localized()
        self.TitleLblStartDate.text = "Desired start".localized()
        self.TitleLblpremiumDueDate.text = "Premium due date".localized()
        self.lblTitleApplicant.text = "Applicant/Tenant Data".localized()
        self.TitleLblLanguage.text = "Language".localized()
        self.TitleLblApplicantFullName.text = "Full Name".localized()
        self.TitleLblApplicantPhone.text = "Phone Number".localized()
        self.TitleLblApplicantDob.text = "Date of Birth".localized()
        self.TitleLblApplicantEmail.text = "Email".localized()
        self.TitleLblApplicantOccupation.text = "Occupation".localized()
        self.TitleLblApplicantAddress.text = "Address".localized()
        self.TitleLblApplicantZip.text = "Zip Code".localized()
        self.TitleLblApplicantNationality.text = "Nationality".localized()
        self.TitleLblApplicantResidentPermit.text = "Residence Permit".localized()
        self.TitleLblApplicantEffectiveDate.text = "Effective Date".localized()

        self.TitleLblOtherUserFullName.text = "Full Name".localized()

        self.TitleLblOtherUserDob.text = "Date of Birth".localized()
        self.TitleLblOtherUserEmail.text = "Email".localized()
        self.TitleLblOtherUserMobile.text = "Phone Number".localized()
        self.TitleLblOtherUserOccupation.text = "Occupation".localized()

        self.lblHeadingRentedObject.text = "LOCATION OF THE RENTED OBJECT".localized()
        self.TitleLblRentedAddress.text = "Address".localized()
        self.TitleLblRentedZip.text = "Zip Location".localized()
        self.lblHeadingOwner.text = "Lessor/Owner".localized()
        self.TitleLblLessor.text = "Lessor".localized()
        self.TitleLblLessorPhone.text = "Phone Number".localized()
        self.TitleLblLessorEmail.text = "Email".localized()
        self.TitleLblLessorStreet.text = "Street Number".localized()
        self.TitleLblLessorContactPerson.text = "Contact Person".localized()
        self.TitleLblLessorZip.text = "Zip Location".localized()

        self.lblHeadingStewardShip.text = "Stewardship".localized()
        self.TitleLblStewardManagement.text = "Management".localized()
        self.TitleLblStewardPhone.text = "Phone Number".localized()
        self.TitleLblStewardEmail.text = "Email".localized()
        self.TitleLblStewardStreet.text = "Street Number".localized()
        self.TitleLblStewardContact.text = "Contact Person".localized()
        self.TitleLblStewardZip.text = "Zip Location".localized()

        self.lblHeadingRentSecurity.text = "Rent Security".localized()
        self.TitleLblMonthlyRent.text = "Monthly rent in CHF:".localized()
        self.TitleLblAmountOfDeposit.text = "Amount of the deposit (rental guarantee) in CHF:".localized()

        self.lblHeadingQoestionRelate.text = "Questions relating to the proposal".localized()
        self.TitleLblSued.text = "Are you currently being sued? Are other people involved in the lease currently being sued?".localized()
        self.TitleLblPattern.text = "Pattern".localized()

        
        
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
extension HousingRentalVC : HsousingRentalProtectionData {
    
    func setData(data: HousingRentalModel) {
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
                
                
                let metadata = data.data?.metadata
                self.lblFont.text = metadata?.fontData ?? ""
                self.lblExistingFont.text = metadata?.existingFont ?? ""
                self.lblPaymentMethod.text = metadata?.paymentMethod ?? ""
                self.lblStartDate.text = metadata?.desiredStart ?? ""
                self.lblpremiumDueDate.text = metadata?.premiumDueDate ?? ""
                self.lblRentedAddress.text = metadata?.rentedObjectAddress ?? ""
                self.lblRentedZip.text = metadata?.rentedObjectZipLocation ?? ""
                self.lblMonthlyRent.text = metadata?.monthlyRent ?? ""
                self.lblAmountOfDeposit.text = metadata?.amountToDeposit ?? ""
                self.lblSued.text = metadata?.areYouCurrentlySued ?? ""
                self.lblPattern.text = metadata?.pattern ?? ""
                self.lblLanguage.text = metadata?.language ?? ""
                
                
                let tenantData = metadata?.tenantDetails
                self.lblApplicantFullName.text = "\(tenantData?.firstName ?? "")" + " " + "\(tenantData?.lastName ?? "")"
                self.lblApplicantDob.text = tenantData?.dob ?? ""
                let countryCode1 = tenantData?.countryCode ?? ""
                self.lblApplicantPhone.text = "\(countryCode1) \(tenantData?.mobile ?? "")"
                //self.lblApplicantPhone.text = tenantData?.mobile ?? ""
                self.lblApplicantEmail.text = tenantData?.email ?? ""
                self.lblApplicantOccupation.text = tenantData?.occupation ?? ""
                self.lblApplicantAddress.text = tenantData?.address ?? ""
                self.lblApplicantZip.text = tenantData?.postCode ?? ""
                self.lblApplicantNationality.text = tenantData?.nationality ?? ""
                self.lblApplicantResidentPermit.text = tenantData?.residencePermit ?? ""
                self.lblApplicantEffectiveDate.text = tenantData?.effectiveDate ?? ""
                
                let lessorData = metadata?.ownerDetails
                self.lblLessor.text = lessorData?.lessor ?? ""
                let countryCode2 = lessorData?.countryCode ?? ""
                self.lblLessorPhone.text = "\(countryCode2) \(lessorData?.phoneNo ?? "")"
                //self.lblLessorPhone.text = lessorData?.phoneNo ?? ""
                self.lblLessorEmail.text = lessorData?.email ?? ""
                self.lblLessorStreet.text = lessorData?.streetNo ?? ""
                self.lblLessorContactPerson.text = lessorData?.contactPerson ?? ""
                self.lblLessorZip.text = lessorData?.zipLocation ?? ""
                
                let stewardData = metadata?.stewardshipDetails
                self.lblStewardManagement.text = stewardData?.management ?? ""
                let countryCode21 = stewardData?.countryCode ?? ""
                self.lblStewardPhone.text = "\(countryCode21) \(stewardData?.phoneNo ?? "")"
               // self.lblStewardPhone.text = stewardData?.phoneNo ?? ""
                self.lblStewardEmail.text = stewardData?.email ?? ""
                self.lblStewardStreet.text = stewardData?.streetNo ?? ""
                self.lblStewardContact.text = stewardData?.contactPerson ?? ""
                self.lblStewardZip.text = stewardData?.zipLocation ?? ""
                
               
                let otherPerson = metadata?.tenantDetails
                self.lblOtherUserFullName.text =  "\(otherPerson?.firstName?.capitalized   ?? "")" + " " + "\(otherPerson?.lastName?.capitalized   ?? "")"
                self.lblOtherUserEmail.text = otherPerson?.email ?? ""
                let countryCode12 = otherPerson?.countryCode ?? ""
                self.lblOtherUserMobile.text = "\(countryCode12) \(otherPerson?.mobile ?? "")"
              //  self.lblOtherUserMobile.text = otherPerson?.mobile ?? ""
                self.lblOtherUserDob.text = otherPerson?.dob ?? ""
                self.lblOtherUserOccupation.text = otherPerson?.occupation ?? ""
                
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


extension HousingRentalVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

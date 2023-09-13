//
//  BuildingFormVC.swift
//  LTY_Partner
//
//  Created by CTS on 04/08/23.
//

import UIKit

class BuildingFormVC: UIViewController {
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
    
    
    @IBOutlet weak var lblHeadingCustomerData: UILabel!
    @IBOutlet weak var titleFullNmae: UILabel!
 
    @IBOutlet weak var titleAddressLbl: UILabel!
    @IBOutlet weak var titleDobLbl: UILabel!
    @IBOutlet weak var titleNationalityLbl: UILabel!
    @IBOutlet weak var titleCivilStatusLblLbl: UILabel!
    @IBOutlet weak var titleEffectiveDateLbl: UILabel!
    @IBOutlet weak var titleDuration: UILabel!
    
    @IBOutlet weak var lblHeadingGeneralData: UILabel!
    @IBOutlet weak var titleBuildingTypeLbl: UILabel!
    @IBOutlet weak var titleSecurityMeasuresLblLbl: UILabel!
    @IBOutlet weak var titleHeatingSystemLbl: UILabel!
    @IBOutlet weak var titleTypeConstructionLbl: UILabel!
    @IBOutlet weak var titleTypeRoofLbl: UILabel!
    @IBOutlet weak var lblBenifitsHeading: UILabel!
    @IBOutlet weak var titleBenefitsLbl: UILabel!
    @IBOutlet weak var lblHeadingCivil: UILabel!
    @IBOutlet weak var titleSumLbl: UILabel!
    @IBOutlet weak var titleFranchiseChfLbl: UILabel!
    @IBOutlet weak var titleUsePpeLbl: UILabel!
    @IBOutlet weak var titleNumberOfAppartmentsLbl: UILabel!
    @IBOutlet weak var titleNumberOfTradeLbl: UILabel!
    @IBOutlet weak var titleCommerceAreaLbl: UILabel!

  
    @IBOutlet weak var lblHeadingQuestion: UILabel!
    
    @IBOutlet weak var titlePastInsured: UILabel!
    @IBOutlet weak var titleClaimDetails: UILabel!
    @IBOutlet weak var titleReason: UILabel!
    @IBOutlet weak var titleAnyClaims: UILabel!
    @IBOutlet weak var titleRemarks: UILabel!
   
    
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
    
    @IBOutlet weak var fullNmae: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var claimDetails: UILabel!
    @IBOutlet weak var anyClaims: UILabel!
    @IBOutlet weak var pastInsured: UILabel!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
 
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var nationalityLbl: UILabel!
    @IBOutlet weak var civilStatusLblLbl: UILabel!
    @IBOutlet weak var effectiveDateLbl: UILabel!
    @IBOutlet weak var buildingTypeLbl: UILabel!
    @IBOutlet weak var securityMeasuresLblLbl: UILabel!
    @IBOutlet weak var heatingSystemLbl: UILabel!
    @IBOutlet weak var typeConstructionLbl: UILabel!
    @IBOutlet weak var typeRoofLbl: UILabel!
    @IBOutlet weak var benefitsLbl: UILabel!
    @IBOutlet weak var sumLbl: UILabel!
    @IBOutlet weak var franchiseChfLbl: UILabel!
    @IBOutlet weak var usePpeLbl: UILabel!
    @IBOutlet weak var numberOfAppartmentsLbl: UILabel!
    @IBOutlet weak var numberOfTradeLbl: UILabel!
    @IBOutlet weak var commerceAreaLbl: UILabel!
    
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

        leadInsuranceViewModel.buildingDelegate = self
        
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

      
        
        self.lblHeadingCustomerData.text = "Customer Data".localized()
        self.titleFullNmae.text = "Full Name".localized()

        self.titleAddressLbl.text = "Address".localized()
        self.titleDobLbl.text = "Date of Birth ".localized()
        self.titleNationalityLbl.text = "Nationality/Permit".localized()
        self.titleCivilStatusLblLbl.text = "Civil Status".localized()
        self.titleEffectiveDateLbl.text = "Effective Date ".localized()
        self.titleDuration.text = "Duration".localized()

        self.lblHeadingGeneralData.text = "General Data".localized()
        self.titleBuildingTypeLbl.text = "Building Type".localized()
        self.titleSecurityMeasuresLblLbl.text = "Security Measures".localized()
        self.titleHeatingSystemLbl.text = "Heating System".localized()
        self.titleTypeConstructionLbl.text = "Type of Construction".localized()
        self.titleTypeRoofLbl.text = "Type of Roof".localized()
        self.lblBenifitsHeading.text = "Benefits (CHF deductible)".localized()
        self.titleBenefitsLbl.text = "Benifits".localized()
        self.lblHeadingCivil.text = "Building Civil Liability".localized()
        self.titleSumLbl.text = "Sum".localized()
        self.titleFranchiseChfLbl.text = "Franchise CHF".localized()
        self.titleUsePpeLbl.text = "Use (PPE,…)".localized()
        self.titleNumberOfAppartmentsLbl.text = "Number of apartments".localized()
        self.titleNumberOfTradeLbl.text = "Number of trade".localized()
        self.titleCommerceAreaLbl.text = "Commercial area in m2".localized()


        self.lblHeadingQuestion.text = "Questionnaire (concerns the last 5 years)".localized()

        self.titlePastInsured.text = "Are you or were you in the past insured for the branches offered? If so, with which company, police no?".localized()
        self.titleClaimDetails.text = "If not, what is the reason for this conclusion (change of ownership, new construction,…)?".localized()
        self.titleReason.text = "Have you suffered any claims in the proposed branches?".localized()
        self.titleAnyClaims.text = "Has there been any sanitation work carried out on the water network (all water pipes) or flat roofs of buildings to be insured in the last five years?".localized()
        self.titleRemarks.text = "Remarks".localized()

    }
    
    
    func floatingButton(){
        let btn = UIButton(type: .custom)
        let width = UIScreen.main.bounds.width - 20
        let height = UIScreen.main.bounds.height - 60
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
                    self.showAlertWithActions(msg: "Please add category commission of the agent.", titles: ["Yes", "Not Now"]) { (value) in
                        if value == 1{
                            let vc = AgentVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                            self.pushToVC(vc, animated: true)
                        }
                    }
                }else{
                    self.showOkAlertWithHandler("Please contact your partner") {
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
    
    override func viewWillAppear(_ animated: Bool) {
        let param:[String:Any] = ["leadId":leadId]
        leadInsuranceViewModel.BuildingInsuranceApiCall(param: param)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }


}


extension BuildingFormVC : SetBuildingInsuranceData {
    
    func setData(data: BuildingModel) {
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                
                
                let persnalInfo = data.data?.memberDetails
                let fName =  persnalInfo?.firstName?.capitalized   ?? ""
                let lName =  persnalInfo?.lastName?.capitalized    ?? ""
                
                self.lblPersnalInfoFullName.text = fName + " " + lName
                self.lblPersnalInfoEmail.text = persnalInfo?.email  ?? ""
                let countryCode = persnalInfo?.countryCode ?? ""
                self.lblPersnalInfoMobile.text = "\(countryCode) \(persnalInfo?.mobile ?? "")"
              //  self.lblPersnalInfoMobile.text = persnalInfo?.mobile  ?? ""
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
                
                self.fullNmae.text = fname + " " + lname
               
                
//                self.phoneLbl.text = basicInfo?.mobile  ?? ""
                self.addressLbl.text = basicInfo?.address  ?? ""
                self.nationalityLbl.text = basicInfo?.country  ?? ""
                self.dobLbl.text = basicInfo?.dob  ?? ""
                
                
                
                self.buildingTypeLbl.text = data.data?.metadata?.buildingType ?? ""
                self.securityMeasuresLblLbl.text = data.data?.metadata?.securityMeasures ?? ""
                self.heatingSystemLbl.text = data.data?.metadata?.heatingSystem ?? ""
                self.typeConstructionLbl.text = data.data?.metadata?.typeOfConstruction ?? ""
                self.typeRoofLbl.text = data.data?.metadata?.typeOfRoof ?? ""
                var arr = NSMutableArray()
                for item in data.data?.metadata?.benefits ?? [] {
                    arr.add(item)
                }
                self.benefitsLbl.text = arr.componentsJoined(by: ", ")
                
                self.sumLbl.text = data.data?.metadata?.sum ?? ""
                self.franchiseChfLbl.text = data.data?.metadata?.franchise ?? ""
                self.usePpeLbl.text = data.data?.metadata?.use ?? ""
                self.numberOfAppartmentsLbl.text = data.data?.metadata?.noOfApartment ?? ""
                self.numberOfTradeLbl.text = data.data?.metadata?.noOfTrade ?? ""
                self.commerceAreaLbl.text = data.data?.metadata?.commercialArea ?? ""
                
                self.reason.text = data.data?.metadata?.reason ?? ""
                self.claimDetails.text = data.data?.metadata?.claimDetails ?? ""
                self.anyClaims.text = data.data?.metadata?.anyClaims ?? ""
                self.remarks.text = data.data?.metadata?.remarks ?? ""
                self.pastInsured.text = data.data?.metadata?.pastInsured ?? ""
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

extension BuildingFormVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

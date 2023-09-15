//
//  AnimalFormVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/08/23.
//

import UIKit

class AnimalFormVC: UIViewController {
    
    
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
    
    @IBOutlet weak var lblHeadingAnimalOwner: UILabel!
    @IBOutlet weak var lblHeadingStartInsurance: UILabel!
    @IBOutlet weak var titleLblDob: UILabel!
    @IBOutlet weak var titleLblEmail: UILabel!
    @IBOutlet weak var titleLblColor: UILabel!
    @IBOutlet weak var titleLblGendr: UILabel!
    @IBOutlet weak var titleLblBreed: UILabel!
    @IBOutlet weak var titleLblZipCode: UILabel!
    @IBOutlet weak var titleLblStreetNo: UILabel!
    @IBOutlet weak var titleLblPetsName: UILabel!
    @IBOutlet weak var titleLblLastName: UILabel!
    @IBOutlet weak var titleLblFirstName: UILabel!
    @IBOutlet weak var titleLblPhoneNumber: UILabel!
    @IBOutlet weak var titleLnsuranceStartDate: UILabel!
    @IBOutlet weak var titleLblInsuredAnimal: UILabel!
    @IBOutlet weak var titleLblEffectiveDate: UILabel!
    @IBOutlet weak var lblHeadingDesiredInurance: UILabel!
    @IBOutlet weak var titleLblMonthlyPremium: UILabel!
    @IBOutlet weak var titleLblElectronicChipNo: UILabel!
    @IBOutlet weak var titleLblCalender: UILabel!
    @IBOutlet weak var titleLblCalenderPerYearCat: UILabel!
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

    
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblGendr: UILabel!
    @IBOutlet weak var lblBreed: UILabel!
    @IBOutlet weak var lblZipCode: UILabel!
    @IBOutlet weak var lblStreetNo: UILabel!
    @IBOutlet weak var lblCalender: UILabel!
    @IBOutlet weak var lblPetsName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var insuranceStartDate: UILabel!
    @IBOutlet weak var lblInsuredAnimal: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblMonthlyPremium: UILabel!
    @IBOutlet weak var lblElectronicChipNo: UILabel!
    @IBOutlet weak var lblCalenderPerYearCat: UILabel!

    @IBOutlet weak var BreedStack: UIView!
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
        setUpLocalization()
        leadInsuranceViewModel.animalDelegate = self
        
        customNavDrower.titleLabel.text = "Basic Insurance Information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    func setUpLocalization(){
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
        
        self.lblHeadingAnimalOwner.text = "Applicant's Data (Animal Owner)".localized()
        self.lblHeadingStartInsurance.text = "Desired Start of Insurance".localized()
        self.titleLblDob.text = "Date of birth (min. month/year)".localized()
        self.titleLblEmail.text = "Email".localized()
        self.titleLblColor.text = "Color".localized()
        self.titleLblGendr.text = "Gender".localized()
        self.titleLblBreed.text = "Breed".localized()
        self.titleLblZipCode.text = "Zip Code".localized()
        self.titleLblStreetNo.text = "Street Number".localized()
        self.titleLblPetsName.text = "Pet's Name".localized()
        self.titleLblLastName.text = "Last Name".localized()
        self.titleLblFirstName.text = "First Name".localized()
        self.titleLblPhoneNumber.text = "Phone Number".localized()
        self.titleLnsuranceStartDate.text = "Insurance Start Date".localized()
        self.titleLblInsuredAnimal.text = "Insured Animal".localized()
        self.titleLblEffectiveDate.text = "Effective Date".localized()
        self.lblHeadingDesiredInurance.text = "Desired Insurance Coverage".localized()
        self.titleLblMonthlyPremium.text = "Monthly Premium".localized()
        self.titleLblElectronicChipNo.text = "Electronic chip number (if available)".localized()
        self.titleLblCalender.text = "Deductive Per Calender Year(Dog)".localized()
        self.titleLblCalenderPerYearCat.text = "Deductive Per Calender Year(Cat)".localized()
        
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
        leadInsuranceViewModel.AnimalInsuranceApiCall(param: param)
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

extension AnimalFormVC : SetAnimalProtectionData {

  
    func setData(data: AnimalModel) {
        
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
                self.lblPersnalInfoDob.text =  returnDOB(date: persnalInfo?.dob  ?? "")//persnalInfo?.dob  ?? ""
                self.lblPersnalInfoNationality.text = persnalInfo?.country  ?? ""
                self.lblPersnalInfoCity.text = persnalInfo?.city  ?? ""
                self.lblPersnalInfoAddress.text = persnalInfo?.address  ?? ""
                self.lblPersnalInfoPartner.text = data.data?.partnerName
                self.lblPersnalInfoagent.text = data.data?.agentName   ?? ""
                self.lblMemberInfoFullName.text = data.data?.memberName
                self.lblMemberInfoRelation.text = data.data?.relation  ?? ""
                self.lblMemberInfoInsuranceType.text = data.data?.insuranceType ?? ""
                
//                let responseData = data.data?.metadata?.personalDetails
                let metaData = data.data?.metadata
                self.lblDob.text = metaData?.dob ?? ""
                self.lblEmail.text = metaData?.personalDetails?.email ?? ""
                self.lblColor.text = metaData?.color ?? ""
                self.lblGendr.text = metaData?.gender ?? ""
              //  self.lblBreed.text = metaData?.b ?? ""
                self.lblZipCode.text = metaData?.personalDetails?.countryCode ?? ""
                self.lblStreetNo.text = metaData?.personalDetails?.streetNo ?? ""
                self.insuranceStartDate.text = metaData?.startDate ?? ""
                self.lblCalender.text = metaData?.dogsDeductiblePerCalendarYear ?? ""
                self.lblCalenderPerYearCat.text = metaData?.catsDeductiblePerCalendarYear ?? ""
                self.lblPetsName.text = metaData?.petsName ?? ""
                self.lblLastName.text = metaData?.personalDetails?.lastName?.capitalized   ?? ""
                self.lblFirstName.text = metaData?.personalDetails?.firstName?.capitalized   ?? ""
                let countryCode12 = metaData?.personalDetails?.countryCode ?? ""
                self.lblPhoneNumber.text = "\(countryCode12) \(metaData?.personalDetails?.mobile ?? "")"
               // self.lblPhoneNumber.text = metaData?.personalDetails?.mobile ?? ""
                self.lblInsuredAnimal.text = metaData?.insuredAnimal ?? ""
                self.lblEffectiveDate.text = metaData?.personalDetails?.effectiveDate ?? ""
                self.lblMonthlyPremium.text = metaData?.monthlyPremiums ?? ""
                self.lblElectronicChipNo.text = metaData?.electronicChipNo ?? ""
                


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


extension AnimalFormVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

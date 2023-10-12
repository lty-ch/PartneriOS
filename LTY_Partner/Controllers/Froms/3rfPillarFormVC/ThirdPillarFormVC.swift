//
//  3rdPillarFormVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/08/23.
//

import UIKit

class ThirdPillarFormVC: UIViewController {
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
    
    
    @IBOutlet weak var lblHeadingPresnalData: UILabel!
    @IBOutlet weak var titleLblDob: UILabel!
    @IBOutlet weak var titleLblCity: UILabel!
    @IBOutlet weak var titleLblTitle: UILabel!
    @IBOutlet weak var lblHeadingPillarOffer: UILabel!
    @IBOutlet weak var titleLblOffer: UILabel!
    @IBOutlet weak var titleLblInjured: UILabel!
    @IBOutlet weak var titleLblJobTitle: UILabel!
    @IBOutlet weak var titleLblLastName: UILabel!
    @IBOutlet weak var titleLblFirstName: UILabel!
    @IBOutlet weak var titleLblSituation: UILabel!
    @IBOutlet weak var titleLblPostalCode: UILabel!
    @IBOutlet weak var titleLblPhoneNumber: UILabel!
    @IBOutlet weak var titleLblNationality: UILabel!
    @IBOutlet weak var titleLblPremiumData: UILabel!
    @IBOutlet weak var titleLblStreetAddress: UILabel!
    @IBOutlet weak var titleLblPaymentMethod: UILabel!
    
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
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblInjured: UILabel!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblSituation: UILabel!
    @IBOutlet weak var lblPostalCode: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblPremiumData: UILabel!
    @IBOutlet weak var lblStreetAddress: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
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
        leadInsuranceViewModel.thirdPillarDelgate = self
        
        customNavDrower.titleLabel.text = "Basic Insurance Information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    func setLocalization(){
        
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
        
        self.lblHeadingPresnalData.text = "Personal Data".localized()
        self.titleLblDob.text = "Date of Birth".localized()
        self.titleLblCity.text = "City".localized()
        self.titleLblTitle.text = "Title".localized()
        self.lblHeadingPillarOffer.text = "3rd pillar offer".localized()
        self.titleLblOffer.text = "What do you want in your offer?".localized()
        self.titleLblInjured.text = "Are your details different from the person to be insured?".localized()
        self.titleLblJobTitle.text = "What is your job?".localized()
        self.titleLblLastName.text = "Last Name".localized()
        self.titleLblFirstName.text = "First Name".localized()
        self.titleLblSituation.text = "Professional Situation".localized()
        self.titleLblPostalCode.text = "Postal Code ".localized()
        self.titleLblPhoneNumber.text = "Phone Number".localized()
        self.titleLblNationality.text = "Nationality/Permit".localized()
        self.titleLblPremiumData.text = "Do you want a premium or a lump sum ?".localized()
        self.titleLblStreetAddress.text = "Street Address".localized()
        self.titleLblPaymentMethod.text = "Payment Method".localized()
    }
    
    func floatingButton(){
        let btn = UIButton(type: .custom)
        let width = UIScreen.main.bounds.width - 20
        let height = UIScreen.main.bounds.height - 80
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
        leadInsuranceViewModel.thirdPillarApiCall(param: param)
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

extension ThirdPillarFormVC : SetThirdPillarProtectionData {
  
    func setData(data: ThirdPillarModel) {
        
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
                self.lblPersnalInfoagent.text = data.data?.agentName   ?? ""
                self.lblMemberInfoFullName.text = data.data?.memberName
                self.lblMemberInfoRelation.text = data.data?.relation  ?? ""
                self.lblMemberInfoInsuranceType.text = data.data?.insuranceType?.localized() ?? ""
                
                
                let responseData = data.data?.metadata?.personalDetails
                let metaData = data.data?.metadata
                
                self.lblDob.text =  responseData?.dob ?? ""
                self.lblCity.text =  responseData?.city ?? ""
                self.lblTitle.text =  responseData?.title ?? ""
                self.lblOffer.text =  metaData?.whatYouWantInOffer ?? ""
                self.lblInjured.text =  metaData?.howMuchYouWantToInsure ?? ""
                self.lblJobTitle.text = metaData?.job ?? ""
                self.lblLastName.text =  responseData?.lastName?.capitalized   ?? ""
                self.lblFirstName.text =  responseData?.firstName?.capitalized   ?? ""
                self.lblSituation.text =  metaData?.professionalSituation ?? ""
                self.lblPostalCode.text =  responseData?.postCode ?? ""
                let countryCode12 = responseData?.countryCode ?? ""
                self.lblPhoneNumber.text = "\(countryCode12) \(responseData?.mobile ?? "")"
                //self.lblPhoneNumber.text =  responseData?.mobile ?? ""
                self.lblNationality.text =  responseData?.nationality ?? ""
                self.lblPremiumData.text =  metaData?.doYouWantPremium ?? ""
                self.lblStreetAddress.text =  responseData?.streetNo ?? ""
                self.lblPaymentMethod.text =  metaData?.paymentMethod ?? ""
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

extension ThirdPillarFormVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

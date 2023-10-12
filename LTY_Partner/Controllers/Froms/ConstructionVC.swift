//
//  ConstructionVC.swift
//  LTY_Partner
//
//  Created by CTS on 22/08/23.
//

import UIKit

class ConstructionVC: UIViewController {
    
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var discriptionView: UIView!
    @IBOutlet weak var installationTypeView: UIView!
    @IBOutlet weak var boreholesView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var earthworkValueView: UIView!
    @IBOutlet weak var whichOneView: UIView!
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
    @IBOutlet weak var lblPolicyHolderType: UILabel!
    @IBOutlet weak var lblPolicyHolderFullName: UILabel!
    @IBOutlet weak var lblPolicyHolderMail: UILabel!
    @IBOutlet weak var lblPolicyHolderTelephone: UILabel!
    @IBOutlet weak var lblPolicyHolderAddress: UILabel!
    @IBOutlet weak var lblPolicyHolderEffectiveDate: UILabel!
    @IBOutlet weak var lblNatureOfWorkConstructionType: UILabel!
    @IBOutlet weak var lblOperatedDuringWorks: UILabel!
    @IBOutlet weak var lblExplanation: UILabel!
    
    @IBOutlet weak var lblConstructionLandRegistryNumber: UILabel!
    @IBOutlet weak var lblConstructionStreetNumber: UILabel!
    @IBOutlet weak var lblConstructionLocation: UILabel!
    @IBOutlet weak var lblConstructionPostalCode: UILabel!
    @IBOutlet weak var lblConstructionBeginingOfWorks: UILabel!
    @IBOutlet weak var lblConstructionEndOfWorks: UILabel!
    @IBOutlet weak var lblWorksAccepted: UILabel!
    @IBOutlet weak var lblHasWorkStarted: UILabel!
    @IBOutlet weak var lblKnownLoss: UILabel!
    @IBOutlet weak var lblArchitectFullName: UILabel!
    @IBOutlet weak var lblArchitectEmail: UILabel!
    @IBOutlet weak var lblArchitectPhone: UILabel!
    @IBOutlet weak var lblArchitectAddress: UILabel!
    @IBOutlet weak var lblCivilErFullName: UILabel!
    @IBOutlet weak var lblCivilErEmail: UILabel!
    @IBOutlet weak var lblCivilErPhone: UILabel!
    @IBOutlet weak var lblCivilErrAddress: UILabel!
    @IBOutlet weak var lblMasterOfWork: UILabel!
    @IBOutlet weak var lblMasterOfWorkName: UILabel!
    @IBOutlet weak var lblMasterOfWorkEmail: UILabel!
    @IBOutlet weak var lblMasterOfWorkPhone: UILabel!
    @IBOutlet weak var lblMasterOfWorkAddress: UILabel!
    @IBOutlet weak var lblConstructionWorkInsurance: UILabel!
    @IBOutlet weak var lblCantons: UILabel!
    @IBOutlet weak var lblBuilderLiabilityInsurance: UILabel!
    @IBOutlet weak var lblIsOwnerInvolved: UILabel!
    @IBOutlet weak var lblDoesAuthorityOwnWorks: UILabel!
    @IBOutlet weak var lblWhichOne: UILabel!
    @IBOutlet weak var lblTotalCostOfProject: UILabel!
    @IBOutlet weak var lblCivilErProject: UILabel!
    @IBOutlet weak var lblDistanceToTerritory: UILabel!
    @IBOutlet weak var lblDemolitiont: UILabel!
    @IBOutlet weak var lblTopography: UILabel!
    @IBOutlet weak var lblLandToBuild: UILabel!
    @IBOutlet weak var lblEarthwork: UILabel!
    @IBOutlet weak var lblDepthOfExcavsation: UILabel!
    @IBOutlet weak var lblUpperFloors: UILabel!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var lblExecutionExcavation: UILabel!
    @IBOutlet weak var lblTechnique: UILabel!
    @IBOutlet weak var lblLoweringWaterTable: UILabel!
    @IBOutlet weak var lblStructuralFoundation: UILabel!
    @IBOutlet weak var lblStalling: UILabel!
    @IBOutlet weak var lblUnderpinning: UILabel!
    @IBOutlet weak var lblGeothermalProbes: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblDepthofBoreholes: UILabel!
    @IBOutlet weak var lblSolarInstallationInstalled: UILabel!
    @IBOutlet weak var lblInstallationType: UILabel!
    @IBOutlet weak var lblDuringTransformations: UILabel!
    @IBOutlet weak var lblRoofWork: UILabel!
    @IBOutlet weak var lblDangerZone: UILabel!
    @IBOutlet weak var lblDangerZoneSpecification: UILabel!
    @IBOutlet weak var lblNeighbourThirdParty: UILabel!
    @IBOutlet weak var lblSbbLiability: UILabel!
    @IBOutlet weak var lblSbbLiabilityAgreement: UILabel!
    @IBOutlet weak var lblRequirements: UILabel!
    @IBOutlet weak var lblRequirementsReason: UILabel!
    @IBOutlet weak var lblMaps: UILabel!
    @IBOutlet weak var lblQuotation: UILabel!
    @IBOutlet weak var lblReports: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    
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
    @IBOutlet weak var lblTitleMemberInfoRelation: UILabel!
    @IBOutlet weak var lblTitleMemberInfoInsuranceType: UILabel!
    @IBOutlet weak var lblTitleMemberInfo: UILabel!
    
    @IBOutlet weak var basicProjectTitle: UILabel!
    @IBOutlet weak var basicProjectPolicyHolderTitle: UILabel!
    @IBOutlet weak var basicProjectFullNameTitle: UILabel!
    @IBOutlet weak var basicProjectEmailTitle: UILabel!
    @IBOutlet weak var basicProjectMobileTitle: UILabel!
    @IBOutlet weak var basicProjectAddressTitle: UILabel!
    @IBOutlet weak var basicProjectEffectiveDateTitle: UILabel!
    
    @IBOutlet weak var natureOfWorkTitle: UILabel!
    @IBOutlet weak var natureOfWorkConstructionTypeTitle: UILabel!
    
    @IBOutlet weak var natureOfWorkOperatedHoursitle: UILabel!
    @IBOutlet weak var natureOfWorkExplanationTitle: UILabel!
    
    @IBOutlet weak var constructionProjectTitle: UILabel!
    @IBOutlet weak var constructionProjectLandRegistryNumberTitle: UILabel!
    @IBOutlet weak var constructionProjectStreetNumberTitle: UILabel!
    @IBOutlet weak var constructionProjectLocationTitle: UILabel!
    @IBOutlet weak var constructionProjectPostalCodeTitle: UILabel!
    @IBOutlet weak var constructionProjectBeginningofWorksTitle: UILabel!
    @IBOutlet weak var constructionProjectEndofWorksTitle: UILabel!
    
    @IBOutlet weak var workInProgressTitle: UILabel!
    @IBOutlet weak var workInProgressWorkAcceptedTitle: UILabel!
    @IBOutlet weak var workInProgressWorkStartedTitle: UILabel!
    @IBOutlet weak var workInProgressKnownLossTitle: UILabel!
    
    @IBOutlet weak var architectTitle: UILabel!
    @IBOutlet weak var architectFullNameTitle: UILabel!
    @IBOutlet weak var architectEmailTitle: UILabel!
    @IBOutlet weak var architectPhoneTitle: UILabel!
    @IBOutlet weak var architectAddressTitle: UILabel!
    
    @IBOutlet weak var civilErTitle: UILabel!
    @IBOutlet weak var civilErFullNameTitle: UILabel!
    @IBOutlet weak var civilErEmailTitle: UILabel!
    @IBOutlet weak var civilErPhoneTitle: UILabel!
    @IBOutlet weak var civilErAddressTitle: UILabel!
    
    @IBOutlet weak var masterOfWorkTitle: UILabel!
    @IBOutlet weak var masterOfWorkLabelTitle: UILabel!
    @IBOutlet weak var masterOfWorkNameTitle: UILabel!
    @IBOutlet weak var masterOfWorkEmailTitle: UILabel!
    @IBOutlet weak var masterOfWorkPhoneTitle: UILabel!
    @IBOutlet weak var masterOfWorkAddressTitle: UILabel!
    
    @IBOutlet weak var basicDataTitle: UILabel!
    @IBOutlet weak var basicDataConstructionWorkTitle: UILabel!
    @IBOutlet weak var basicDataCantonsTitle: UILabel!
    @IBOutlet weak var basicDataBuildersLiabilityTitle: UILabel!
    
    @IBOutlet weak var ownerparticipationTitle: UILabel!
    @IBOutlet weak var ownerparticipationActivelyInvolvedTitle: UILabel!
    
    @IBOutlet weak var neighbourTitle: UILabel!
    @IBOutlet weak var neighbourContractingAuthorityTitle: UILabel!
    @IBOutlet weak var neighbourWhichOneTitle: UILabel!
    
    @IBOutlet weak var riskIssuesTitle: UILabel!
    @IBOutlet weak var riskIssuesTotalCostTitle: UILabel!
    @IBOutlet weak var riskIssuesCivilErProjectTitle: UILabel!
    @IBOutlet weak var riskIssuesDistanceNearestTitle: UILabel!
    @IBOutlet weak var riskIssuesDemolitionTitle: UILabel!
    @IBOutlet weak var riskIssuesTypographyTitle: UILabel!
    @IBOutlet weak var riskIssuesLandToBuildTitle: UILabel!
    @IBOutlet weak var riskIssuesEarthworkTitle: UILabel!
    @IBOutlet weak var riskIssuesDepthExacavationTitle: UILabel!
    @IBOutlet weak var riskIssuesUpperFloorsTitle: UILabel!
    @IBOutlet weak var riskIssuesSearchTitle: UILabel!
    @IBOutlet weak var riskIssuesExecutionTitle: UILabel!
    @IBOutlet weak var riskIssuesTechniqueTitle: UILabel!
    @IBOutlet weak var riskIssuesLoweringTitle: UILabel!
    @IBOutlet weak var riskIssuesStructureFoundationsTitle: UILabel!
    @IBOutlet weak var riskIssuesStallingTitle: UILabel!
    @IBOutlet weak var riskIssuesUnderpinningTitle: UILabel!
    @IBOutlet weak var riskIssuesGeothermalProbesTitle: UILabel!
    @IBOutlet weak var riskIssuesNumberTitle: UILabel!
    @IBOutlet weak var riskIssuesBoreholesTitle: UILabel!
    @IBOutlet weak var riskIssuesSolarInstallationsTitle: UILabel!
    @IBOutlet weak var riskIssuesInstallationTypeTitle: UILabel!
    
    @IBOutlet weak var loadBearingStructureTitle: UILabel!
    @IBOutlet weak var loadBearingStructureTransformationsTitle: UILabel!
    
    @IBOutlet weak var roofWorkTitle: UILabel!
    @IBOutlet weak var roofWorkRaisingTitle: UILabel!
    
    @IBOutlet weak var dangerZoneTitle: UILabel!
    @IBOutlet weak var dangerZoneStructureTitle: UILabel!
    @IBOutlet weak var dangerZoneSpecificationsTitle: UILabel!
    
    @IBOutlet weak var thirdPartyWorkTitle: UILabel!
    @IBOutlet weak var thirdPartyWorkStatementTitle: UILabel!
    
    @IBOutlet weak var statutoryTitle: UILabel!
    @IBOutlet weak var statutoryContractingTitle: UILabel!
    @IBOutlet weak var statutoryAgreementTitle: UILabel!
    
    @IBOutlet weak var claimsTitle: UILabel!
    @IBOutlet weak var claimsRequirementTitle: UILabel!
    @IBOutlet weak var claimsReasonTitle: UILabel!
    
    @IBOutlet weak var questionaireDocsTitle: UILabel!
    @IBOutlet weak var questionaireDocsMapsTitle: UILabel!
    @IBOutlet weak var questionaireDocsQuotationTitle: UILabel!
    @IBOutlet weak var questionaireDocsReportsTitle: UILabel!
    @IBOutlet weak var questionaireDocsNotesTitle: UILabel!
    @IBOutlet weak var questionaireDocsDateTitle: UILabel!
    @IBOutlet weak var questionaireDocsPlaceTitle: UILabel!
    
    
    
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
        
        customNavDrower.titleLabel.text = "Basic Insurance information".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        leadInsuranceViewModel.constructionDelegate = self
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
        self.lblTitleMemberInfo.text = "Member Information".localized()

        self.basicProjectTitle.text = "Basic Project Data".localized()
        self.basicProjectPolicyHolderTitle.text = "POLICYHOLDER".localized()
        self.basicProjectFullNameTitle.text = "Full Name".localized()
        self.basicProjectEmailTitle.text = "Email".localized()
        self.basicProjectMobileTitle.text = "Phone Number".localized()
        self.basicProjectAddressTitle.text = "Address".localized()
        self.basicProjectEffectiveDateTitle.text = "Effective Date".localized()

        self.natureOfWorkTitle.text = "TYPE OF CONSTRUCTION NATURE OF WORK".localized()
        self.natureOfWorkConstructionTypeTitle.text = "Type of Construction".localized()

        self.natureOfWorkOperatedHoursitle.text = "descripton".localized()
        self.natureOfWorkExplanationTitle.text = "Brief explanation".localized()

        self.constructionProjectTitle.text = "Construction project address".localized()
        self.constructionProjectLandRegistryNumberTitle.text = "Land Registry Number".localized()
        self.constructionProjectStreetNumberTitle.text = "Street Number".localized()
        self.constructionProjectLocationTitle.text = "Location".localized()
        self.constructionProjectPostalCodeTitle.text = "Postal Code".localized()
        self.constructionProjectBeginningofWorksTitle.text = "Beginning of the roadworks (from the installation of the site and / or the demolitions, preparatory work)".localized()
        self.constructionProjectEndofWorksTitle.text = "End of the works (end of works, acceptance or occupation of the building or part of the building)".localized()

        self.workInProgressTitle.text = "WORK IN PROGRESS".localized()
        self.workInProgressWorkAcceptedTitle.text = "Are the works accepted all at once or in stages?".localized()
        self.workInProgressWorkStartedTitle.text = "Has the work already started?".localized()
        self.workInProgressKnownLossTitle.text = "known loss?".localized()

        self.architectTitle.text = "ARCHITECT".localized()
        self.architectFullNameTitle.text = "Full Name".localized()
        self.architectEmailTitle.text = "Email".localized()
        self.architectPhoneTitle.text = "Phone Number".localized()
        self.architectAddressTitle.text = "Address".localized()

        self.civilErTitle.text = "CIVIL ENGINEER".localized()
        self.civilErFullNameTitle.text = "Full Name".localized()
        self.civilErEmailTitle.text = "Email".localized()
        self.civilErPhoneTitle.text = "Phone Number".localized()
        self.civilErAddressTitle.text = "Address".localized()

        self.masterOfWorkTitle.text = "MASTER OF WORK".localized()
        self.masterOfWorkLabelTitle.text = "Master of Work".localized()
        self.masterOfWorkNameTitle.text = "Name".localized()
        self.masterOfWorkEmailTitle.text = "Email".localized()
        self.masterOfWorkPhoneTitle.text = "Phone Number".localized()
        self.masterOfWorkAddressTitle.text = "Address".localized()

        self.basicDataTitle.text = "Basic data for the insurance".localized()
        self.basicDataConstructionWorkTitle.text = "Construction work insurance".localized()
        self.basicDataCantonsTitle.text = "Cantons without cantonal insurance establishments: the risks fire/natural events must be insured?".localized()
        self.basicDataBuildersLiabilityTitle.text = "Builder's liability insurance (whether this insurance - for the amount of work planned - is not included in a combined Household, RC Company or other insurance)".localized()

        self.ownerparticipationTitle.text = "OWNER PARTICIPATION".localized()
        self.ownerparticipationActivelyInvolvedTitle.text = "Is the owner actively involved in excavation work or work on load-bearing structures without adequate liability insurance? (the drawing up of plans, the direction of the works and the interior fittings are insured without premium supplements)".localized()

        self.neighbourTitle.text = "NEIGHBORHOOD".localized()
        self.neighbourContractingAuthorityTitle.text = "Does the contracting authority own works on the plot or in the immediate vicinity of the work carried out?".localized()
        self.neighbourWhichOneTitle.text = "Which one?".localized()

        self.riskIssuesTitle.text = "Risk issues".localized()
        self.riskIssuesTotalCostTitle.text = "Total Cost of Project Works* (In CHF)(* Positions 1 to 4 usual of the CFC Construction Costs Code including the fees and the client's own services. Are not taken into consideration: costs for preliminary studies, competitions, land acquisition, connection taxes, financing costs and taxes)".localized()
        self.riskIssuesCivilErProjectTitle.text = "Civil engineering project".localized()
        self.riskIssuesDistanceNearestTitle.text = "Distance to the nearest tertiary structure, existing or under construction (buildings, tramway or railway installations, works of art are considered to be works)".localized()
        self.riskIssuesDemolitionTitle.text = "Demolition (the openings made for windows, doors or installations do not fall under the notion of demolition)".localized()
        self.riskIssuesTypographyTitle.text = "Topography (the most sloping place of the natural ground between the external walls (facades) located downstream and upstream)".localized()
        self.riskIssuesLandToBuildTitle.text = "Land to build".localized()
        self.riskIssuesEarthworkTitle.text = "Earthwork / full-body excavation".localized()
        self.riskIssuesDepthExacavationTitle.text = "Depth of Excavation".localized()
        self.riskIssuesUpperFloorsTitle.text = "Upper floors (ES) (All floors located entirely or partially (more than half the height) above the natural terrain must be taken into consideration, even if they are not affected by the works)".localized()
        self.riskIssuesSearchTitle.text = "Search".localized()
        self.riskIssuesExecutionTitle.text = "Execution of the excavation".localized()
        self.riskIssuesTechniqueTitle.text = "Technique".localized()
        self.riskIssuesLoweringTitle.text = "Lowering of the water table".localized()
        self.riskIssuesStructureFoundationsTitle.text = "Structure foundations / Special foundations".localized()
        self.riskIssuesStallingTitle.text = "Stalling".localized()
        self.riskIssuesUnderpinningTitle.text = "Underpinning and/or lower cutting (e.g. building, pipeline, retaining wall)".localized()
        self.riskIssuesGeothermalProbesTitle.text = "Are drillings for geothermal probes carried out?".localized()
        self.riskIssuesNumberTitle.text = "Number".localized()
        self.riskIssuesBoreholesTitle.text = "Depth of boreholes".localized()
        self.riskIssuesSolarInstallationsTitle.text = "Are solar installations installed?".localized()
        self.riskIssuesInstallationTypeTitle.text = "Installation Type".localized()

        self.loadBearingStructureTitle.text = "Changes to the load-bearing structure".localized()
        self.loadBearingStructureTransformationsTitle.text = "During transformations: modifications of the load-bearing Structure (modification of the structure's statics) are carried out (the creation of openings for doors, windows, elevators does not fall under the notion of modification of the load-bearing structure)".localized()

        self.roofWorkTitle.text = "Roof work".localized()
        self.roofWorkRaisingTitle.text = "Work on the roof is carried out during (Raising, laying or complete replacement of tiles, roofing or waterproofing)".localized()

        self.dangerZoneTitle.text = "Danger zone".localized()
        self.dangerZoneStructureTitle.text = "The structure is located in a danger zone of avalanches, falling rocks, rockslides, water (high water, flooding, wave shocks), difficult terrain (slides, land settling). Specify if applicable:".localized()
        self.dangerZoneSpecificationsTitle.text = "Specifications".localized()

        self.thirdPartyWorkTitle.text = "Condition of neighboring third-party work".localized()
        self.thirdPartyWorkStatementTitle.text = "Is a statement of the condition of the existing structures or cracks established before the start of the work? (Required during pile driving or vibration sinking work, lowering of the water table outside the excavation, underpinning / lower recutting and rock excavation by mining or using jackhammers, within a radius 30m)".localized()

        self.statutoryTitle.text = "Statutory civil liability of SBB or another railway undertaking".localized()
        self.statutoryContractingTitle.text = "The contracting authority must assume, by agreement,the legal civil liability of SBB or another railway undertaking (if yes, attach a copy of the agreement)".localized()
        self.statutoryAgreementTitle.text = "Copy of the agreement".localized()

        self.claimsTitle.text = "Requirements or claims have already been put in relation to this project".localized()
        self.claimsRequirementTitle.text = "Requirements or claims have already been put in relation to this project.".localized()
        self.claimsReasonTitle.text = "Reason".localized()

        self.questionaireDocsTitle.text = "Questionnaire Documents".localized()
        self.questionaireDocsMapsTitle.text = "Maps".localized()
        self.questionaireDocsQuotationTitle.text = "Quotation / description of the work if available".localized()
        self.questionaireDocsReportsTitle.text = "Reports, expertise if available, e.g. soil analysis, geological conditions".localized()
        self.questionaireDocsNotesTitle.text = "Notes from the policyholder".localized()
        self.questionaireDocsDateTitle.text = "Date".localized()
        self.questionaireDocsPlaceTitle.text = "Place".localized()
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
        print("Add Proposal in forms")
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
        leadInsuranceViewModel.constructionApiCall(param: param)
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

extension ConstructionVC : ConstructionProtocolData {
    
    
    func setData(data: ConstructionModel) {
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
                self.lblMemberInfoInsuranceType.text = data.data?.insuranceType?.localized() ?? ""
                
                let basicInfo = data.data?.metadata
                self.lblPolicyHolderType.text = basicInfo?.policyHolder ?? ""
                
                let poliyHolderDeatils = basicInfo?.policyHolderDetails
                let firstName =  poliyHolderDeatils?.firstName?.capitalized   ?? ""
                let lastName =  poliyHolderDeatils?.lastName?.capitalized    ?? ""
                
                self.lblPolicyHolderFullName.text = firstName + " " + lastName
                self.lblPolicyHolderMail.text = poliyHolderDeatils?.email ?? ""
                self.lblPolicyHolderTelephone.text = poliyHolderDeatils?.mobile ?? ""
                self.lblPolicyHolderEffectiveDate.text = poliyHolderDeatils?.effectiveDate ?? ""
                self.lblPolicyHolderAddress.text = poliyHolderDeatils?.address ?? ""
                
                self.lblNatureOfWorkConstructionType.text = basicInfo?.typeOfConstruction ?? ""
                if self.lblNatureOfWorkConstructionType.text == "other" {
                    self.discriptionView.isHidden = false
//                                    self.lblOperatedDuringWorks.text = basicInfo?.typeOfConstruction ?? ""
//                                    self.lblExplanation.text = basicInfo?.typeOfConstruction ?? ""
                }

                
                let projectAddressDetails = basicInfo?.projectAddressDetails
                self.lblConstructionLandRegistryNumber.text = projectAddressDetails?.landRegistryNo ?? ""
                self.lblConstructionStreetNumber.text = projectAddressDetails?.streetNo ?? ""
                self.lblConstructionLocation.text = projectAddressDetails?.location ?? ""
                self.lblConstructionPostalCode.text = projectAddressDetails?.postalCode ?? ""
                self.lblConstructionBeginingOfWorks.text = projectAddressDetails?.startDateOfWork ?? ""
                self.lblConstructionEndOfWorks.text = projectAddressDetails?.endDateOfWork ?? ""
                
                self.lblWorksAccepted.text = basicInfo?.areTheWorkAccepted ?? ""
                self.lblHasWorkStarted.text = basicInfo?.hasWorkStarted ?? ""
                self.lblKnownLoss.text = basicInfo?.knownLoss ?? ""
                
                let architectDetails = basicInfo?.architectDetails
                self.lblArchitectFullName.text = architectDetails?.name ?? ""
                self.lblArchitectEmail.text = architectDetails?.email ?? ""
                self.lblArchitectPhone.text = architectDetails?.phone ?? ""
                self.lblArchitectAddress.text = architectDetails?.address ?? ""
                
                let civilErDetails = basicInfo?.architectDetails
                self.lblCivilErFullName.text = civilErDetails?.name ?? ""
                self.lblCivilErEmail.text = civilErDetails?.email ?? ""
                self.lblCivilErPhone.text = civilErDetails?.phone ?? ""
                self.lblCivilErrAddress.text = civilErDetails?.address ?? ""
                
                self.lblMasterOfWork.text = basicInfo?.masterOfWorkFor ?? ""
                let masterOfWorkDetails = basicInfo?.masterOfWorkDetails
                self.lblMasterOfWorkName.text = masterOfWorkDetails?.name ?? ""
                self.lblMasterOfWorkEmail.text = masterOfWorkDetails?.email ?? ""
                self.lblMasterOfWorkPhone.text = masterOfWorkDetails?.phone ?? ""
                self.lblMasterOfWorkAddress.text = masterOfWorkDetails?.address ?? ""
                
                let desiredInsuranceDetails = basicInfo?.desiredInsurance
                self.lblConstructionWorkInsurance.text = desiredInsuranceDetails?.constructionWorkInsurance ?? ""
                self.lblCantons.text = desiredInsuranceDetails?.cantonsWithoutCantonalInsuranceEstablishmentsTheRisksFireNaturalEventsMustBeInsured ?? ""
                self.lblBuilderLiabilityInsurance.text = desiredInsuranceDetails?.builderSLiabilityInsuranceWhetherThisInsuranceForTheAmountOfWorkPlannedIsNotIncludedInACombinedHouseholdRCCompanyOrOtherInsurance ?? ""
                self.lblIsOwnerInvolved.text = basicInfo?.ownerPartition ?? ""
                self.lblDoesAuthorityOwnWorks.text = basicInfo?.neighborhood ?? ""
                
                if(self.lblDoesAuthorityOwnWorks.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.whichOneView.isHidden = false
                } else {
                    self.whichOneView.isHidden = true
                }
                
                
                self.lblWhichOne.text = basicInfo?.whichOne ?? ""
                self.lblTotalCostOfProject.text = basicInfo?.totalCost ?? ""
                self.lblCivilErProject.text = basicInfo?.isItCivilEngineerProject ?? ""
                self.lblDistanceToTerritory.text = basicInfo?.distance ?? ""
                self.lblDemolitiont.text = basicInfo?.demolition ?? ""
                self.lblTopography.text = basicInfo?.topography ?? ""
                self.lblLandToBuild.text = basicInfo?.landToBuild ?? ""
                self.lblEarthwork.text = basicInfo?.earthWork ?? ""
                if(self.lblEarthwork.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.earthworkValueView.isHidden = false
                } else {
                    self.earthworkValueView.isHidden = true
                }
                self.lblDepthOfExcavsation.text = basicInfo?.earthWorkValue ?? ""
                self.lblUpperFloors.text = basicInfo?.upperFloors ?? ""
                self.lblSearch.text = basicInfo?.search ?? ""
                self.lblExecutionExcavation.text = basicInfo?.execution ?? ""
                
                
                var arr = NSMutableArray()
                for item in basicInfo?.technique ?? [] {
                    arr.add(item)
                }
                self.lblTechnique.text = arr.componentsJoined(by: ",")
                
                self.lblLoweringWaterTable.text = basicInfo?.loweringOfWaterTable ?? ""
                self.lblStructuralFoundation.text = basicInfo?.structureFormula ?? ""
                self.lblStalling.text = basicInfo?.stalling ?? ""
                
                var underPinArr = NSMutableArray()
                for item in basicInfo?.underpinning ?? [] {
                    underPinArr.add(item)
                }
                self.lblUnderpinning.text = underPinArr.componentsJoined(by: ",")
                
                self.lblGeothermalProbes.text = basicInfo?.drillingForGeothermal ?? ""
                if(self.lblGeothermalProbes.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.earthworkValueView.isHidden = false
                    self.boreholesView.isHidden = false
                } else {
                    self.earthworkValueView.isHidden = true
                    self.boreholesView.isHidden = true
                }
                
                
                self.lblSolarInstallationInstalled.text = basicInfo?.areSolarInstalled ?? ""
                if(self.lblSolarInstallationInstalled.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.installationTypeView.isHidden = false
                } else {
                    self.installationTypeView.isHidden = true
                }
                
                var solarTypeArr = NSMutableArray()
                for item in basicInfo?.underpinning ?? [] {
                    solarTypeArr.add(item)
                }
                self.lblInstallationType.text = solarTypeArr.componentsJoined(by: ",")
                self.lblDuringTransformations.text = basicInfo?.changesToStructure ?? ""
                self.lblRoofWork.text = basicInfo?.roofWork ?? ""
                self.lblDangerZone.text = basicInfo?.dangerZone ?? ""
                self.lblDangerZoneSpecification.text = basicInfo?.dangerZone ?? ""
                self.lblNeighbourThirdParty.text = basicInfo?.conditionOfThirdPartyWork ?? ""
                self.lblSbbLiability.text = basicInfo?.statutoryCivilLiability ?? ""
                self.lblSbbLiabilityAgreement.text = basicInfo?.agreement ?? ""
                self.lblRequirements.text = basicInfo?.requirements ?? ""
                if self.lblRequirements.text == "yes" || self.lblRequirements.text == "Yes"{
                    self.reasonView.isHidden = false
                    self.lblRequirementsReason.text = basicInfo?.why ?? ""
                }
                
                
                self.lblMaps.text = basicInfo?.maps ?? ""
                self.lblQuotation.text = basicInfo?.quotation ?? ""
                self.lblReports.text = basicInfo?.reports ?? ""
                self.lblNotes.text = basicInfo?.notes ?? ""
                self.lblDate.text = basicInfo?.date ?? ""
                self.lblPlace.text = basicInfo?.place ?? ""
                
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


extension ConstructionVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

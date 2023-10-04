//
//  MotorVehicleFormVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/08/23.
//

import UIKit

class MotorVehicleFormVC: UIViewController {
    
    @IBOutlet weak var personalEffectAmountView: UIView!
    @IBOutlet weak var damageAmountView: UIView!
    @IBOutlet weak var damageDateView: UIView!
    @IBOutlet weak var damageTypeView: UIView!
    @IBOutlet weak var accidentResponsibleView: UIView!
    @IBOutlet weak var accidentAmountView: UIView!
    @IBOutlet weak var accidentDateView: UIView!
    @IBOutlet weak var dlAmountView: UIView!
    @IBOutlet weak var dlDurationView: UIView!
    @IBOutlet weak var dlReasonView: UIView!
    @IBOutlet weak var policyNumberView: UIView!
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var holderNameView: UIView!
    @IBOutlet weak var vehicle2GrayCardDocView: UIView!
    @IBOutlet weak var vehicle2GrayCardView: UIView!
    @IBOutlet weak var vehicle1TypeView: UIView!
    @IBOutlet weak var vehicle1BrandTypeView: UIView!
    @IBOutlet weak var vehicle1regNumberView: UIView!
    @IBOutlet weak var vehicle1NumberOfPlacesView: UIView!
    @IBOutlet weak var vehicle1ApprovalNumberView: UIView!
    @IBOutlet weak var vehicle1EspSystemView: UIView!
    @IBOutlet weak var vehicle1DisplacementView: UIView!
    @IBOutlet weak var vehicle1timeReleaseView: UIView!
    @IBOutlet weak var vehicle1PriceCatalogueView: UIView!
    @IBOutlet weak var vehicle1AccesoriesPriceView: UIView!
    @IBOutlet weak var vehicle1UploadWeightView: UIView!
    @IBOutlet weak var vehicle1TotalWeightView: UIView!
    
    @IBOutlet weak var vehicle1AnalysisGarageView: UIView!
    @IBOutlet weak var vehicle1AnalysisUseofvehicleView: UIView!
    @IBOutlet weak var vehicle1AnalysisAnnualMileageView: UIView!
    @IBOutlet weak var vehicle1AnalysisOdometerView: UIView!
    
    
    @IBOutlet weak var vehicle2TypeView: UIView!
    @IBOutlet weak var vehicle2BrandTypeView: UIView!
    @IBOutlet weak var vehicle2regNumberView: UIView!
    @IBOutlet weak var vehicle2NumberOfPlacesView: UIView!
    @IBOutlet weak var vehicle2ApprovalNumberView: UIView!
    @IBOutlet weak var vehicle2EspSystemView: UIView!
    @IBOutlet weak var vehicle2DisplacementView: UIView!
    @IBOutlet weak var vehicle2timeReleaseView: UIView!
    @IBOutlet weak var vehicle2PriceCatalogueView: UIView!
    @IBOutlet weak var vehicle2AccesoriesPriceView: UIView!
    @IBOutlet weak var vehicle2UploadWeightView: UIView!
    @IBOutlet weak var vehicle2TotalWeightView: UIView!
    
    @IBOutlet weak var vehicle2AnalysisGarageView: UIView!
    @IBOutlet weak var vehicle2AnalysisUseofvehicleView: UIView!
    @IBOutlet weak var vehicle2AnalysisAnnualMileageView: UIView!
    @IBOutlet weak var vehicle2AnalysisOdometerView: UIView!
    
    
    
    
    
    @IBOutlet weak var vehicle1grayCardDocView: UIView!
    @IBOutlet weak var driverAddressView: UIView!
    @IBOutlet weak var driverContactView: UIView!
    @IBOutlet weak var driverNameView: UIView!
    @IBOutlet weak var lblPersonelEffectsAmount: UILabel!
    @IBOutlet weak var lblCascoParkingDamage: UILabel!
    @IBOutlet weak var lblCascoBonusProtection: UILabel!
    @IBOutlet weak var lblDamageAmount: UILabel!
    @IBOutlet weak var lblDamageDate: UILabel!
    @IBOutlet weak var lblDamageType: UILabel!
    @IBOutlet weak var trafficAccidentDate: UILabel!
    @IBOutlet weak var trafficAccidentAmount: UILabel!
    @IBOutlet weak var trafficAccidentResponsible: UILabel!
    @IBOutlet weak var vehicle2GrayCardDoc: UILabel!
    @IBOutlet weak var vehicle2Graycard: UILabel!
    @IBOutlet weak var vehicle1Type: UILabel!
    @IBOutlet weak var vehicle1BrandType: UILabel!
    @IBOutlet weak var vehicle1regNumber: UILabel!
    @IBOutlet weak var vehicle1NumberOfPlaces: UILabel!
    @IBOutlet weak var vehicle1ApprovalNumber: UILabel!
    @IBOutlet weak var vehicle1EspSystem: UILabel!
    @IBOutlet weak var vehicle1Displacement: UILabel!
    @IBOutlet weak var vehicle1timeRelease: UILabel!
    @IBOutlet weak var vehicle1PriceCatalogue: UILabel!
    @IBOutlet weak var vehicle1AccesoriesPrice: UILabel!
    @IBOutlet weak var vehicle1UploadWeight: UILabel!
    @IBOutlet weak var vehicle1TotalWeight: UILabel!
    
    @IBOutlet weak var vehicle1AnalysisGarage: UILabel!
    @IBOutlet weak var vehicle1AnalysisUseofvehicle: UILabel!
    @IBOutlet weak var vehicle1AnalysisAnnualMileage: UILabel!
    @IBOutlet weak var vehicle1AnalysisOdometer: UILabel!
    
    
    
    @IBOutlet weak var vehicle2BrandType: UILabel!
    @IBOutlet weak var vehicle2Type: UILabel!
    @IBOutlet weak var vehicle2regNumber: UILabel!
    @IBOutlet weak var vehicle2NumberOfPlaces: UILabel!
    @IBOutlet weak var vehicle2ApprovalNumber: UILabel!
    @IBOutlet weak var vehicle2EspSystem: UILabel!
    @IBOutlet weak var vehicle2Displacement: UILabel!
    @IBOutlet weak var vehicle2timeRelease: UILabel!
    @IBOutlet weak var vehicle2PriceCatalogue: UILabel!
    @IBOutlet weak var vehicle2AccesoriesPrice: UILabel!
    @IBOutlet weak var vehicle2UploadWeight: UILabel!
    @IBOutlet weak var vehicle2TotalWeight: UILabel!
    
    @IBOutlet weak var vehicle2AnalysisGarage: UILabel!
    @IBOutlet weak var vehicle2AnalysisUseofvehicle: UILabel!
    @IBOutlet weak var vehicle2AnalysisAnnualMileage: UILabel!
    @IBOutlet weak var vehicle2AnalysisOdometer: UILabel!
    
    
    
    
    
    @IBOutlet weak var lblNameOfInstitution: UILabel!
    @IBOutlet weak var lblContractNumber: UILabel!
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
    
    @IBOutlet weak var lblInsuranceType: UILabel!
    @IBOutlet weak var lblEffectiveDate: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblDL: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblSourceOfFunding: UILabel!
    @IBOutlet weak var lblDrivers: UILabel!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblDriverContact: UILabel!
    @IBOutlet weak var lblDriverAddress: UILabel!
    @IBOutlet weak var lblDriverHouse: UILabel!
    @IBOutlet weak var lblDriverProvisionalLicence: UILabel!
    @IBOutlet weak var lblGrayCard: UILabel!
    @IBOutlet weak var lblAttachDoc: UILabel!
    @IBOutlet weak var lblSecondVichele: UILabel!
    @IBOutlet weak var lblVihicleOwner: UILabel!
    @IBOutlet weak var lblHolderName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblPolicyNumber: UILabel!
    @IBOutlet weak var lblExistingCompany: UILabel!
    @IBOutlet weak var lblDlWithDrawn: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTrafficaccident: UILabel!
    @IBOutlet weak var lblDamage: UILabel!
    @IBOutlet weak var lblBonusProtection: UILabel!
    @IBOutlet weak var lblCoverage: UILabel!
    @IBOutlet weak var lblCasco: UILabel!
    @IBOutlet weak var lblParkingDamage: UILabel!
    @IBOutlet weak var lblSingleParkingDamage: UILabel!
    @IBOutlet weak var lblHeadlightCover: UILabel!
    @IBOutlet weak var lblGarage: UILabel!
    @IBOutlet weak var lblReplaceMentvichele: UILabel!
    @IBOutlet weak var lblPersnalEffect: UILabel!
    @IBOutlet weak var lblOccupantProtection: UILabel!
    @IBOutlet weak var lblRecourse: UILabel!
    @IBOutlet weak var lblRemark: UILabel!
    
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
    
    @IBOutlet weak var customerDataTitle: UILabel!
    @IBOutlet weak var customerDataFullNameTitle: UILabel!
    @IBOutlet weak var customerDataAddressTitle: UILabel!
    @IBOutlet weak var customerDataDobTitle: UILabel!
    @IBOutlet weak var customerDataNationalityTitle: UILabel!
    @IBOutlet weak var customerDataDrivingLicenseDtTitle: UILabel!
    @IBOutlet weak var customerDataPaymentMethodTitle: UILabel!
    @IBOutlet weak var customerDataFundingTitle: UILabel!
    @IBOutlet weak var customerDataInstitutionNameTitle: UILabel!
    @IBOutlet weak var customerDataContactNumberTitle: UILabel!
    @IBOutlet weak var customerDataOtherDriversTitle: UILabel!
    @IBOutlet weak var customerDataDriverNameTitle: UILabel!
    @IBOutlet weak var customerDataDriverContactNoTitle: UILabel!
    @IBOutlet weak var customerDataDriverAddressTitle: UILabel!
    @IBOutlet weak var customerDataDriverCommonHouseholdTitle: UILabel!
    @IBOutlet weak var customerDataDriverProvidionryLicenseTitle: UILabel!
    @IBOutlet weak var customerDataGrayCardTitle: UILabel!
    @IBOutlet weak var customerDataAttchedDocTitle: UILabel!
    
    @IBOutlet weak var vehicleDataTitle: UILabel!
    @IBOutlet weak var vehicleDataVehicleTypeTitle: UILabel!
    @IBOutlet weak var vehicleDataBrandAndTypeTitle: UILabel!
    @IBOutlet weak var vehicleDataRegNumberTitle: UILabel!
    @IBOutlet weak var vehicleDataNumberPlacesTitle: UILabel!
    @IBOutlet weak var vehicleDataApprovalNumberTitle: UILabel!
    @IBOutlet weak var vehicleDataEspSystemTitle: UILabel!
    @IBOutlet weak var vehicleDataDisplacementTitle: UILabel!
    @IBOutlet weak var vehicleData1TimeReleaseTitle: UILabel!
    @IBOutlet weak var vehicleDataPriceCatalogueTitle: UILabel!
    @IBOutlet weak var vehicleDataAccessoriesPricesTitle: UILabel!
    @IBOutlet weak var vehicleDataUploadedWeightTitle: UILabel!
    @IBOutlet weak var vehicleDataTotalWeightTitle: UILabel!
    
    @IBOutlet weak var AnalysisTitle: UILabel!
    @IBOutlet weak var AnalysisGarageClosedTitle: UILabel!
    @IBOutlet weak var AnalysisUseVehicleTitle: UILabel!
    @IBOutlet weak var AnalysisAnnualMilegeTitle: UILabel!
    @IBOutlet weak var AnalysisOdometerReadingTitle: UILabel!
    @IBOutlet weak var AnalysisSecondVehicleInsuredTitle: UILabel!
    @IBOutlet weak var AnalysisGrayCardTitle: UILabel!
    @IBOutlet weak var AnalysisGrayCardDocsTitle: UILabel!
    
    @IBOutlet weak var secondVehicleDataTitle: UILabel!
    @IBOutlet weak var secondVehicleDataVehicleTypeTitle: UILabel!
    @IBOutlet weak var secondVehicleDataBrandAndTypeTitle: UILabel!
    @IBOutlet weak var secondVehicleDataRegNumberTitle: UILabel!
    @IBOutlet weak var secondVehicleDataNumberPlacesTitle: UILabel!
    @IBOutlet weak var secondVehicleDataApprovalNumberTitle: UILabel!
    @IBOutlet weak var secondVehicleDataEspSystemTitle: UILabel!
    @IBOutlet weak var secondVehicleDataDisplacementTitle: UILabel!
    @IBOutlet weak var secondVehicleData1TimeReleaseTitle: UILabel!
    @IBOutlet weak var secondVehicleDataPriceCatalogueTitle: UILabel!
    @IBOutlet weak var secondVehicleDataAccessoriesPricesTitle: UILabel!
    @IBOutlet weak var secondVehicleDataUploadedWeightTitle: UILabel!
    @IBOutlet weak var secondVehicleDataTotalWeightTitle: UILabel!
    @IBOutlet weak var secondVehicleAnalysisTitle: UILabel!
    @IBOutlet weak var secondVehicleAnalysisGarageClosedTitle: UILabel!
    @IBOutlet weak var secondVehicleAnalysisUseVehicleTitle: UILabel!
    @IBOutlet weak var secondVehicleAnalysisAnnualMilegeTitle: UILabel!
    @IBOutlet weak var secondVehicleAnalysisOdometerReadingTitle: UILabel!
    
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizMotorVehicleOwnerTitle: UILabel!
    @IBOutlet weak var quizHolderNameTitle: UILabel!
    @IBOutlet weak var quizCompanyNameTitle: UILabel!
    @IBOutlet weak var quizPolicyNumberTitle: UILabel!
    @IBOutlet weak var quizExistingPolicyTitle: UILabel!
    @IBOutlet weak var quizDrivingLicenseTitle: UILabel!
    @IBOutlet weak var quizReasonTitle: UILabel!
    @IBOutlet weak var quizDurationTitle: UILabel!
    @IBOutlet weak var quizAmountTitle: UILabel!
    @IBOutlet weak var quizTrafficAccidentTitle: UILabel!
    @IBOutlet weak var quizDateTitle: UILabel!
    @IBOutlet weak var quizAccidentAmountTitle: UILabel!
    @IBOutlet weak var quizResponsibleTitle: UILabel!
    @IBOutlet weak var quizResponsibleTypeTitle: UILabel!
    @IBOutlet weak var quizCascoTitle: UILabel!
    @IBOutlet weak var quizCascoDamageTypeTitle: UILabel!
    @IBOutlet weak var quizCascoDateTitle: UILabel!
    @IBOutlet weak var quizCascoAmountTitle: UILabel!
    
    @IBOutlet weak var benefitsBonusProtectionTitle: UILabel!
    @IBOutlet weak var benefitsCoverageTitle: UILabel!
    @IBOutlet weak var cascoTitle: UILabel!
    @IBOutlet weak var cascoBonusProtectionTitle: UILabel!
    @IBOutlet weak var cascoParkingDamageTitle: UILabel!
    @IBOutlet weak var cascoSingleParkingDamageTitle: UILabel!
    @IBOutlet weak var cascoHeadlightTitle: UILabel!
    @IBOutlet weak var cascoGrageChoiceTitle: UILabel!
    @IBOutlet weak var cascoVehicleRentalTitle: UILabel!
    @IBOutlet weak var cascoPersonaleffectsTitle: UILabel!
    @IBOutlet weak var cascoPersonaleffectsAmountTitle: UILabel!
    @IBOutlet weak var cascoOccupantProtectionTitle: UILabel!
    
    @IBOutlet weak var sAdditionalCoverTitle: UILabel!
    @IBOutlet weak var sAdditionalCoverWaiverTitle: UILabel!
    @IBOutlet weak var sAdditionalCoverRemarkTitle: UILabel!
    
    
    
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
        leadInsuranceViewModel.motorVehicleDelegate = self
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
        self.lblTitleMemberInfoInsuranceType.text = "Insurance Type".localized()
        self.lblTitleMemberInfo.text = "Member Information".localized()

        self.customerDataTitle.text = "Customer Data".localized()
        self.customerDataFullNameTitle.text = "Full Name".localized()
        self.customerDataAddressTitle.text = "Address".localized()
        self.customerDataDobTitle.text = "Date of Birth".localized()
        self.customerDataNationalityTitle.text = "Nationality/Permit".localized()
        self.customerDataDrivingLicenseDtTitle.text = "Driving License Date".localized()
        self.customerDataPaymentMethodTitle.text = "Payment Method".localized()
        self.customerDataFundingTitle.text = "Source of Funding".localized()
        self.customerDataInstitutionNameTitle.text = "Name of Institution".localized()
        self.customerDataContactNumberTitle.text = "Contract Number".localized()
        self.customerDataOtherDriversTitle.text = "Are there other drivers?".localized()
        self.customerDataDriverNameTitle.text = "Driver Name".localized()
        self.customerDataDriverContactNoTitle.text = "Driver Contact Number".localized()
        self.customerDataDriverAddressTitle.text = "Driver Address".localized()
        self.customerDataDriverCommonHouseholdTitle.text = "Are there other drivers outside the common household?".localized()
        self.customerDataDriverProvidionryLicenseTitle.text = "Are there any drivers who have a provisional or probationary licence?".localized()
        self.customerDataGrayCardTitle.text = "Do you have a gray card - sales contract?".localized()
        self.customerDataAttchedDocTitle.text = "Attached Document".localized()

        self.vehicleDataTitle.text = "Vehicle Data".localized()
        self.vehicleDataVehicleTypeTitle.text = "Type of Vehicle".localized()
        self.vehicleDataBrandAndTypeTitle.text = "Brand & Type ".localized()
        self.vehicleDataRegNumberTitle.text = "Registration Number".localized()
        self.vehicleDataNumberPlacesTitle.text = "Number of Places".localized()
        self.vehicleDataApprovalNumberTitle.text = "Approval Number (Type Approval)".localized()
        self.vehicleDataEspSystemTitle.text = "ESP system".localized()
        self.vehicleDataDisplacementTitle.text = "Displacement".localized()
        self.vehicleData1TimeReleaseTitle.text = "1 time Release".localized()
        self.vehicleDataPriceCatalogueTitle.text = "Price Catalogue".localized()
        self.vehicleDataAccessoriesPricesTitle.text = "Accessories Prices".localized()
        self.vehicleDataUploadedWeightTitle.text = "Uploaded Weight".localized()
        self.vehicleDataTotalWeightTitle.text = "Total Weight".localized()

        self.AnalysisTitle.text = "ANALYSIS OF THE USE OF 1ER VEHICLE".localized()
        self.AnalysisGarageClosedTitle.text = "Garage closed".localized()
        self.AnalysisUseVehicleTitle.text = "Use of vehicle".localized()
        self.AnalysisAnnualMilegeTitle.text = "Annual mileage".localized()
        self.AnalysisOdometerReadingTitle.text = "Current vehicle odometer reading".localized()
        self.AnalysisSecondVehicleInsuredTitle.text = "If a second vehicle must be insured?".localized()
        self.AnalysisGrayCardTitle.text = "Do you have a gray card - sales contract?".localized()
        self.AnalysisGrayCardDocsTitle.text = "Gray Card Docs".localized()

        self.secondVehicleDataTitle.text = "2nd vehicle data(if in PI)".localized()
        self.secondVehicleDataVehicleTypeTitle.text = "Type of Vehicle".localized()
        self.secondVehicleDataBrandAndTypeTitle.text = "Brand & Type ".localized()
        self.secondVehicleDataRegNumberTitle.text = "Registration Number".localized()
        self.secondVehicleDataNumberPlacesTitle.text = "Number of Places".localized()
        self.secondVehicleDataApprovalNumberTitle.text = "Approval Number (Type Approval)".localized()
        self.secondVehicleDataEspSystemTitle.text = "ESP system".localized()
        self.secondVehicleDataDisplacementTitle.text = "Displacement".localized()
        self.secondVehicleData1TimeReleaseTitle.text = "1 time Release".localized()
        self.secondVehicleDataPriceCatalogueTitle.text = "Price Catalogue".localized()
        self.secondVehicleDataAccessoriesPricesTitle.text = "Accessories Prices".localized()
        self.secondVehicleDataUploadedWeightTitle.text = "Uploaded Weight".localized()
        self.secondVehicleDataTotalWeightTitle.text = "Total Weight".localized()
        self.secondVehicleAnalysisTitle.text = "ANALYSIS OF THE USE OF 2ND VEHICLE".localized()
        self.secondVehicleAnalysisGarageClosedTitle.text = "Garage closed".localized()
        self.secondVehicleAnalysisUseVehicleTitle.text = "Use of vehicle".localized()
        self.secondVehicleAnalysisAnnualMilegeTitle.text = "Annual mileage".localized()
        self.secondVehicleAnalysisOdometerReadingTitle.text = "Current vehicle odometer reading".localized()

        self.quizTitle.text = "Quiz".localized()
        self.quizMotorVehicleOwnerTitle.text = "Are you currently insured as a motor vehicle owner?".localized()
        self.quizHolderNameTitle.text = "Holder Name".localized()
        self.quizCompanyNameTitle.text = "Company Name".localized()
        self.quizPolicyNumberTitle.text = "Policy Number".localized()
        self.quizExistingPolicyTitle.text = "Will this offer replace an existing policy with another company?".localized()
        self.quizDrivingLicenseTitle.text = "Was your driving license withdrawn?".localized()
        self.quizReasonTitle.text = "Reason".localized()
        self.quizDurationTitle.text = "Duration".localized()
        self.quizAmountTitle.text = "Amount".localized()
        self.quizTrafficAccidentTitle.text = "Have you been involved in a traffic accident as a driver or vehicle owner?".localized()
        self.quizDateTitle.text = "Date".localized()
        self.quizAccidentAmountTitle.text = "Amount".localized()
        self.quizResponsibleTitle.text = "Responsible".localized()
        self.quizResponsibleTypeTitle.text = "Responsible Type".localized()
        self.quizCascoTitle.text = "Independently of the existence of a casco, have the vehicles belonging to you or driven by yourself already suffered damage?".localized()
        self.quizCascoDamageTypeTitle.text = "Damage Type".localized()
        self.quizCascoDateTitle.text = "Date".localized()
        self.quizCascoAmountTitle.text = "Amount".localized()

        self.benefitsBonusProtectionTitle.text = "Bonus Protection".localized()
        self.benefitsCoverageTitle.text = "Coverage 0.0 per thousand (alcohol)".localized()
        self.cascoTitle.text = "CASCO".localized()
        self.cascoBonusProtectionTitle.text = "Bonus Protection".localized()
        self.cascoParkingDamageTitle.text = "parking damage more".localized()
        self.cascoSingleParkingDamageTitle.text = "Simple parking damage".localized()
        self.cascoHeadlightTitle.text = "Headlight cover".localized()
        self.cascoGrageChoiceTitle.text = "Free choice of garage".localized()
        self.cascoVehicleRentalTitle.text = "Replacement vehicle rental".localized()
        self.cascoPersonaleffectsTitle.text = "Personal effects".localized()
        self.cascoPersonaleffectsAmountTitle.text = "Personal effects Amount".localized()
        self.cascoOccupantProtectionTitle.text = "Occupant Protection".localized()

        self.sAdditionalCoverTitle.text = "ADDITIONAL COVER".localized()
        self.sAdditionalCoverWaiverTitle.text = "Waiver of recourse to gross negligence".localized()
        self.sAdditionalCoverRemarkTitle.text = "Remark".localized()
        
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
        leadInsuranceViewModel.MotorVehicleApiCall(param: param)
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

extension MotorVehicleFormVC : MotorVehicleProtocolData {
    
    func setData(data: MotorVehicleModel) {
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
                self.lblInsuranceType.text = data.data?.insuranceType?.localized() ?? ""

                let basicInfo = data.data?.memberDetails
                let fname =  basicInfo?.firstName?.capitalized   ?? ""
                let lname =  basicInfo?.lastName?.capitalized    ?? ""
                self.lblMemberInfoFullName.text = fname + " " + lname
                
                let metadata = data.data?.metadata
                let info = data.data?.metadata?.personalDetails
                let personalfname =  info?.firstName?.capitalized   ?? ""
                let personallname =  info?.lastName?.capitalized    ?? ""
                self.lblFullName.text = personalfname + " " + personallname
                self.lblAddress.text = info?.address ?? ""
                self.lblDob.text = info?.dob ?? ""
                self.lblNationality.text = info?.nationality ?? ""
                self.lblDL.text = metadata?.drivingLicenseDate ?? ""
                self.lblPaymentMethod.text = metadata?.paymentMethod ?? ""
                self.lblSourceOfFunding.text = metadata?.sourceOfFunding ?? ""
                self.lblSourceOfFunding.text = metadata?.sourceOfFunding ?? ""
                self.lblContractNumber.text = metadata?.contractNumber ?? ""
                self.lblNameOfInstitution.text = metadata?.nameOfInstitution ?? ""
                self.lblDrivers.text = metadata?.otherDrivers ?? ""
                
                if(self.lblDrivers.text!.caseInsensitiveCompare("yes") == .orderedSame){
                    self.driverNameView.isHidden = false
                    self.driverContactView.isHidden = false
                    self.driverAddressView.isHidden = false
                } else {
                    self.driverNameView.isHidden = true
                    self.driverContactView.isHidden = true
                    self.driverAddressView.isHidden = true
                }
                
                let driverInfo = data.data?.metadata?.driverInfo
                self.lblDriverName.text = driverInfo?.name ?? ""
                self.lblDriverContact.text = driverInfo?.contactNumber ?? ""
                self.lblDriverAddress.text = driverInfo?.address ?? ""
                
                self.lblDriverHouse.text = metadata?.otherDriversOutsideCommonHousehold ?? ""
                self.lblDriverProvisionalLicence.text = metadata?.anyDriversWithProvisionalLicense ?? ""
                self.lblGrayCard.text = metadata?.haveGrayCard ?? ""
                
                if(self.lblGrayCard.text!.caseInsensitiveCompare("yes") == .orderedSame){
                    self.vehicle1grayCardDocView.isHidden = false
                    self.vehicle1TypeView.isHidden = true
                    self.vehicle1BrandTypeView.isHidden = true
                    self.vehicle1regNumberView.isHidden = true
                    self.vehicle1NumberOfPlacesView.isHidden = true
                    self.vehicle1ApprovalNumberView.isHidden = true
                    self.vehicle1EspSystemView.isHidden = true
                    self.vehicle1DisplacementView.isHidden = true
                    self.vehicle1timeReleaseView.isHidden = true
                    self.vehicle1PriceCatalogueView.isHidden = true
                    self.vehicle1AccesoriesPriceView.isHidden = true
                    self.vehicle1UploadWeightView.isHidden = true
                    self.vehicle1TotalWeightView.isHidden = true
                    
                    self.vehicle1AnalysisGarageView.isHidden = true
                    self.vehicle1AnalysisOdometerView.isHidden = true
                    self.vehicle1AnalysisUseofvehicleView.isHidden = true
                    self.vehicle1AnalysisAnnualMileageView.isHidden = true
                    
                } else {
                    self.vehicle1grayCardDocView.isHidden = true
                    self.vehicle1TypeView.isHidden = false
                    self.vehicle1BrandTypeView.isHidden = false
                    self.vehicle1regNumberView.isHidden = false
                    self.vehicle1NumberOfPlacesView.isHidden = false
                    self.vehicle1ApprovalNumberView.isHidden = false
                    self.vehicle1EspSystemView.isHidden = false
                    self.vehicle1DisplacementView.isHidden = false
                    self.vehicle1timeReleaseView.isHidden = false
                    self.vehicle1PriceCatalogueView.isHidden = false
                    self.vehicle1AccesoriesPriceView.isHidden = false
                    self.vehicle1UploadWeightView.isHidden = false
                    self.vehicle1TotalWeightView.isHidden = false
                    
                    self.vehicle1AnalysisGarageView.isHidden = false
                    self.vehicle1AnalysisOdometerView.isHidden = false
                    self.vehicle1AnalysisUseofvehicleView.isHidden = false
                    self.vehicle1AnalysisAnnualMileageView.isHidden = false
                }
                
                
                self.lblAttachDoc.text = metadata?.attachCard ?? ""
                
                let vehicleDetails = metadata?.vehicleDetails
                self.vehicle1Type.text = vehicleDetails?.typeOfVehicle ?? ""
                self.vehicle1BrandType.text = vehicleDetails?.brand ?? ""
                self.vehicle1regNumber.text = vehicleDetails?.regNo ?? ""
                self.vehicle1Displacement.text = vehicleDetails?.displacement ?? ""
                self.vehicle1NumberOfPlaces.text = vehicleDetails?.noOfPlaces ?? ""
                self.vehicle1ApprovalNumber.text = vehicleDetails?.approvalNo ?? ""
                self.vehicle1EspSystem.text = vehicleDetails?.espSystem ?? ""
                self.vehicle1timeRelease.text = vehicleDetails?.firstTimeRelease ?? ""
                self.vehicle1PriceCatalogue.text = vehicleDetails?.priceCatalogue ?? ""
                self.vehicle1AccesoriesPrice.text = vehicleDetails?.accessoriesPrices ?? ""
                self.vehicle1UploadWeight.text = vehicleDetails?.uploadedWeight ?? ""
                self.vehicle1TotalWeight.text = vehicleDetails?.totalWeight ?? ""
                
                self.vehicle1AnalysisGarage.text = vehicleDetails?.garageClosed ?? ""
                self.vehicle1AnalysisUseofvehicle.text = vehicleDetails?.useOfVehicle ?? ""
                self.vehicle1AnalysisAnnualMileage.text = vehicleDetails?.annualMileage ?? ""
                self.vehicle1AnalysisOdometer.text = vehicleDetails?.meterReading ?? ""
                
                
                let secondvehicleDetails = metadata?.secondVehicleDetails
                self.vehicle2Type.text = secondvehicleDetails?.typeOfVehicle ?? ""
                self.vehicle2BrandType.text = secondvehicleDetails?.brand ?? ""
                self.vehicle2regNumber.text = secondvehicleDetails?.regNo ?? ""
                self.vehicle2Displacement.text = secondvehicleDetails?.displacement ?? ""
                self.vehicle2NumberOfPlaces.text = secondvehicleDetails?.noOfPlaces ?? ""
                self.vehicle2ApprovalNumber.text = secondvehicleDetails?.approvalNo ?? ""
                self.vehicle2EspSystem.text = secondvehicleDetails?.espSystem ?? ""
                self.vehicle2timeRelease.text = secondvehicleDetails?.firstTimeRelease ?? ""
                self.vehicle2PriceCatalogue.text = secondvehicleDetails?.priceCatalogue ?? ""
                self.vehicle2AccesoriesPrice.text = secondvehicleDetails?.accessoriesPrices ?? ""
                self.vehicle2UploadWeight.text = secondvehicleDetails?.uploadedWeight ?? ""
                self.vehicle2TotalWeight.text = secondvehicleDetails?.totalWeight ?? ""
                
                self.vehicle2AnalysisGarage.text = secondvehicleDetails?.garageClosed ?? ""
                self.vehicle2AnalysisUseofvehicle.text = secondvehicleDetails?.useOfVehicle ?? ""
                self.vehicle2AnalysisAnnualMileage.text = secondvehicleDetails?.annualMileage ?? ""
                self.vehicle2AnalysisOdometer.text = secondvehicleDetails?.meterReading ?? ""
                
                self.lblSecondVichele.text = metadata?.isSecondVehicleInsured ?? ""
                if(self.lblSecondVichele.text!.caseInsensitiveCompare("no") == .orderedSame) {
                    self.vehicle2GrayCardView.isHidden = true
                    self.vehicle2GrayCardDocView.isHidden = true
                } else {
                    self.vehicle2GrayCardView.isHidden = false
                    self.vehicle2GrayCardDocView.isHidden = true
                }
                self.vehicle2Graycard.text = metadata?.secondVehicleHaveGrayCard ?? ""
                if(self.vehicle2Graycard.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.vehicle2GrayCardDocView.isHidden = false
                    self.vehicle2TypeView.isHidden = true
                    self.vehicle2BrandTypeView.isHidden = true
                    self.vehicle2regNumberView.isHidden = true
                    self.vehicle2NumberOfPlacesView.isHidden = true
                    self.vehicle2ApprovalNumberView.isHidden = true
                    self.vehicle2EspSystemView.isHidden = true
                    self.vehicle2DisplacementView.isHidden = true
                    self.vehicle2timeReleaseView.isHidden = true
                    self.vehicle2PriceCatalogueView.isHidden = true
                    self.vehicle2AccesoriesPriceView.isHidden = true
                    self.vehicle2UploadWeightView.isHidden = true
                    self.vehicle2TotalWeightView.isHidden = true
                    
                    self.vehicle2AnalysisGarageView.isHidden = true
                    self.vehicle2AnalysisOdometerView.isHidden = true
                    self.vehicle2AnalysisUseofvehicleView.isHidden = true
                    self.vehicle2AnalysisAnnualMileageView.isHidden = true
                } else {
                    self.vehicle2GrayCardDocView.isHidden = true
                    self.vehicle2TypeView.isHidden = false
                    self.vehicle2BrandTypeView.isHidden = false
                    self.vehicle2regNumberView.isHidden = false
                    self.vehicle2NumberOfPlacesView.isHidden = false
                    self.vehicle2ApprovalNumberView.isHidden = false
                    self.vehicle2EspSystemView.isHidden = false
                    self.vehicle2DisplacementView.isHidden = false
                    self.vehicle2timeReleaseView.isHidden = false
                    self.vehicle2PriceCatalogueView.isHidden = false
                    self.vehicle2AccesoriesPriceView.isHidden = false
                    self.vehicle2UploadWeightView.isHidden = false
                    self.vehicle2TotalWeightView.isHidden = false
                    
                    self.vehicle2AnalysisGarageView.isHidden = false
                    self.vehicle2AnalysisOdometerView.isHidden = false
                    self.vehicle2AnalysisUseofvehicleView.isHidden = false
                    self.vehicle2AnalysisAnnualMileageView.isHidden = false
                }
                
                
                
                
                self.vehicle2GrayCardDoc.text = metadata?.attachSecondVehicleCard ?? ""
                self.lblVihicleOwner.text = metadata?.areYouInsuredAsVehicleOwner ?? ""
                
                if(self.lblVihicleOwner.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.holderNameView.isHidden = false
                    self.companyNameView.isHidden = false
                    self.policyNumberView.isHidden = false
                } else {
                    self.holderNameView.isHidden = true
                    self.companyNameView.isHidden = true
                    self.policyNumberView.isHidden = true
                }
                
                
                self.lblExistingCompany.text = metadata?.policyReplacedByAnotherCompany ?? ""
                
                let vehicleowner = metadata?.vehicleOwnerDetails
                
                self.lblHolderName.text = vehicleowner?.holderName ?? ""
                self.lblCompanyName.text = vehicleowner?.companyName ?? ""
                self.lblPolicyNumber.text = vehicleowner?.policyNo ?? ""
                                
                self.lblDlWithDrawn.text = metadata?.licenceWithdrawn ?? ""
                
                if(self.lblDlWithDrawn.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.dlReasonView.isHidden = false
                    self.dlAmountView.isHidden = false
                    self.dlDurationView.isHidden = false
                } else {
                    self.dlReasonView.isHidden = true
                    self.dlAmountView.isHidden = true
                    self.dlDurationView.isHidden = true
                }
                
                let licenseWithrawnDetails = metadata?.licenceWithdrawnDetails
                self.lblReason.text = licenseWithrawnDetails?.reason ?? ""
                self.lblDuration.text = licenseWithrawnDetails?.duration ?? ""
                self.lblAmount.text = licenseWithrawnDetails?.amount ?? ""
                
                self.lblTrafficaccident.text = metadata?.involvedInTrafficAccident ?? ""
                
                if(self.lblTrafficaccident.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.accidentDateView.isHidden = false
                    self.accidentAmountView.isHidden = false
                    self.accidentResponsibleView.isHidden = false
                } else {
                    self.accidentDateView.isHidden = true
                    self.accidentAmountView.isHidden = true
                    self.accidentResponsibleView.isHidden = true
                }
                
                let trafficAccidentDetails = metadata?.trafficAccidentDetails
                self.trafficAccidentDate.text = trafficAccidentDetails?.date ?? ""
                self.trafficAccidentAmount.text = trafficAccidentDetails?.amount ?? ""
                self.trafficAccidentResponsible.text = trafficAccidentDetails?.responsible ?? ""
                
                self.lblDamage.text = metadata?.alreadySufferedDamage ?? ""
                
                if(self.lblDamage.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.damageDateView.isHidden = false
                    self.damageAmountView.isHidden = false
                    self.damageTypeView.isHidden = false
                } else {
                    self.damageDateView.isHidden = true
                    self.damageAmountView.isHidden = true
                    self.damageTypeView.isHidden = true
                }
                
                let damageDetails = metadata?.sufferedDamageDetails
//                var arr = NSMutableArray()
//                for item in damageDetails?.sufferedDamageDetailsIn as! [String]! {
//                    arr.add(item)
//                }
//                self.lblDamageType.text = arr.componentsJoined(by: ",")
                
                self.lblDamageDate.text = damageDetails?.date ?? ""
                self.lblDamageAmount.text = damageDetails?.amount ?? ""
                
                self.lblBonusProtection.text = metadata?.bonusProtection ?? ""
                self.lblCoverage.text = metadata?.coverage ?? ""
                self.lblCasco.text = metadata?.casco ?? ""
                self.lblCascoBonusProtection.text = metadata?.cascoBonusProtection ?? ""
                self.lblCascoParkingDamage.text = metadata?.singleParkingDamage ?? ""
                self.lblHeadlightCover.text = metadata?.headlightCover ?? ""
                self.lblGarage.text = metadata?.freeChoiceOfGarage ?? ""
                self.lblReplaceMentvichele.text = metadata?.replacementVehicleRental ?? ""
                self.lblPersonelEffectsAmount.text = metadata?.personalEffectsValue ?? ""
                self.lblPersnalEffect.text = metadata?.personalEffects ?? ""
                
                if(self.lblPersnalEffect.text!.caseInsensitiveCompare("yes") == .orderedSame) {
                    self.personalEffectAmountView.isHidden = false
                } else {
                    self.personalEffectAmountView.isHidden = true
                }
                
                self.lblOccupantProtection.text = metadata?.occupantProtection ?? ""
                self.lblRecourse.text = metadata?.waiverOfRecourse ?? ""
                self.lblRemark.text = metadata?.remarks ?? ""
                
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


extension MotorVehicleFormVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
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

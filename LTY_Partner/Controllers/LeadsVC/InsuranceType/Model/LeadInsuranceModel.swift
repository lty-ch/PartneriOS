//
//  LeadInsuranceModel.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/06/23.
//


import Foundation


struct LeadInsuranceModel:Codable {
    let status: String?
    let data: LeadInsuranceData?
    let error: CatError?
}

struct LeadInsuranceData:Codable {
    let leadId, partnerId, agentId, agentName: String?
    let memberDetails: LeadInsuranceMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: LeadInsuranceMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy, updatedBy, createdOn, lastUpdatedOn: String?
}

struct LeadInsuranceMemberDetails:Codable {
    let memberId, firstName, lastName, email: String?
    let mobile, address, country, state: String?
    let city, postCode: String?
}

struct LeadInsuranceMetadata :Codable{
    let type, currentHealthFund: String?
    let postalCode, age, withAccident, models: String?
    let franchise: String?
   
    // for general
    let makeYourRequest: String?
    
    // for travel
    
    let personsToBeInsured: String?
    let adultsCount: Int?
    let childrenCount: Int?
    let desiredBlankets: [String]?
    let assistanceToPeople: [String]?

}

// MARK: - Welcome2
struct InsuranceTypeModel: Codable {
    let status: String?
    let data: InsuranceTypeDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct InsuranceTypeDataClass: Codable {
    let data, businessData: [String]?
}

//MARK:- Travel Model
struct TravelModel :Codable{
    let status: String?
    let data: TravelDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct TravelDataClass :Codable{
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: TravelMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: TravelMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct TravelMemberDetails :Codable{
    let memberId, familyMemberId, firstName, lastName: String?
    let email, countryCode, mobile, dob: String?
    let address, country, state, city: String?
    let postCode, agentId, agentName: String?
    let profilePic: String?
}

// MARK: - Metadata
struct TravelMetadata :Codable{
    let type: String?
    let personsToBeInsured: String?
    let adultsCount, childrenCount: String?
    let personalDetails: TravelPersonalDetails?
    let desiredCovers: [String]?
}

// MARK: - PersonalDetails
struct TravelPersonalDetails :Codable{
    let title, firstName, lastName: String?
    let email: String?
    let countryCode, mobile: String?
    let fax, residencePermit: String?
    let dob: String?
    let streetNo: String?
    let address: String?
    let gender: String?
    let nationality: String?
    let postCode, maritalStatus, civilStatus, occupation: String?
    let bankCc: String?
    let duration, effectiveDate: String?
}



// MARK: - Building Model
struct BuildingModel :Codable{
    let status: String?
    let data: BuildingDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct BuildingDataClass:Codable {
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: BuildingMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: BuildingMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct BuildingMemberDetails :Codable{
    let memberId, familyMemberId, firstName, lastName: String?
    let email, countryCode, mobile, dob: String?
    let address, country, state, city: String?
    let postCode, agentId, agentName: String?
    let profilePic: String?
}

// MARK: - Metadata
struct BuildingMetadata :Codable{
    let type: String?
    let buildingType, securityMeasures, heatingSystem, sumInsured: String?
    let yearOfConstruction, typeOfConstruction, typeOfRoof: String?
    let benefits: [String]?
    let sum, franchise, use, noOfApartment: String?
    let noOfTrade, commercialArea, pastInsured, companyName: String?
    let reason, anyClaims, claimDetails, remarks: String?
}

//MARK:- business legal protection

struct BusinessLegalProModel : Codable {
    let status: String?
    let data: BusinessLegalData?
    let error: CatError?
}


struct BusinessLegalData : Codable {
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: BusinessLegalMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: BusinessLegalMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}


struct BusinessLegalMemberDetails : Codable {
    let memberId, familyMemberId, firstName, lastName: String?
    let email, countryCode, mobile, dob: String?
    let address, country, state, city: String?
    let postCode, agentId, agentName: String?
    let profilePic: String?
}

struct BusinessLegalMetadata : Codable {
    let type: String?
    let proposalFor, fontData, replaceFont: String?
    let companyDetails: BusinessLegalCompanyDetails?
    let insuredForLegal: String?
    let insuredDetails: BusinessLegalInsuredDetails?
    let involvedInLitigation, startDate, endDate, expireDate: String?
}

struct BusinessLegalCompanyDetails : Codable {
    let id: String?
    let business, countryCode, phone, email, streetNo: String?
    let address: String?
    let zipLocation, responsible, startOfContract: String?
    let typeOfActivity, socialReason: String?
    let effectiveDate: String?
}


struct BusinessLegalInsuredDetails : Codable {
    let risk, company, reason: String?
}


//MARK:- Company things model

struct CompanyThingsModel: Codable {
    let status: String?
    let data: CompanyThingsDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct CompanyThingsDataClass: Codable {
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: CompanyThingsMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: CompanyThingsMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct CompanyThingsMemberDetails: Codable {
    let memberId, familyMemberId, firstName, lastName: String?
    let email, countryCode, mobile, dob: String?
    let address, country, state, city: String?
    let postCode, agentId, agentName: String?
    let profilePic: String?
}

// MARK: - Metadata
struct CompanyThingsMetadata : Codable{
    let type: String?
    let companyDetails: CompanyThingsCompanyDetails?
    let insuredForLegal: String?
    let companyLiabilityDetails: CompanyThingsCompanyLiabilityDetails?
    let propertyDetails: CompanyThingsPropertyDetails?
}

// MARK: - CompanyDetails
struct CompanyThingsCompanyDetails: Codable {
    let id: String?
    let business, countryCode, phone, email, streetNo: String?
    let address: String?
    let zipLocation, responsible, startOfContract: String?
    let typeOfActivity, socialReason: String?
    let effectiveDate: String?
}

// MARK: - CompanyLiabilityDetails
struct CompanyThingsCompanyLiabilityDetails: Codable {
    let sectorOfActivity, noOfEmployee, turnOver, payroll: String?
}

// MARK: - PropertyDetails
struct CompanyThingsPropertyDetails: Codable {
    let activityArea, sumAssured, details, goods: String?
    let facilities, lastInsurer, expiryDate, claims: String?
}

//MARK:- ThirdPillarModel

struct ThirdPillarModel : Codable{
    let status: String?
    let data: ThirdPillarData?
    let error: CatError?
}


struct ThirdPillarData : Codable{
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: ThirdPillarMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: ThirdPillarMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}


struct ThirdPillarMemberDetails : Codable{
    let memberId, familyMemberId, firstName, lastName: String?
    let email: String?
    let countryCode: String?
    let mobile, dob, address, country: String?
    let state, city, postCode, agentId: String?
    let agentName: String?
    let profilePic: String?
}

struct ThirdPillarMetadata : Codable{
    let type: String?
    let personalDetails: ThirdPillarPersonalDetails?
    let whatYouWantInOffer, doYouWantPremium, howMuchYouWantToInsure, paymentMethod: String?
    let professionalSituation, job, areYourDetailsDifferent: String?
}


struct ThirdPillarPersonalDetails : Codable{
    let title, firstName, lastName: String?
    let email: String?
    let countryCode, mobile: String?
    let fax, residencePermit: String?
    let dob, streetNo: String?
    let address, gender, city: String?
    let nationality, postCode: String?
    let maritalStatus, civilStatus, occupation, bankCc: String?
    let duration, effectiveDate: String?
}

//MARK:- Animal Data Model



struct AnimalModel :Codable{
    let status: String?
    let data: AnimalData?
    let error: CatError?
}

struct AnimalData :Codable{
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: AnimalMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: AnimalMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

struct AnimalMemberDetails :Codable{
    let memberId, familyMemberId, firstName, lastName: String?
    let email: String?
    let countryCode: String?
    let mobile, dob, address, country: String?
    let state, city, postCode, agentId: String?
    let agentName: String?
    let profilePic: String?
}

struct AnimalMetadata :Codable{
    let type: String?
    let monthlyPremiums, insuranceFor, dogsDeductiblePerCalendarYear, catsDeductiblePerCalendarYear: String?
    let startOfInsurance, startDate, insuredAnimal, gender: String?
    let petsName, dob, color, electronicChipNo: String?
    let personalDetails: AnimalPersonalDetails?
}

struct AnimalPersonalDetails :Codable{
    let title, firstName, lastName, email: String?
    let countryCode, mobile: String?
    let fax, residencePermit, dob: String?
    let streetNo: String?
    let address, gender, city, nationality: String?
    let postCode: String?
    let maritalStatus, civilStatus, occupation, bankCc: String?
    let duration, effectiveDate: String?
}

//MARK:- House hold rc


struct HouseHoldRCModel :Codable{
    let status: String?
    let data: HouseHoldRCData?
    let error: CatError?
}


struct HouseHoldRCData :Codable {
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: HouseHoldRCMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: HouseHoldRCMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}


struct HouseHoldRCMemberDetails :Codable {
    let memberId, familyMemberId, firstName, lastName: String?
    let email: String?
    let countryCode: String?
    let mobile, dob, address, country: String?
    let state, city, postCode, agentId: String?
    let agentName: String?
    let profilePic: String?
}


struct HouseHoldRCMetadata :Codable {
    let type: String?
    let personalDetails: HouseHoldRCPersonalDetails?
    let placeOfRisk, sumInsured, typeOfConstruction: String?
    let benefits: [String]?
    let civilLiability, sum, franchise, areYouOwner: String?
    let complementaryCovers: [String]?
    let pastInsured, company, reason: String?
    let anyClaim: String?
    let specifyTheClaim, wereYouRefused, remarks: String?
}


struct HouseHoldRCPersonalDetails :Codable {
    let title: String?
    let firstName, lastName: String?
    let email, countryCode, mobile, fax: String?
    let residencePermit: String?
    let dob: String?
    let streetNo: String?
    let address: String?
    let gender, city: String?
    let nationality: String?
    let postCode: String?
    let maritalStatus: String?
    let civilStatus, occupation, bankCc: String?
    let duration, effectiveDate: String?
}

// MArK:- Housing Rental



struct HousingRentalModel :Codable {
    let status: String?
    let data: HousingRentalData?
    let error: CatError?
}

struct HousingRentalData :Codable {
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: HousingRentalMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: HousingRentalMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

struct HousingRentalMemberDetails :Codable {
    let memberId, familyMemberId, firstName, lastName: String?
    let email: String?
    let countryCode: String?
    let mobile, dob, address, country: String?
    let state, city, postCode, agentId: String?
    let agentName: String?
    let profilePic: String?
}

struct HousingRentalMetadata :Codable {
    let type: String?
    let fontData, existingFont, paymentMethod, desiredStart: String?
    let premiumDueDate, language: String?
    let tenantDetails: TenantDetails?
    let residencePermit: String?
    let otherPersonDetails: OtherPersonDetails?
    let rentedObjectAddress, rentedObjectZipLocation: String?
    let ownerDetails, stewardshipDetails: HousingRentalDetails?
    let monthlyRent, amountToDeposit, areYouCurrentlySued, pattern: String?
}

struct HousingRentalDetails :Codable {
    let lessor: String?
    let phoneNo,countryCode, email, streetNo, contactPerson: String?
    let zipLocation: String?
    let management: String?
}

struct TenantDetails :Codable {
    let title: String?
    let firstName, lastName, email, countryCode, mobile, occupation: String?
    let address, residencePermit, dob, postCode, nationality, effectiveDate: String?
    
}

struct OtherPersonDetails :Codable {
    let title: String?
    let firstName, lastName, email, mobile, occupation: String?
    let address, residencePermit, dob, postCode, nationality, effectiveDate: String?
    
}

//MARK: Quatation Model

struct QuatationModel :Codable {
    let status: String?
    let data: QuatationData?
    let error: CatError?
}

// MARK: - DataClass
struct QuatationData :Codable {
    let leadId, partnerId, partnerName, agentId: String?
    let agentName: String?
    let memberDetails: QuatationMemberDetails?
    let memberId, memberName, relation, insuranceType: String?
    let metadata: QuatationMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}


struct QuatationMemberDetails :Codable {
    let memberId, familyMemberId, firstName, lastName: String?
    let email, countryCode, mobile, dob: String?
    let address, country, state, city: String?
    let postCode, agentId, agentName: String?
    let profilePic: String?
}


struct QuatationMetadata :Codable {
    let type: String?
    let customerDetails: QuatationCustomerDetails
    let typeOfObjects: [String]?
    let descriptionOfObject, sumsInsured: String?
    let supportingDoc: String?
    let benefits: [String]?
    let areYouPastInsured, companyName, policyNo, reason: String?
    let anyClaims, claimDetails, wereYouRefusedInsuranceProposal, remarks: String?
}


struct QuatationCustomerDetails :Codable {
    let title: String?
    let firstName, lastName: String?
    let email, countryCode, mobile, fax: String?
    let residencePermit: String?
    let dob: String?
    let streetNo: String?
    let address: String?
    let gender, city: String?
    let nationality: String?
    let postCode, maritalStatus, civilStatus, occupation: String?
    let bankCc: String?
    let duration, effectiveDate: String?
}


// MARK: - LegalProtection Model
struct  LegalProtectionModel: Codable {
    let status: String?
    let data: LegalProtectionDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct LegalProtectionDataClass: Codable {
    let leadID, partnerID, partnerName, agentID: String?
    let agentName: String?
    let memberDetails: LegalProtectionMemberDetails?
    let memberID, memberName, relation, insuranceType: String?
    let metadata: LegalProtectionMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct LegalProtectionMemberDetails: Codable {
    let memberID, familyMemberID, firstName, lastName: String?
    let email: String?
    let countryCode: String?
    let mobile, dob, address, country: String?
    let state, city, postCode, agentID: String?
    let agentName: String?
    let profilePic: String?
}

// MARK: - Metadata
struct LegalProtectionMetadata: Codable {
    let type: String?
    let proposalFor, fontData, replaceFont: String?
    let personalDetails: LegalProtectionPersonalDetails?
    let contractData: String?
    let contractDataList: [String]?
    let typeOfCovers, number, address, insuredForLegal: String?
    let insuredDetails: LegalProtectionInsuredDetails?
    let involvedInLitigation, startDate, endDate, expireDate: String?
}

// MARK: - InsuredDetails
struct LegalProtectionInsuredDetails: Codable {
    let risk, company, reason: String?
}

// MARK: - PersonalDetails
struct LegalProtectionPersonalDetails: Codable {
    let title: String?
    let firstName, lastName, email: String?
    let countryCode, mobile: String?
    let fax, residencePermit: String?
    let dob: String?
    let streetNo: String?
    let address: String?
    let gender: String?
    let city: String?
    let nationality, postCode: String?
    let maritalStatus, civilStatus: String?
    let occupation, bankCc: String?
    let duration: String?
    let effectiveDate: String?
}

// MARK: - Welcome2
struct MotorVehicleModel: Codable {
    let status: String?
    let data: MotorVehicleDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct MotorVehicleDataClass: Codable {
    let leadID, partnerID, partnerName, agentID: String?
    let agentName: String?
    let memberDetails: MotorVehicleMemberDetails?
    let memberID, memberName, relation, insuranceType: String?
    let metadata: MotorVehicleMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct MotorVehicleMemberDetails: Codable {
    let memberID, familyMemberID, firstName, lastName: String?
    let email: String?
    let countryCode: String?
    let mobile, dob, address, country: String?
    let state, city, postCode, agentID: String?
    let agentName: String?
    let profilePic: String?
}

// MARK: - Metadata
struct MotorVehicleMetadata: Codable {
    let type: String?
    let reqType: String?
    let personalDetails: MotorVehiclePersonalDetails?
    let drivingLicenseDate, paymentMethod, sourceOfFunding, nameOfInstitution: String?
    let contractNumber, otherDrivers: String?
    let driverInfo: MotorVehicleDriverInfo?
    let otherDriversOutsideCommonHousehold, anyDriversWithProvisionalLicense, haveGrayCard, attachCard: String?
    let vehicleDetails: MotorVehicleVehicleDetails?
    let isSecondVehicleInsured, secondVehicleHaveGrayCard: String?
    let attachSecondVehicleCard: String?
    let secondVehicleDetails: MotorVehicleVehicleDetails?
    let areYouInsuredAsVehicleOwner: String?
    let vehicleOwnerDetails: MotorVehicleVehicleOwnerDetails?
    let policyReplacedByAnotherCompany, licenceWithdrawn: String?
    let licenceWithdrawnDetails: MotorVehicleLicenceWithdrawnDetails?
    let involvedInTrafficAccident: String?
    let trafficAccidentDetails: MotorVehicleTrafficAccidentDetails?
    let alreadySufferedDamage: String?
    let sufferedDamageDetails: MotorVehicleSufferedDamageDetails?
    let bonusProtection, coverage, casco, cascoBonusProtection: String?
    let parkingDamage, singleParkingDamage, headlightCover, freeChoiceOfGarage: String?
    let replacementVehicleRental, partialCasco, personalEffects, personalEffectsValue: String?
    let occupantProtection, waiverOfRecourse, remarks: String?
}

// MARK: - DriverInfo
struct MotorVehicleDriverInfo: Codable {
    let name, contactNumber, address: String?
}

// MARK: - LicenceWithdrawnDetails
struct MotorVehicleLicenceWithdrawnDetails: Codable {
    let reason, duration, amount: String?
}

// MARK: - PersonalDetails
struct MotorVehiclePersonalDetails: Codable {
    let title, firstName, lastName: String?
    let email, countryCode, mobile, fax: String?
    let residencePermit: String?
    let dob: String?
    let streetNo: String?
    let address: String?
    let gender, city: String?
    let nationality: String?
    let postCode, maritalStatus, civilStatus, occupation: String?
    let bankCc, duration: String?
    let effectiveDate: String?
}

// MARK: - VehicleDetails
struct MotorVehicleVehicleDetails: Codable {
    let typeOfVehicle, brand, regNo, noOfPlaces: String?
    let approvalNo, espSystem, displacement, firstTimeRelease: String?
    let priceCatalogue, accessoriesPrices, uploadedWeight, totalWeight: String?
    let garageClosed, useOfVehicle, annualMileage, meterReading: String?
}

// MARK: - SufferedDamageDetails
struct MotorVehicleSufferedDamageDetails: Codable {
    let sufferedDamageDetailsIn: [String]?
    let date, amount: String?
}

// MARK: - TrafficAccidentDetails
struct MotorVehicleTrafficAccidentDetails: Codable {
    let date, amount, responsible, trafficAccidentDetailsIn: String?
}

// MARK: - VehicleOwnerDetails
struct MotorVehicleVehicleOwnerDetails: Codable {
    let holderName, companyName, policyNo: String?
}



// MARK: - ConstructionModel
struct ConstructionModel: Codable {
    let status: String?
    let data: ConstructionDataClass?
    let error: CatError?
}

// MARK: - DataClass
struct ConstructionDataClass: Codable {
    let leadID, partnerID, partnerName, agentID: String?
    let agentName: String?
    let memberDetails: ConstructionMemberDetails?
    let memberID, memberName, relation, insuranceType: String?
    let metadata: ConstructionMetadata?
    let status: String?
    let proposalCount: Int?
    let isDeleted: Bool?
    let createdBy: String?
    let updatedBy: String?
    let createdOn, lastUpdatedOn: String?
}

// MARK: - MemberDetails
struct ConstructionMemberDetails: Codable {
    let memberID, familyMemberID, firstName, lastName: String?
    let email, countryCode, mobile, dob: String?
    let address, country, state, city: String?
    let postCode, agentID, agentName, profilePic: String?
}

// MARK: - Metadata
struct ConstructionMetadata: Codable {
    let type: String?
    let policyHolder: String?
    let policyHolderDetails: ConstructionPolicyHolderDetails?
    let typeOfConstruction: String?
    let projectAddressDetails: ConstructionProjectAddressDetails?
    let areTheWorkAccepted, hasWorkStarted, knownLoss: String?
    let architectDetails, civilEngineerDetails: ConstructionDetails?
    let masterOfWorkFor: String?
    let masterOfWorkDetails: ConstructionDetails?
    let desiredInsurance: ConstructionDesiredInsurance?
    let ownerPartition, neighborhood, whichOne, totalCost: String?
    let isItCivilEngineerProject, distance, demolition, topography: String?
    let landToBuild, earthWork, earthWorkValue, upperFloors: String?
    let search, execution: String?
    let technique: [String]?
    let loweringOfWaterTable, structureFormula, stalling: String?
    let underpinning: [String]?
    let drillingForGeothermal, number, depth, areSolarInstalled: String?
    let solarType: [String]?
    let changesToStructure, roofWork, dangerZone, conditionOfThirdPartyWork: String?
    let statutoryCivilLiability: String?
    let agreement: String?
    let requirements, why, maps, quotation: String?
    let reports, notes, date, place: String?
}

// MARK: - Details
struct ConstructionDetails: Codable {
    let name, email, phone, address: String?
}

// MARK: - DesiredInsurance
struct ConstructionDesiredInsurance: Codable {
    let constructionWorkInsurance, cantonsWithoutCantonalInsuranceEstablishmentsTheRisksFireNaturalEventsMustBeInsured, builderSLiabilityInsuranceWhetherThisInsuranceForTheAmountOfWorkPlannedIsNotIncludedInACombinedHouseholdRCCompanyOrOtherInsurance: String?
}

// MARK: - PolicyHolderDetails
struct ConstructionPolicyHolderDetails: Codable {
    let title: String?
    let firstName, lastName, email, countryCode: String?
    let mobile, fax, residencePermit, dob: String?
    let streetNo: String?
    let address: String?
    let gender, city, nationality, postCode: String?
    let maritalStatus, civilStatus, occupation, bankCc: String?
    let duration: String?
    let effectiveDate: String?
}

// MARK: - ProjectAddressDetails
struct ConstructionProjectAddressDetails: Codable {
    let landRegistryNo, streetNo, location, postalCode: String?
    let startDateOfWork, endDateOfWork: String?
}

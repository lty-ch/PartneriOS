//
//  Constant.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation
import Firebase
import UIKit

let LTY_AppDelegate = UIApplication.shared.delegate as! AppDelegate
let kUserDefaults = UserDefaults.standard

let LTY_TYPE = "PARTNER"
let LTY_SUBSCIPTIONPLAN = "plan_1"
let LTY_SOURCE = "Individual"
var newProductArr = [NSMutableDictionary]()
var productArrToBeSent = [NSMutableDictionary]()
var addProposalDic = NSMutableDictionary()
var shouldEditMembers = true
var showNavDrower = false
var deviceId = UIDevice.current.identifierForVendor!.uuidString
var kfcm = ""
let kGoogleApiKey = "AIzaSyAwLRt95oBL8bC1NQdu5F_k1MApP8NT4rI"

let kPostHeaderDict = ["Content-Type":"application/json","platform":"iOS","browser":"","browserVersion":"","osVersion":"13","deviceId":deviceId,"appVersion":"1.0","ipAddress":"sdsd","macAddress":""]

#if DEVELOPMENT

struct LTY_BASE_URL {
  //  /* identity base url
    static let BASE_URL_PARTNER = "https://identity.dev.ltytech.ch/api/ims/v1/partner/"
    static let BASE_URL_RESEND_OTP = "https://communicator.dev.ltytech.ch/api/communicator/v1/"
    static let BASE_URL_COMMON = "https://identity.dev.ltytech.ch/api/ims/v1/config/"
    static let BASE_URL_GETPROFILE = "https://fee.dev.ltytech.ch/api/fee/v1/get/profiles"
    static let BASE_URL_PRODUCT = "https://fee.dev.ltytech.ch/api/fee/v1/"
    static let BASE_URL_FEE = "https://fee.dev.ltytech.ch/api/fee/v1/"
    static let BASE_URL_CATEGORY = "https://catalogue.dev.ltytech.ch/api/catalogue/v1/category/"
    static let DOCUMENT_BASE_URL  = "https://document-store.dev.ltytech.ch/"
    static let DOCUMENT_UPLOAD_URL =  "https://document-store.dev.ltytech.ch/api/document-store/v1/upload"
    static let SHOW_DOCUMENT_URL =  "https://document-store.dev.ltytech.ch/api/document-store/v1/get/presigned"
  
     

    static let BASE_URL_IDENTITY = "https://identity.dev.ltytech.ch/api/ims/v1/"
    static let BASE_URL_INSURANCE = "https://insurance-aggregator.dev.ltytech.ch/api/insurance/v1/"
    static let BASE_URL_PRODUCT_CATEGORY = "https://catalogue.dev.ltytech.ch/api/catalogue/v1/"
    static let BASE_URL_ROLES = "https://role-access.dev.ltytech.ch/api/role-access/v1/"
    
    //*/
    
   // "https://apigateway.dev.ltytech.ch/"
/*
    static let BASE_URL_PARTNER = "https://apigateway.dev.ltytech.ch/api/ims/v1/partner/"
    static let BASE_URL_RESEND_OTP = "https://apigateway.dev.ltytech.ch/api/communicator/v1/"
    static let BASE_URL_COMMON = "https://apigateway.dev.ltytech.ch/api/ims/v1/config/"
    static let BASE_URL_GETPROFILE = "https://apigateway.dev.ltytech.ch/api/fee/v1/get/profiles"
    static let BASE_URL_PRODUCT = "https://apigateway.dev.ltytech.ch/api/fee/v1/"
    static let BASE_URL_FEE = "https://apigateway.dev.ltytech.ch/api/fee/v1/"
    static let BASE_URL_CATEGORY = "https://apigateway.dev.ltytech.ch/api/catalogue/v1/category/"
    static let DOCUMENT_BASE_URL  = "https://apigateway.dev.ltytech.ch/"
    static let DOCUMENT_UPLOAD_URL =  "https://apigateway.dev.ltytech.ch/api/document-store/v1/upload"
    static let SHOW_DOCUMENT_URL =  "https://apigateway.dev.ltytech.ch/api/document-store/v1/get/presigned"

    static let BASE_URL_IDENTITY = "https://apigateway.dev.ltytech.ch/api/ims/v1/"
    static let BASE_URL_INSURANCE = "https://apigateway.dev.ltytech.ch/api/insurance/v1/"
    static let BASE_URL_PRODUCT_CATEGORY = "https://apigateway.dev.ltytech.ch/api/catalogue/v1/"
    static let BASE_URL_ROLES = "https://apigateway.dev.ltytech.ch/api/role-access/v1/"
    */
    
  /*
    static let BASE_URL_PARTNER = "https://identity.prod.ltytech.ch/api/ims/v1/partner/"
    static let BASE_URL_RESEND_OTP = "https://communicator.prod.ltytech.ch/api/communicator/v1/"
    static let BASE_URL_COMMON = "https://identity.prod.ltytech.ch/api/ims/v1/config/"
    static let BASE_URL_GETPROFILE = "https://fee.prod.ltytech.ch/api/fee/v1/get/profiles"
    static let BASE_URL_PRODUCT = "https://fee.prod.ltytech.ch/api/fee/v1/"
    static let BASE_URL_FEE = "https://fee.prod.ltytech.ch/api/fee/v1/"
    static let BASE_URL_CATEGORY = "https://catalogue.prod.ltytech.ch/api/catalogue/v1/category/"
    static let DOCUMENT_BASE_URL  = "https://document-store.prod.ltytech.ch/"
    static let DOCUMENT_UPLOAD_URL =  "https://document-store.prod.ltytech.ch/api/document-store/v1/upload"
   static let SHOW_DOCUMENT_URL =  "https://document-store.prod.ltytech.ch/api/document-store/v1/get/presigned"

    static let BASE_URL_IDENTITY = "https://identity.prod.ltytech.ch/api/ims/v1/"
    static let BASE_URL_INSURANCE = "https://insurance-aggregator.prod.ltytech.ch/api/insurance/v1/"
    static let BASE_URL_PRODUCT_CATEGORY = "https://catalogue.prod.ltytech.ch/api/catalogue/v1/"
    static let BASE_URL_ROLES = "https://role-access.prod.ltytech.ch/api/role-access/v1/"

 */


}
#elseif STAGING

struct LTY_BASE_URL {
    static let BASE_URL_PARTNER = "https://identity.stage.ltytech.ch/api/ims/v1/partner/"
    static let BASE_URL_RESEND_OTP = "https://communicator.stage.ltytech.ch/api/communicator/v1/"
    static let BASE_URL_COMMON = "https://identity.stage.ltytech.ch/api/ims/v1/config/"
    static let BASE_URL_GETPROFILE = "https://fee.stage.ltytech.ch/api/fee/v1/get/profiles"
    static let BASE_URL_PRODUCT = "https://fee.stage.ltytech.ch/api/fee/v1/"
    static let BASE_URL_FEE = "https://fee.stage.ltytech.ch/api/fee/v1/"
    static let BASE_URL_CATEGORY = "https://catalogue.stage.ltytech.ch/api/catalogue/v1/category/"
    static let DOCUMENT_BASE_URL  = "https://document-store.stage.ltytech.ch/"
    static let DOCUMENT_UPLOAD_URL =  "https://document-store.stage.ltytech.ch/api/document-store/v1/upload"
    static let SHOW_DOCUMENT_URL =  "https://document-store.stage.ltytech.ch/api/document-store/v1/get/presigned"


    static let BASE_URL_IDENTITY = "https://identity.stage.ltytech.ch/api/ims/v1/"
    
    
    static let BASE_URL_INSURANCE = "https://insurance-aggregator.stage.ltytech.ch/api/insurance/v1/"
    static let BASE_URL_PRODUCT_CATEGORY = "https://catalogue.stage.ltytech.ch/api/catalogue/v1/"
    static let BASE_URL_ROLES = "https://role-access.stage.ltytech.ch/api/role-access/v1/"




}
#endif

struct LTY_END_POINT_URL {
    
    // static let BaseURL = "https://identity.dev.ltytech.ch/api/ims/v1/partner/"
    //  static let OTPBaseUrl = "https://communicator.dev.ltytech.ch/api/communicator/v1/"
    static let loginUrl = "signin"
    static let otpVerify = "perform/action"
    static let resendOtp = "otp/resend"
    static let forgotPass = "forgot/password"
    static let resetPassword = "verify/forgot/password"
    static let signUpUrl = "signup"
    static let signOut = "signout"
    static let productCommissionListUrl = "get/product-commission"
    static let agentListUrl = "get/partner/agents"
    static let agentDeleteUrl = "delete/agent"
    static let addProductCommissions = "add/product-commission"
    // static let BASE_URL_COMMON = "https://identity.prod.ltytech.ch/api/ims/v1/config/"
    static let COUNTRIES_URL = "get/countries"
    static let STATES_URL = "get/states/"  //countryId
    static let CITY_URL = "get/cities/" //stateId
    static let getAllMainCategory = "get/all"
    static let agentCommission = "add/agent-commission"
    static let agentEditDetailUrl = "details" //agent edit detail api
    static let agentDetailupdateUrl = "update" //agent edit detail update api
    
    static let changePassword = "change/password"
    static let deleteCategory = "delete/category"
    static let deleteSubcategory = "delete/sub-category"
    static let deleteProduct = "delete/product"
    
    static let deleteProductCommission = "delete/product-commission"

    static let getCategory = "get/product-commission"
    static let getCategoryNew = "get/category"
    static let getCategoryByAgent = "get/agent/category"
    static let getSubCategory = "get/category/product-commission"
    static let getSubCategoryNew = "get/sub-category"
    static let getSubCategoryByAgent = "get/agent/sub-category"
    static let getProduct = "get/sub-category/product-commission"
    static let getProductByAgent = "get/product"

    
    static let getCustomers = "user/get/partner/users"
    static let getCustomerActiveAgents = "partner/get/partner/active/agents"
    static let getActiveUsers = "user/get/partner/active/users"
    static let customerAssignAgent = "partner/assign/agent"
    static let leadAssignAgent = "assign/partner-agent"
    static let getFamilyMember = "user/get/user/family-member"
    static let blockUser = "admin/update/user/state"
    
    //Profile VC
    static let PROFILE_DETAIL_URL = "details/token"
    
    static let GET_AGENT_COMMISSION = "get/agent/agent-commission"
    static let DELETE_AGENT_COMMISSION = "delete/agent-commission"
    static let UPDATE_AGENT_COMMISSION = "update/agent-commission"
    static let updateProductCommission = "update/product-commission"
    
    
    static let profileUpadtePhone = "mobile/update"
    static let profileUpadteEmail = "email/update"
    
    static let verifyProfileUpadtePhone = "verify/mobile/update"
    static let verifyProfileUpadteEmail = "verify/email/update"
    
    static let addNewCustomer = "user/signup"
    static let getCustomerDetails = "user/details"
    static let updateCustomer = "user/update"
    
    static let blockAgent = "admin/update/partner/state"
    static let partnerDetails =  "details"

    
    //Proposal EndPoints
    static let getProposalList = "get/partner/proposal"
    static let getProposalListNew = "get/proposals"
    static let getExpiredContract = "get/expired/proposals"
    static let getdashboardInfo = "get/partner/dashboard-info"
    static let catAgentListUrl = "get/category/agents"
    static let getMembers = "user/get/partner/users"
    static let getActiveMembers = "user/get/agent/active/users"
    static let addProposal = "add/proposal"
    static let updateProposal = "update/proposal"
    static let getCommission = "get/commission"
    static let validateOfferId = "validate/offer-id"
    static let validatePolicyId = "validate/policy-id"
    
    static let viewProposal = "get/proposal"
    static let viewProposalByOfferID = "get/proposal/offer-id"

    //MARK:- leads End Point
    static let partnerLeadsList = "get/partner/leads"
    static let partnerLeadsListNew = "get/leads"
    static let viewLeadDetail = "get/lead/details"
    static let leadProposal = "get/lead/proposals"
    static let sendProposal = "update/proposal/state"
    static let deleteLeadProposal = "delete/proposal"
    static let getCustomerLead = "get/leads"
    static let sendMultipleProposal = "send/proposal"
    static let getproductCat = "product/get/category"
    static let getSubmission = "get/submissions"
    static let getCustContract = "get/proposals"
    static let getCustUserDocument = "api/document-store/v1/get/user/docs"
    static let getCustMemberDocument = "api/document-store/v1/get/member/docs"
    static let addPolicyId = "add/policy-id"
    
    //MARK:- Roles End Point
    static let rolesList = "get/roles"
    static let getUserRole = "get/user/role"
    static let usersList = "get/users"
    static let deleteRole = "update/role/status"
    static let addRole = "add-update/role"
    static let assignRole = "assign/role"
    static let getAllRoles = "get/use-cases"
    static let getSelectedRoles = "get/role/use-cases"
    static let updateRoles = "add-update/role/use-cases"
    static let getAgentList = "user/get/agent/users"
    
    //MARK:- Search cover
   static let searchCover_OverAll = "get/overall/statistics"
   static let searchCover_Customers = "get/customers/statistics"
   static let searchCover_Agents = "get/agents/statistics"
   static let searchCover_Analysis = "get/analysis"
    
    //MARK:- Agenda 
   static let getAgendaList = "agenda/get/agenda"
   static let deleteAgenda = "agenda/delete/agenda"
   static let getAgendaDetails = "agenda/get/agenda-details"
   static let addNewAgenda = "agenda/add/agenda"
   static let updateAgenda = "agenda/update/agenda"
    static let getStaticData = "get/static/data"
    static let postExistingContract = "add/existing/contract"
    
    static let getNewsLetterData = "newsletter/get/templates"
    static let addNewsLetterTemplate = "newsletter/add/template"
    static let getNewsLetterDetails = "newsletter/get/template-details"
    static let sendNewsLetter = "newsletter/send/newsletter"

    static let modifyCommission = "modify/commission"
    static let getNotificationList = "communication/get/notification"
    static let deleteAccount = "close/account"
    

}
//MARK:- AppKeys

struct AppKeys {
    static let refFbdb = Database.database().reference()
    static let token = "token"
    static let fcmKey = "fcmKey"
    static let email = "email"
    static let state = "state"
    static let tabName = "tabName"
    static let sourceId = "sourceId"
    static let profile = "profile"
    static let companyName = "companyName"
    static let invalidTokenCode = "ER-TOKEN-4000"
    static let password = "password"
    static let userType = "userType"
    static let isDefaultPasswordSet = "isDefaultPasswordSet"
    static let roleList = "roleList"
    static let agentName = "agentName"
    static let partnerID = "partnerID"
    static let totalNotification = "totalNotification"
    static let shouldActivateFaceId = "shouldActivateFaceId"
 
}

//MARK:-document directory realted method
public func deleteDirectory(name:String){
    
    let fileManager = FileManager.default
    do {
        let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
        for url in fileURLs {
            try fileManager.removeItem(at: url)
        }
    } catch {
        print(error)
    }
}

//MARK:-document directory realted method
public func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

public func saveImageDocumentDirectory(usedImage:UIImage)
{
    let fileManager = FileManager.default
    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("temp.jpeg")
    let imageData = usedImage.jpegData(compressionQuality: 0.5)
    fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
}
public func getImageUrl() -> URL? {
    let url = URL(fileURLWithPath: (getDirectoryPath() as NSString).appendingPathComponent("temp.jpeg"))
    return url
}

public func returnDOB(date:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "dd.MM.yyyy"
    if date == nil {
        return "0"
    }else{
        let resultString = dateFormatter.string(from: date!)
        return resultString
    }
    
}

public func containsNumbers(textField: UITextField) -> Bool {
    // Define a regular expression pattern to match numeric characters
    let numericPattern = ".*[0-9]+.*"
    
    // Create a regular expression object
    do {
        let regex = try NSRegularExpression(pattern: numericPattern, options: [])
        
        // Get the text from the UITextField
        if let text = textField.text {
            // Use the regular expression to check for matches
            let range = NSRange(location: 0, length: text.utf16.count)
            if let _ = regex.firstMatch(in: text, options: [], range: range) {
                return true // The text contains numbers
            }
        }
    } catch {
        print("Error creating regex: \(error)")
    }
    
    return false // The text does not contain numbers
}

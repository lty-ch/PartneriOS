//
//  ServerClass.swift
//  Amistos
//
//  Created by chawtech solutions on 3/26/18.
//  Copyright © 2018 chawtech solutions. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

var appLoginToken : String?

public struct ERNetworkManagerResponse {    /// The server's response to the URL request
    public let responseDict: NSDictionary?
    /// The error encountered while executing or validating the request.
    public let message: String?
    
    /// Status of the request.
    public let success: Bool?
    var _metrics: AnyObject?
    init(response: NSDictionary?, status: Bool?,error: String?) {
        
        self.message = error
        self.responseDict = response
        self.success = status
    }
}

class ServerClass: NSObject {
    var arrRes = [[String:AnyObject]]()
    class var sharedInstance:ServerClass {
        struct Singleton {
            static let instance = ServerClass()
        }
        return Singleton.instance
    }
    
//    private static var Manager: Alamofire.SessionManager = {
//        // Create the server trust policies
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            TRUST_BASE_URL: .disableEvaluation
//        ]
//        // Create custom manager
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        let manager = Alamofire.SessionManager(
//            configuration: URLSessionConfiguration.default,
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//        return manager
//    }()
    
    private static var Manager: Session = {
//        //change "kidyview.com" for live url
//        let manager = ServerTrustManager(evaluators: ["kidyview.com": DisabledTrustEvaluator()])
        
        // Change "chawtechsolutions.ch" for Staging url
        let manager = ServerTrustManager(evaluators: ["identity.prod.ltytech.ch": DisabledTrustEvaluator()])
        
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()

    
//    func getRequestWithUrlParameters(_ sendJson:[String:Any], path:String, successBlock:@escaping (_ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
////        var headerField : [String : String] = [:]
//        var headerField : HTTPHeaders = [:]
//        if UserDefaults.standard.object(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) != nil  {
//            headerField = ["Content-Type":"application/json", "XAPIKEY":X_API_KEY, "token":UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) as! String]
//        }
//        else {
//            headerField = ["Content-Type":"application/json","XAPIKEY":X_API_KEY]
//        }
//        ServerClass.Manager.request(path, method: .get, encoding: JSONEncoding.default, headers: headerField).responseJSON { (response) in
//            if response.response?.statusCode == 401 {
//               self.logOutUser()
//            }
//            switch response.result {
//            case .success(let value):
//                // print(String(data: value as! Data, encoding: .utf8)!)
//                successBlock(JSON(value ))
//            case .failure(let error):
//                errorBlock(error as NSError)
//            }
//        }
//    }
    
    
    func postRequestWithUrlParameters(_ sendJson:[String:Any], path:String, successBlock:@escaping (_ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
//        var headerField : [String : String] = [:]
        var headerField : HTTPHeaders = [:]
 
        let token = kUserDefaults.object(forKey: "token") as! String
        
        let dic = ["platform": "IOS", "browser": "", "browserVersion": "", "osVersion": "13", "deviceId": deviceId, "appVersion": "1.0", "ipAddress": "sdsd", "macAddress": ""]

        
        
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dic,
            options: []) {
            //            let theJSONText = String(data: theJSONData,
            //                                     encoding: .ascii)
            //            print("JSON string = \(theJSONText!)")
            if let jsonString = String(data: theJSONData, encoding: .utf8) {
                headerField = ["Content-Type":"application/json", "Access-Token":token, "User_Agent": jsonString, "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]            }
            
        }
        
//        headerField = ["Content-Type":"application/json", "Access-Token":token, "User_Agent": decoded]
        
        ServerClass.Manager.request(path, method: .post, parameters: sendJson, encoding: JSONEncoding.default, headers: headerField).responseJSON { (response) in
            if response.response?.statusCode == 401 {
//               self.logOutUser()
            }
            switch response.result {
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    
//    func putRequestWithUrlParameters(_ sendJson:[String:Any], path:String, successBlock:@escaping (_ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
////        var headerField : [String : String] = [:]
//        var headerField : HTTPHeaders = [:]
//        if UserDefaults.standard.object(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) != nil  {
//            headerField = ["Content-Type":"application/json", "XAPIKEY":X_API_KEY, "token":UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) as! String]
//
//        }
//        else {
//            headerField = ["Content-Type":"application/json","XAPIKEY":X_API_KEY]
//        }
//        ServerClass.Manager.request(path, method: .put, parameters: sendJson, encoding: JSONEncoding.default, headers: headerField).responseJSON
//            { (response) in
//                if response.response?.statusCode == 401 {
//                    self.logOutUser()
//                }
//                switch response.result {
//                case .success(let value):
//                    // print(String(data: value as! Data, encoding: .utf8)!)
//                    successBlock(JSON(value ))
//                case .failure(let error):
//                    errorBlock(error as NSError)
//                }
//        }
//    }
//
//    func deleteRequestWithUrlParameters(_ sendJson:[String:Any], path:String, successBlock:@escaping (_ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
////        var headerField : [String : String] = [:]
//        var headerField : HTTPHeaders = [:]
//        if UserDefaults.standard.object(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) != nil  {
//            headerField = ["Content-Type":"application/json", "XAPIKEY":X_API_KEY, "token":UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) as! String]
//        }
//        else {
//            headerField = ["Content-Type":"application/json","XAPIKEY":X_API_KEY]
//        }
//        ServerClass.Manager.request(path, method: .delete, parameters: sendJson, encoding: JSONEncoding.default, headers: headerField).responseJSON { (response) in
//            switch response.result {
//            case .success(let value):
//                // print(String(data: value as! Data, encoding: .utf8)!)
//                successBlock(JSON(value ))
//            case .failure(let error):
//                errorBlock(error as NSError)
//            }
//        }
//    }
//
    func sendMultipartRequestToServer(urlString:String,fileName:String,  sendJson:[String:Any], imageUrl:URL?, successBlock:@escaping (  _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void )
    {
        let token = kUserDefaults.object(forKey: "token") as! String
        var headerField : HTTPHeaders = ["Access-Token":token]

        AF.upload(multipartFormData: { multipartFormData in
            for (key,value) in sendJson {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                
            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
        },to: urlString, method: .post, headers : headerField)
        .responseJSON {  response in
            if response.response?.statusCode == 403 {
                //self.manageSession()
            }
            switch response.result {
                
                
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))
                
            case .failure( let error):
                errorBlock(error as NSError)
                print("ERROR RESPONSE: \(error)")
            }
        }
        
    }
//
//    func sendImageMultipartRequestToServerWithToken(apiUrlStr:String, imageKeyName:String, imageUrl:URL?, successBlock:@escaping (_ response: JSON)->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
////        let headerField = ["XAPIKEY":X_API_KEY,"APPTOKEN":UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.LOGIN_TOKEN) as! String]
//        var headerField : HTTPHeaders = [:]
//        if UserDefaults.standard.object(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) != nil  {
//            headerField = ["Content-Type":"application/json", "XAPIKEY":X_API_KEY, "APPTOKEN":UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.LOGIN_TOKEN) as! String]
//        }
//        else {
//            headerField = ["Content-Type":"application/json","XAPIKEY":X_API_KEY]
//        }
////        Alamofire.upload(multipartFormData: { multipartFormData in
////            multipartFormData.append(imageUrl! , withName: imageKeyName)
////        },to:apiUrlStr, method: .post, headers : headerField,
////          encodingCompletion: { encodingResult in
////            switch encodingResult {
////            case .success(let upload, _, _):
////                upload.responseJSON { response in
////                    if let value = response.result.value {
////                        successBlock(JSON(value ))
////                    }
////                }
////            case .failure(let error):
////                errorBlock(error as NSError)
////            }
////        })
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageUrl! , withName: imageKeyName)
//        },to: apiUrlStr, method: .post, headers : headerField)
//        .responseJSON {  response in
//            if response.response?.statusCode == 403 {
//                //self.manageSession()
//            }
//            switch response.result {
//            case .success(let value):
//                // print(String(data: value as! Data, encoding: .utf8)!)
//                successBlock(JSON(value ))
//
//            case .failure( let error):
//                errorBlock(error as NSError)
//                print("ERROR RESPONSE: \(error)")
//            }
//        }
//    }
//
//    func sendMultipartRequestToServerPP(apiUrlStr:String, imageKeyName:String, imageUrl:URL?, successBlock:@escaping (_ response: JSON)->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
////        var headerField : [String : String] = [:]
//        var headerField : HTTPHeaders = [:]
//        if UserDefaults.standard.object(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) != nil  {
//            headerField = ["Content-Type":"application/json", "XAPIKEY":X_API_KEY, "token":UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN) as! String]
//        }
//        else {
//           // headerField = ["Content-Type":"application/json","XAPIKEY":X_API_KEY]
//            headerField = ["X-API-KEY":X_API_KEY]
//        }
////        Alamofire.upload(multipartFormData: { multipartFormData in
////            multipartFormData.append(imageUrl! , withName: imageKeyName)
////        },to:apiUrlStr, method: .post, headers : headerField,
////          encodingCompletion: { encodingResult in
////            switch encodingResult {
////            case .success(let upload, _, _):
////                upload.responseJSON { response in
////                    if let value = response.result.value {
////                        successBlock(JSON(value ))
////                    }
////                }
////            case .failure(let error):
////                errorBlock(error as NSError)
////            }
////        })
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageUrl! , withName: imageKeyName)
//        },to: apiUrlStr, method: .post, headers : headerField)
//        .responseJSON {  response in
//            if response.response?.statusCode == 403 {
//                //self.manageSession()
//            }
//            switch response.result {
//            case .success(let value):
//                // print(String(data: value as! Data, encoding: .utf8)!)
//                successBlock(JSON(value ))
//
//            case .failure( let error):
//                errorBlock(error as NSError)
//                print("ERROR RESPONSE: \(error)")
//            }
//        }
//    }
//
//    func sendMultipartRequestToServer(urlString:String,fileName:String, sendJson:[String:Any], imageUrl:URL?, successBlock:@escaping (_ response: JSON)->Void , errorBlock: @escaping (_ error: NSError) -> Void) {
//        if let appToken = UserDefaults.standard.object(forKey: USER_DEFAULTS_KEYS.LOGIN_TOKEN) as? String {
//            appLoginToken = appToken
//        }
////        var headerField = [String : String]()
//        var headerField : HTTPHeaders = [:]
//        if UserDefaults.standard.bool(forKey: USER_DEFAULTS_KEYS.IS_LOGIN) == true {
//            headerField = ["content-type": "application/json","XAPIKEY": X_API_KEY, "APPTOKEN": appLoginToken ?? " "]
//        }
//        else {
//            headerField  = ["content-type": "application/json","XAPIKEY": X_API_KEY]
//        }
////        Alamofire.upload(multipartFormData: { multipartFormData in
////            for (key,value) in sendJson
////            {
////                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
////            }
////            if let imageURl = imageUrl
////            {
////                multipartFormData.append(imageURl, withName: fileName)
////            }
////
////        }, to: urlString, method: .post, headers : headerField,
////           encodingCompletion: { encodingResult in
////            switch encodingResult {
////            case .success(let upload, _, _):
////                print(upload.progress)
////                upload.responseJSON {  response in
////                    if let value = response.result.value {
////                        successBlock(JSON(value ))
////                    }
////                }
////            case .failure( let error):
////                errorBlock(error as NSError)
////            }
////        })
//
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key,value) in sendJson
//            {
//                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//            }
//            if let imageURl = imageUrl
//            {
//                multipartFormData.append(imageURl, withName: fileName)
//            }
//        },to: urlString, method: .post, headers : headerField)
//        .responseJSON {  response in
//            if response.response?.statusCode == 403 {
//                //self.manageSession()
//            }
//            switch response.result {
//            case .success(let value):
//                // print(String(data: value as! Data, encoding: .utf8)!)
//                successBlock(JSON(value ))
//
//            case .failure( let error):
//                errorBlock(error as NSError)
//                print("ERROR RESPONSE: \(error)")
//            }
//        }
//
//    }
    
//    func sendMultipartRequestToServerWithMultipleImages(urlString:String, imageKeyName:String, imageUrl:[URL?], successBlock:@escaping ( _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void ){
////           var headerField : [String : String] = [:]
//        var headerField : HTTPHeaders = [:]
//           if UserDefaults.standard.bool(forKey: USER_DEFAULTS_KEYS.IS_LOGIN) == true {
//               headerField = ["content-type": "application/json","XAPIKEY": X_API_KEY, "APPTOKEN": appLoginToken ?? " "]
//           }
//           else {
//               headerField = ["content-type": "application/json","XAPIKEY": X_API_KEY]
//           }
////           Alamofire.upload(multipartFormData: { multipartFormData in
////
////               for img in 0..<imageUrl.count
////               {
////                   multipartFormData.append(imageUrl[img]! , withName: imageKeyName)
////               }
////           },to: urlString, method: .post, headers : headerField,
////             encodingCompletion: { encodingResult in
////                switch encodingResult {
////                case .success(let upload, _, _):
////                    upload.responseJSON { response in
////                        if let value = response.result.value {
////                            successBlock(JSON(value ))
////                        }
////                    }
////                case .failure(let error):
////                    errorBlock(error as NSError)
////                }
////           })
//        AF.upload(multipartFormData: { multipartFormData in
//            for img in 0..<imageUrl.count
//            {
//                multipartFormData.append(imageUrl[img]! , withName: imageKeyName)
//            }
//        },to: urlString, method: .post, headers : headerField)
//        .responseJSON {  response in
//            if response.response?.statusCode == 403 {
//                //self.manageSession()
//            }
//            switch response.result {
//            case .success(let value):
//                // print(String(data: value as! Data, encoding: .utf8)!)
//                successBlock(JSON(value ))
//
//            case .failure( let error):
//                errorBlock(error as NSError)
//                print("ERROR RESPONSE: \(error)")
//            }
//        }
//    }
    
//    func sendMultipartRequestWithMultileFiles2(urlString:String,fileNames:[String], _ sendJson:[String:Any], imageUrl:[URL?], successBlock:@escaping (_ response: JSON)->Void , errorBlock: @escaping (_ error: NSError) -> Void )
//    {
//        var headerField : [String : String] = [:]
//        if UserDefaults.standard.bool(forKey: USER_DEFAULTS_KEYS.IS_LOGIN) == true {
//            headerField = ["content-type": "application/json","XAPIKEY": X_API_KEY, "APPTOKEN": appLoginToken ?? " "]
//        }
//        else {
//            headerField = ["content-type": "application/json","XAPIKEY": X_API_KEY]
//        }
//        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            for (key,value) in sendJson {
//                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//            }
//            var index = 0
//            for filePath in imageUrl
//            {
//                if let url = filePath
//                {
//                    multipartFormData.append(url, withName: "\(fileNames[index])[]")
//                }
//                index += 1
//            }
//            
//        }, to: urlString, method: .post, headers : headerField,
//           encodingCompletion: { encodingResult in
//            
//            switch encodingResult {
//            case .success(let upload, _, _):
//                print(upload.progress)
//                upload.responseJSON {  response in
//                    if response.response?.statusCode == 403 {
//                        //self.manageSession()
//                    }
//                    
//                    if let value = response.result.value
//                    {
//                        successBlock(JSON(value ))
//                    }
//                }
//            case .failure( let error):
//                self.logOutUser()
//                errorBlock(error as NSError)
//            }
//        })
//    }
    
//    func logOutUser() {
//        isLogOut = "yes"
////        let domain = Bundle.main.bundleIdentifier!
////        UserDefaults.standard.removePersistentDomain(forName: domain)
////        UserDefaults.standard.synchronize()
//        UserDefaults.standard.set(nil, forKey: USER_DEFAULTS_KEYS.VENDOR_SIGNUP_TOKEN)
//        UserDefaults.standard.set("", forKey: USER_DEFAULTS_KEYS.LOGIN_TOKEN)
//        UserDefaults.standard.set("", forKey: USER_DEFAULTS_KEYS.IS_LOGIN)
//        UserDefaults.standard.set("", forKey: USER_DEFAULTS_KEYS.LOGIN_NAME)
//        UserDefaults.standard.set(false, forKey: USER_DEFAULTS_KEYS.IS_SOCIAL_MEDIA_LOGGED_IN)
//
//        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = userStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        viewController.sendTo = "Home"
//        let rootNC = UINavigationController(rootViewController: viewController)
//        UIApplication.shared.delegate!.window!!.rootViewController = rootNC
//    }
    
}

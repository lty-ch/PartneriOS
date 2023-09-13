//
//  Services.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

class Services: NSObject, UITextFieldDelegate {
    
    static let shareInstance = Services()
    
    //MARK:- Login Api
    
    
    
    func LoginApi(params:LoginParams,completion: @escaping([LoginModel]?, Error?) -> ()) {
        
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.loginUrl)")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        //  request.addValue("{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"test12\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", forHTTPHeaderField: "User_Agent")
        
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
                
            }
            
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [LoginModel]()
                
                do{
                    
                    let results = try JSONDecoder().decode(LoginModel.self, from: data)
                    //print (" get data \(results)")
                    
                    Check_status.removeAll()
                    
                    Check_status.append(LoginModel.init(status: results.status, data: results.data, error: results.error))
                    
                    completion(Check_status,nil)
                }catch let jsonErr{
                   
                    print("json error : \(jsonErr.localizedDescription)")
                    
                    completion(Check_status,nil)
                    
                }
            }
            
        }.resume()
        
    }
    
    //MARK:- OTP Verify Api
    
    func OtpVerify(params:OTPVerifyParams,completion: @escaping([OtpVerifyModel]?, Error?) -> ()) {
        
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.otpVerify)")
        print(url)
    //https://identity.dev.ltytech.ch/api/ims/v1/partner/perform/action
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"

        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"192.168.1.227\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
                
            }
            
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [OtpVerifyModel]()
                
                do{
                    
                    let results = try JSONDecoder().decode(OtpVerifyModel.self, from: data)
                    print (" get data \(results)")
                    
                    Check_status.removeAll()
                    
                    Check_status.append(OtpVerifyModel.init(status: results.status, data:results.data, error: results.error))
                    
                    completion(Check_status,nil)
                }catch let jsonErr{
                    
                    print("json error : \(jsonErr.localizedDescription)")
                    
                    completion(Check_status,nil)
                    
                }
            }
            
        }.resume()
        
    }

    //MARK:- Forgot Password Api
    
    func ForgotPass(params:ForgotParams,completion: @escaping([ForgotVCModel]?, Error?) -> ()) {
        
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.forgotPass)")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "PUT"

        
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
                
            }
            
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [ForgotVCModel]()
                
                do{
                    
                    let results = try JSONDecoder().decode(ForgotVCModel.self, from: data)
                    //print (" get data \(results)")
                    
                    Check_status.removeAll()
                    
                    Check_status.append(ForgotVCModel.init(status: results.status, data: results.data, error: results.error))
                    
                    completion(Check_status,nil)
                }catch let jsonErr{
                    
                    print("json error : \(jsonErr.localizedDescription)")
                    
                    completion(Check_status,nil)
                    
                }
            }
            
        }.resume()
        
    }
   
    //MARK:- ResetPassword Api
    
    func ResetPassword(params:ResetPassParam,completion: @escaping([ResetPassModel]?, Error?) -> ()) {
        
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.resetPassword)")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"

        
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
                
            }
            
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [ResetPassModel]()
                
                do{
                    
                    let results = try JSONDecoder().decode(ResetPassModel.self, from: data)
                    //print (" get data \(results)")
                    
                    Check_status.removeAll()
                    
                    Check_status.append(ResetPassModel.init(status: results.status, data: results.data, error: results.error))
                    
                    completion(Check_status,nil)
                }catch let jsonErr{
                    
                    print("json error : \(jsonErr.localizedDescription)")
                    
                    completion(Check_status,nil)
                    
                }
            }
            
        }.resume()
        
    }
    
    func SignUpApi(params:SignUpParams,completion: @escaping([SignUpModel]?, Error?) -> ()) {
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.signUpUrl)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [SignUpModel]()
                
                do{
                    let results = try JSONDecoder().decode(SignUpModel.self, from: data)
                    print (" get data \(results)")
                    
                    Check_status.removeAll()
                    Check_status.append(SignUpModel.init(status: results.status, data: results.data, error: results.error))
                    completion(Check_status,nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                    completion(Check_status,nil)
                }
            }
            
        }.resume()
        
    }
    //MARK:- Add agenet Api
    
    
    
    func AddAgentApi(params:AddAgentParams,completion: @escaping([AddNewAgentModel]?, Error?) -> ()) {
        
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.signUpUrl)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        let token = kUserDefaults.object(forKey: "token")
        request.setValue(token as! String, forHTTPHeaderField: "Access-Token")
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [AddNewAgentModel]()
                
                do{
                    let results = try JSONDecoder().decode(AddNewAgentModel.self, from: data)
                    print (" get data \(results)")
                    
                    Check_status.removeAll()
                    Check_status.append(AddNewAgentModel.init(status:results.status, data: results.data, error: results.error))
                    completion(Check_status,nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                    completion(Check_status,nil)
                }
            }
            
        }.resume()
        
    }
    //MARK:- Profile detail Api // ++ need to change this method
    
    func profileDetailApi(params:ProfileParams,completion: @escaping([ProfileModel]?, Error?) -> ()) {
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.PROFILE_DETAIL_URL)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{\"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\":\"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        let token = kUserDefaults.object(forKey: "token")
        request.setValue(token as! String, forHTTPHeaderField: "Access-Token")
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [ProfileModel]()
                
                do{
                    let results = try JSONDecoder().decode(ProfileModel.self, from: data)
                    print ("get data \(results)")
                    
                    Check_status.removeAll()
                    Check_status.append(ProfileModel.init(status: results.status, data: results.data, error: results.error))
                    completion(Check_status,nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                    completion(Check_status,nil)
                }
            }
            
        }.resume()
        
    }
    
    //MARK:- update agent Api
    
    func updateAgentApi(params:EditAgentModel,completion: @escaping([AgentEditDetailModel]?, Error?) -> ()) {
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.agentDetailupdateUrl)")
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        let token = kUserDefaults.object(forKey: "token")
        request.setValue(token as! String, forHTTPHeaderField: "Access-Token")
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [AgentEditDetailModel]()
                
                do{
                    let results = try JSONDecoder().decode(AgentEditDetailModel.self, from: data)
                    print (" get data \(results)")
                    
                    Check_status.removeAll()
                    Check_status.append(AgentEditDetailModel.init(status:results.status, data: results.data, error: results.error))
                    completion(Check_status,nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                    completion(Check_status,nil)
                }
            }
            
        }.resume()
        
    }
    
    
    //MARK:  Api Call Method for Post Mathod
    
    func postRequestApi<T: Codable>(url: String,method:String,passToken:Bool,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
    {

        //code to register user
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method
        let dataDictionary = dataDict
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            
            urlRequest.httpBody = requestBody
            
            let dic = ["platform": "IOS", "browser": "", "browserVersion": "", "osVersion": "13", "deviceId": deviceId, "appVersion": "1.0", "ipAddress": "sdsd", "macAddress": ""]
            
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: dic,
                options: []) {
                //            let theJSONText = String(data: theJSONData,
                //                                     encoding: .ascii)
                //            print("JSON string = \(theJSONText!)")
                if let jsonString = String(data: theJSONData, encoding: .utf8) {
                    urlRequest.setValue(jsonString, forHTTPHeaderField: "User_Agent")
                    
                }
                
            }
            
//            urlRequest.setValue(dic.description, forHTTPHeaderField: "User_Agent")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if passToken {
                let token = kUserDefaults.object(forKey: "token")
                
                urlRequest.setValue(token as! String, forHTTPHeaderField: "Access-Token")
                
            }
            
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
           // print(HTTPURLResponse().statusCode)
            if(data != nil && data?.count != 0)
            {
                do{
                    
                    let result = try JSONDecoder().decode(expecting, from: data!)

                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
                
                // let response = String(data: data!, encoding: .utf8)
                // debugPrint(response)
            }else{
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }
    
    
    //MARK:  Api Call Method for Put Mathod
    
    func putRequestApi<T: Codable>(url: String,method:String,isPassToken:Bool ,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
       {
           //code to register user
           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = method
           let dataDictionary = dataDict
          
           do {
               let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
               
               let dic = ["platform": "IOS", "browser": "", "browserVersion": "", "osVersion": "13", "deviceId": deviceId, "appVersion": "1.0", "ipAddress": "sdsd", "macAddress": ""]
               
               if let theJSONData = try? JSONSerialization.data(
                   withJSONObject: dic,
                   options: []) {
                   
                   if let jsonString = String(data: theJSONData, encoding: .utf8) {
                       urlRequest.setValue(jsonString, forHTTPHeaderField: "User_Agent")
                       
                   }
                   
               }

               urlRequest.httpBody = requestBody
               urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

               if isPassToken {
                   
                   let token = kUserDefaults.object(forKey: "token")
                   
                   urlRequest.addValue(token as! String, forHTTPHeaderField: "Access-Token")
               }
               else {
                   urlRequest.addValue("test", forHTTPHeaderField: "data-hash")
                   urlRequest.addValue("test", forHTTPHeaderField: "device-id")
               }


           } catch let error {
               debugPrint(error.localizedDescription)
           }

           URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

               if(data != nil && data?.count != 0)
               {
                      do{
                         
                          let result = try JSONDecoder().decode(expecting, from: data!)
                         // let result = String(data: data!, encoding: .utf8)
                          completion(.success(result))
                       }
                       catch{
                           completion(.failure(error))
                       }
            
                  // let response = String(data: data!, encoding: .utf8)
                  // debugPrint(response)
               }else{
                   if let error = error {
                       completion(.failure(error))
                   }else{
                       completion(.failure(NetworkError.invalidData))
                   }
               }
           }.resume()
       }
    
    //MARK: Get Api Call Method
    
    func requestGetApi<T: Codable>(url: URL?, shouldSendHeader: Bool,expecting: T.Type ,completion: @escaping(Result<T,Error>) -> Void){
        
        var urlRequest = URLRequest(url: url!)

        if shouldSendHeader {
           // var urlRequest = URLRequest(url: url!)
            let token = kUserDefaults.object(forKey: "token")
            urlRequest.httpMethod = "get"
            urlRequest.setValue(token as! String, forHTTPHeaderField: "Access-Token")
           urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")

        }

        
        
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _,error in
    
        guard let data = data else {
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.failure(NetworkError.invalidData))
            }
           return
           }
            do{
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
        }
    

    //MARK:- Register  phone 
    func register<T: Codable>(url: String,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
       {
           //code to register user
           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = "put"
           let dataDictionary = dataDict
          
           do {
               let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)

               urlRequest.httpBody = requestBody
               urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
               urlRequest.addValue("test", forHTTPHeaderField: "data-hash")
               urlRequest.addValue("test", forHTTPHeaderField: "device-id")


           } catch let error {
               debugPrint(error.localizedDescription)
           }

           URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

               if(data != nil && data?.count != 0)
               {
                      do{
                         
                          let result = try JSONDecoder().decode(expecting, from: data!)
                          
                        //  try result.encode(to: "Status" as! Encoder)
                         // let result = String(data: data!, encoding: .utf8)
                          completion(.success(result))
                       }
                       catch{
                           completion(.failure(error))
                       }
            
                  // let response = String(data: data!, encoding: .utf8)
                  // debugPrint(response)
               }else{
                   if let error = error {
                       completion(.failure(error))
                   }else{
                       completion(.failure(NetworkError.invalidData))
                   }
               }
           }.resume()
       }
    
    //MARK:  Api Call Method for Update phone and email id
    
    func putRequestApiForUpdatePhoneEmail<T: Codable>(url: String,method:String,passToken:Bool,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
    {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method
        let dataDictionary = dataDict
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            
            urlRequest.httpBody = requestBody
            urlRequest.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
            
            if passToken {
                let token = kUserDefaults.object(forKey: "token")
                urlRequest.setValue(token as? String, forHTTPHeaderField: "Access-Token")
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if(data != nil && data?.count != 0)
            {
                do{
                    let result = try JSONDecoder().decode(expecting, from: data!)
                    
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }else{
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }
    
    
    //MARK:- OTP Verify Api For Update Phone And Email
    
    func OtpVerifyForPhone(params:OTPVerifyPhoneParams,isComming:String,completion: @escaping([ProfileModel]?, Error?) -> ()) {
   
        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.verifyProfileUpadtePhone)")
        print(url ?? "")
        //https://identity.dev.ltytech.ch/api/ims/v1/partner/perform/action
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"192.168.1.227\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        let token = kUserDefaults.object(forKey: "token")
        request.setValue(token as? String, forHTTPHeaderField: "Access-Token")
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [ProfileModel]()
                
                do{
                    
                    let results = try JSONDecoder().decode(ProfileModel.self, from: data)
                    print (" get data \(results)")
                    
                    Check_status.removeAll()
                    Check_status.append(ProfileModel.init(status: results.status, data:results.data, error: results.error))
                    completion(Check_status,nil)
                }catch let jsonErr{
                    
                    print("json error : \(jsonErr.localizedDescription)")
                    
                    completion(Check_status,nil)
                    
                }
            }
            
        }.resume()
        
    }
    
    func OtpVerifyForEmail(params:OTPVerifyEmailParams,isComming:String,completion: @escaping([ProfileModel]?, Error?) -> ()) {

        let url = URL(string:"\(LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.verifyProfileUpadteEmail)")
        print(url ?? "")
        //https://identity.dev.ltytech.ch/api/ims/v1/partner/perform/action
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"192.168.1.227\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
        let token = kUserDefaults.object(forKey: "token")
        request.setValue(token as? String, forHTTPHeaderField: "Access-Token")
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if String(data: jsonData, encoding: .utf8) != nil {
                request.httpBody = jsonData
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                
                var Check_status = [ProfileModel]()
                
                do{
                    
                    let results = try JSONDecoder().decode(ProfileModel.self, from: data)
                    print (" get data \(results)")
                    
                    Check_status.removeAll()
                    Check_status.append(ProfileModel.init(status: results.status, data:results.data, error: results.error))
                    completion(Check_status,nil)
                }catch let jsonErr{
                    
                    print("json error : \(jsonErr.localizedDescription)")
                    
                    completion(Check_status,nil)
                    
                }
            }
            
        }.resume()
        
    }
    
    //MARK:  Post Mathod Api Call for Partner profile detail
    
    func postRequestApiForProfileDetail<T: Codable>(url: String,method:String,passToken:Bool,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
    {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method
        let dataDictionary = dataDict
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            urlRequest.httpBody = requestBody
            urlRequest.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"192.168.1.227\",\"macAddress\": \"\"}", "App-Token": kUserDefaults.value(forKey: AppKeys.fcmKey) as? String ?? ""]
          //  urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if passToken {
                let token = kUserDefaults.object(forKey: "token")
                urlRequest.setValue(token as? String, forHTTPHeaderField: "Access-Token")
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if(data != nil && data?.count != 0)
            {
                do{
                    
                    let result = try JSONDecoder().decode(expecting, from: data!)
                    // let result = String(data: data!, encoding: .utf8)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
                
                // let response = String(data: data!, encoding: .utf8)
                // debugPrint(response)
            }else{
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }

    //MARK:- Upload document using url session
    
//    func postApiDataWithMultipartForm<T:Decodable>(requestUrl: URL, imageData: Data, request: UploadDocumentsParams, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void){
//
//        var urlRequest = URLRequest(url: requestUrl)
//        let lineBreak = "\r\n"
//
//        urlRequest.httpMethod = "post"
//        let boundary = "---------------------------------\(UUID().uuidString)"
//        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
//
//        let fname = "test.png"
//        let mimetype = "image/png"
//
//        var requestData = Data()
//
//        requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append(request.userID! .data(using: .utf8)!)
//
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"name\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.name! + lineBreak)" .data(using: .utf8)!)
//
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"email\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.email! + lineBreak)" .data(using: .utf8)!)
//
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"phone\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.phone! + lineBreak)" .data(using: .utf8)!)
//
//        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"location\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
//        requestData.append("\(request.location! + lineBreak)" .data(using: .utf8)!)
//
////        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
////        requestData.append("content-disposition: form-data; name=\"user_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
////        requestData.append("\(request.userID! + lineBreak)" .data(using: .utf8)!)
//
//        requestData.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        requestData.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
//        requestData.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
//        requestData.append(imageData)
//        requestData.append("\r\n".data(using: String.Encoding.utf8)!)
//
//        requestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
//
//        urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
//        urlRequest.httpBody = requestData
//
//        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//            if(error == nil && data != nil && data?.count != 0)
//            {
//             let dataStr = String(decoding: requestData, as: UTF8.self) //to view the data you receive from the API
//                print(dataStr)
//                do {
//                    let response = try JSONDecoder().decode(T.self, from: data!)
//                    _=completionHandler(response)
//                }
//                catch let decodingError {
//                    debugPrint(decodingError)
//                }
//            }
//
//        }.resume()
//
//    }
    


}


extension UIApplication {

    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}

class ErrorReporting {

    static func showMessage(title: String, msg: String) {
        let alert = UIAlertController(title: "Alert", message: "Please check your internet", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
    }
}

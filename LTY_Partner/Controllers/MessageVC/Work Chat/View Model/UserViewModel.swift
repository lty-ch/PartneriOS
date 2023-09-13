//
//  WorkChatDetailChatVC.swift
//  Skazule
//
//  Created by CTS-Jay Gupta on 28/06/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct UserViewModel {
    
    private let fdbRef = Database.database().reference()
    
    func loginWithFirebase(email:String, userId:String, userName:String, profile:String, timestamp : String, role : String, onSuccess:@escaping(Bool) -> Void, onError:@escaping(String) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: "123456") { (result, error) in
            
            if error != nil{
                onError(error!.localizedDescription)
            }else{
                
                guard let userId = Auth.auth().currentUser?.uid  else { return }
                                
                let userDict = [
                    "userId"    : userId,
                    "userName"  : userName,
                    "pic"   : profile,
                    "email"     : email,
                    "timestamp" : timestamp,
                    "role"      : role
                ]
                
                fdbRef.child("Users").child(userId).updateChildValues(userDict as [AnyHashable : Any])
                onSuccess(true)
            }
        }
    }
    
//    func loginWithFirebase(email: String, password: String, id : String, name : String,ID : String,onSuccess:@escaping(Bool) -> Void, onError:@escaping(String) -> Void){
//
//        Auth.auth().signIn(withEmail: email, password: "123456") { (result, error) in
//
//            if error != nil{
//                onError(error!.localizedDescription)
//            }else{
//
//                guard let userId = Auth.auth().currentUser?.uid  else { return }
//
//                let userDict = [
//                    "email": email,
//                    "name" : name
//                ]
//
//                fdbRef.child("users").child(userId).updateChildValues(userDict as [AnyHashable : Any])
//                onSuccess(true)
//            }
//        }
//    }
//    (email:String, userId:String, userName:String, profile:String, timestamp : String, role : String)
    
//    func signUpWithFirebase(email: String, password: String ,id : String, name : String,ID : String, onSuccess:@escaping(Bool) -> Void, onError:@escaping(String) -> Void){
    
    func signUpWithFirebase(email: String, password: String ,userId : String, userName : String, profile : String, timestamp : String, role : String, onSuccess:@escaping(Bool) -> Void, onError:@escaping(String) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: "123456") { (result, error) in
            
            if let err = error{
                let error = err as NSError
                switch error.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    onSuccess(true)
                default:
                    onError(error.localizedDescription)
                }
            }else{
                onSuccess(true)
            }
        }
    }
    
}

//
//  ChatViewModel.swift
//  SaharaGo_Vendor
//
//  Created by ChawTech Solutions on 18/10/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct ChatViewModel {
    
    private let fdbRef = Database.database().reference()
    
//    func getUsersList(onSuccess:@escaping([FirebaseUser]) -> Void, onError:@escaping(String) -> Void){
//
//        //.child(UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.ENCRYPTED_ID) as! String)
//        //d26b9ed13f83547026ba4859babc086c - user
//        var users = [FirebaseUser]()
//        let currentUserId = UserDefaults.standard.value(forKey:AppKeys.partnerID) as! String
//        AppKeys.refFbdb.child("Users").child(currentUserId).child("conversations").observe(.value) { snapshot,data  in
//           //     print(snapshot)
//            var userListArr = [String]()
//            if snapshot.childrenCount != 0 {
//
//                guard let result = snapshot.value as? [String: Any] else {
//                    return
//                }
//                userListArr.removeAll()
//                for (key, value) in result {
//                    print(key)
//                    userListArr.append(key)
//                }
//                let abc = self.getAuthUser(listArr:userListArr)
//                onSuccess(abc)
//            }else {
//                onSuccess(users)
//
//            }
//
//
//
////            if snapshot.exists(){
////                print(snapshot)
////                var fcm_key = ""
////                var email = ""
////                var name = ""
////                if let dict = snapshot.value as? NSDictionary, let postContent = dict["fcmKey"] as? String {
////                    fcm_key = postContent
////                } else {
////
////                }
////                if let dict = snapshot.value as? NSDictionary, let postContent = dict["email"] as? String {
////                    email = postContent
////                } else {
////
////                }
////                if let dict = snapshot.value as? NSDictionary, let postContent = dict["name"] as? String {
////                    name = postContent
////                } else {
////
////                }
////
////                let enumrator = snapshot.children
////
////                while let snap = enumrator.nextObject() as? DataSnapshot{
////                    if let userDict = snap.value as? [String: AnyObject] {
////                        print(userDict)
////                        users.removeAll()
////                        for (key, value) in userDict {
////                            print("key is - \(key) and value is - \(value)")
////
////                          //  let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as! String, name:name as! String, profilePic: "", timestamp: value["timestamp"] as! String)
////
////                            let userInstance = FirebaseUser(uid: key, email: email, lastMessage:"", name:name, profilePic: "", timestamp:"")
////                            users.append(userInstance)
////                        }
////                    }
////                }
////                let sortedUserArray = sortUsersListByTime(usersArray: users)
////                onSuccess(sortedUserArray)
////            }
////            else{
////                onSuccess(users)
////            }
//        }
//
//    }
    
//    func getAuthUser(listArr:[String]) -> [FirebaseUser]{
//        var users = [FirebaseUser]()
//        for item in listArr{
//            AppKeys.refFbdb.child("Users").child(item).observe(.value) { snapshot,data  in
//
//                if snapshot.exists(){
//                    print(snapshot)
//                    var fcm_key = ""
//                    var email = ""
//                    var name = ""
//                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["fcmKey"] as? String {
//                        fcm_key = postContent
//                    } else {
//
//                    }
//                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["email"] as? String {
//                        email = postContent
//                    } else {
//
//                    }
//                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["name"] as? String {
//                        name = postContent
//                    } else {
//
//                    }
//
//                    let enumrator = snapshot.children
//
//                    while let snap = enumrator.nextObject() as? DataSnapshot{
//                        if let userDict = snap.value as? [String: AnyObject] {
//                            print(userDict)
//
//                            for (key, value) in userDict {
//                                print("key is - \(key) and value is - \(value)")
//
//                                //  let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as! String, name:name as! String, profilePic: "", timestamp: value["timestamp"] as! String)
//
//                                let userInstance = FirebaseUser(uid: key, email: email, lastMessage:"", name:name, profilePic: "", timestamp:"")
//                                users.append(userInstance)
//                            }
//                        }
//                    }
//                    users = sortUsersListByTime(usersArray: users)
//                    //onSuccess(sortedUserArray)
//                }
//            }
//        }
//        return users
//    }
    
    
    
//    func getUsersList(onSuccess:@escaping([FirebaseUser]) -> Void, onError:@escaping(String) -> Void){
//
//        var users = [FirebaseUser]()
//        fdbRef.child("Users").observeSingleEvent(of: .value) { (snapshot) in
//
//            if snapshot.exists(){
//
//                let enumrator = snapshot.children
//
//                while let snap = enumrator.nextObject() as? DataSnapshot{
//
//                    if let userDict = snap.value as? [String: AnyObject] {
//                        let uid = snap.key
//                        let currentUid = Auth.auth().currentUser?.uid
//                        let dict = userDict["conversations"] as? [String:AnyObject]
//                        let conversationDict = dict?[currentUid!] as? [String:AnyObject]
//                        let lastMessage = conversationDict?["lastMessage"] as? String
//                        let timeStamp = conversationDict?["timestamp"] as? String
//                        let email = userDict["email"] as? String
//                        let name = userDict["name"] as? String
//                        let profilePic = userDict["profilePic"] as? String
//
//                        let user = FirebaseUser(uid: uid, email: email, lastMessage: lastMessage, name: name, profilePic: profilePic, timestamp: timeStamp)
//
//                        let currentUser = UserDefaults.standard.string(forKey: AppKeys.partnerID)
//
//                        if email != currentUser{
//                            users.append(user)
//                        }
//                    }
//                }
//                let sortedUserArray = sortUsersListByTime(usersArray: users)
//                onSuccess(sortedUserArray)
//            }else{
//                onSuccess(users)
//            }
//        }
//
//    }
    
    func sortUsersListByTime(usersArray: [FirebaseUser]) -> [FirebaseUser]{
        
        var arrayWithTimeStamp = [FirebaseUser]()
        var arrayWithoutTimeStap = [FirebaseUser]()
        
        usersArray.forEach { (user) in
            if user.timestamp == nil{
                arrayWithoutTimeStap.append(user)
            }else{
                arrayWithTimeStamp.append(user)
            }
        }
        
        arrayWithTimeStamp = arrayWithTimeStamp.sorted(by: { $0.timestamp! > $1.timestamp! })
        let newArray = arrayWithTimeStamp + arrayWithoutTimeStap
        return newArray
        
    }
    
    func getConversationId(request: Message, onSuccess:@escaping(String?) -> Void, onError:@escaping(String) -> Void){
        
        fdbRef.child("Users").child(request.fromID!).child("conversations").child(request.toID!).observe( .value) { (snapshot) in
            
            if snapshot.exists(){
                if let dataDict = snapshot.value as? [String:AnyObject]{
                    let conversationId = dataDict["location"]
                    onSuccess(conversationId as? String)
                }
            }else{
                onSuccess(nil)
            }
        }
    }
    
    func getMessages(conversationId: String? = "abc", onSuccess:@escaping([Message]) -> Void){
        
        var messages = [Message]()
        
        fdbRef.child("conversations").child(conversationId ?? "abc").observe(.childAdded) { (snapshot) in
            print(snapshot)
            NotificationCenter.default.post(name: NSNotification.Name("Message"), object: nil)
            guard snapshot.exists() else { return }
            if let dataDict = snapshot.value as? [String:AnyObject]{
                
                let content = dataDict["content"] as? String
                let fromId = dataDict["fromID"] as? String
                let toId = dataDict["toID"] as? String
                let isRead = dataDict["isRead"] as? Bool
                let timestamp = dataDict["timestamp"] as? String
                let queryID = dataDict["queryId"] as? String
                let type = dataDict["type"] as? String
                
                let message = Message(content: content, fromID: fromId, timestamp: timestamp, isRead: isRead, toID: toId, type: type,queryId : queryID)
                messages.append(message)
                onSuccess(messages)
            }
        }
    }
    
    func sendMessage(request: Message, onSuccess:@escaping(String) -> Void){
        
        let messageDict = request.convertToDictionary()!
   
        AppKeys.refFbdb.child("Users").child(request.fromID!).child("conversations").child(request.toID!).observeSingleEvent(of: .value) { (snapshot) in
            
            var conversationId = ""
            var conversationDict: [String:AnyObject] = [:]
            
            if let dataDict = snapshot.value as? [String : AnyObject]{
                conversationId = dataDict["location"] as! String
                conversationDict = [
                    "location" : conversationId,
                    "timestamp" : request.timestamp!,
                    "lastMessage" : request.content!,
                ] as [String : AnyObject]
                
            }else{
                conversationId = NSUUID().uuidString.lowercased()
                
                conversationDict = [
                    "location" : conversationId,
                    "lastMessage" : request.content!,
                    "timestamp" : request.timestamp!,
                ] as [String : AnyObject]
                
            }
            
            AppKeys.refFbdb.child("Users").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict)
            
          //  AppKeys.refFbdb.child("Users").child(request.fromID!).child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict)
            
            AppKeys.refFbdb.child("Users").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict)
            
            
            AppKeys.refFbdb.child("conversations").child(conversationId).childByAutoId().updateChildValues(messageDict as [String:AnyObject])
            
            onSuccess(conversationId)
        }
        
    }
}

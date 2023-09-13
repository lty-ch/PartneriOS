//
//  Extension+AllChatMethods.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 08/07/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

extension WorkChatDetailChatVC {
    
    //MARK:- Send Messages on server
    
//    func sendMessage(request: Message1, onSuccess:@escaping(String) -> Void){
//
//        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
//        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
//        let databaseNode = "Users"
//
//        // guard let fromId = Auth.auth().currentUser?.uid else { return }
//        let fromId = partnerId
//        let messageDict = request.convertToDictionary()!
//
//        AppKeys.refFbdb.child("users").child(senderId).child("conversations").child(fromId).observeSingleEvent(of: .value, with: { (snapshot) in
//            var conversationId = ""
//
//
//            var conversationDict: [String:AnyObject] = [:]
//
//            if let dataDict = snapshot.value as? [String : AnyObject]{
//                conversationId = dataDict["location"] as! String
////                conversationDict = [
////                    "timestamp" : request.timestamp!,
////                    "lastMessage" : request.content!,
////                    // "metaData" : metadataDic
////                ] as [String : AnyObject]
//
//            }else{
//                conversationId = NSUUID().uuidString.lowercased()
//
////                conversationDict = [
////                    "location" : conversationId,
////                    "lastMessage" : request.content!,
////                    "timestamp" : request.timestamp!,
////                    // "metaData" : metadataDic
////                ] as [String : AnyObject]
//
//            }
//
//           AppKeys.refFbdb.child(databaseNode).child(partnerId).child("users").child(self.senderId).child("conversations").child(conversationId).childByAutoId().updateChildValues(messageDict as [String:AnyObject])
//
//
//            AppKeys.refFbdb.child("conversations").child(conversationId).childByAutoId().updateChildValues(messageDict as [String:AnyObject])
//
//            onSuccess(conversationId)
//        })
//
//    }
    
    
    
    
    
    
    
    //MARK:- get messages on fbdb
    
    
    func getMessages(senderID: String, recieverID: String, onSuccess:@escaping([Message]) -> Void){
        
        var messages = [Message]()
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        let databaseNode = "Users"
       
       // AppKeys.refFbdb.child("Chat").observe(.childAdded) { (snapshot) in
        AppKeys.refFbdb.child(databaseNode).child(partnerId).child(self.senderId).child("conversations").observe(.childAdded) { (snapshot) in

           // NotificationCenter.default.post(name: NSNotification.Name("Message"), object: nil)
           // guard snapshot.exists() else { return }
            
                guard let result = snapshot.value as? [String: Any] else {
                    return
                }
                
                for (key, value) in result {
                    
                    let dataDict = value as? [String: Any]
                    
                    let content   = dataDict?["message"] as? String
                    let fromId    = dataDict?["senderId"] as? String
                    let toId      = dataDict?["receiverId"] as? String
                    let isRead    = dataDict?["isRead"] as? Bool
                    let timestamp = dataDict?["timestamp"] as? String
                    let type      = dataDict?["type"] as? String
                    let queryID   = dataDict?["queryId"] as? String
                    if ((fromId == senderID) && (toId == recieverID)) || ((fromId == recieverID) && (toId == senderID))
                    {
                        let message = Message(content: content, fromID: fromId, timestamp: timestamp, isRead: isRead, toID: toId, type: type,queryId : queryID)
                        messages.append(message)
                    }

                }

                onSuccess(messages)
            }
    }
    
    
    // MARK:- Upload Image url to firebase server

    func uploadImageURLToFirebase(request: Message1, imageURL: Data, onSuccess:@escaping(String) -> Void){
        
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        let databaseNode = "Users"
        var conversationId = ""
        conversationId = NSUUID().uuidString.lowercased()

        // Step 1: Get a reference to your Firebase Storage
        
        let storage = Storage.storage()
        let storageRef = storage.reference()

        // Step 2: Create a reference to the image you want to upload (e.g., "images/imageName.jpg")
        
        let imageName = "\(request.timestamp!)temp.jpg" //"imageName.jpg"
        let imageRef = storageRef.child(imageName) //(timestamp+imageUri!!.name)

        // Step 3: Upload the image URL to Firebase Storage
        
        let uploadTask = imageRef.putData(imageURL, metadata: nil) { metadata, error in
            guard metadata != nil else {
                print("Error uploading image URL: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // You can get the download URL if you need it.
            
            imageRef.downloadURL { url, error in
                if let downloadURL = url {
                    print("Image download URL: \(downloadURL)")

                    var chatDict: [String:AnyObject] = [:]
                    chatDict = [
                        "senderId"      : request.senderId!,
                        "receiverId"    : request.receiverId!,
                        "message"       : "\(downloadURL)",
                        "timestamp"     : request.timestamp!,
                        "type"          : request.type!,
                       // "isSeen"        : request.isSeen!
                    ] as [String : AnyObject]

                  //  self.fdbRef.child("Chat").childByAutoId().updateChildValues(chatDict)
                    
                    AppKeys.refFbdb.child(databaseNode).child(partnerId).child("users").child(self.senderId).child("conversations").child(conversationId).childByAutoId().setValue(chatDict as [String:AnyObject])
                    
                    AppKeys.refFbdb.child("conversations").child(conversationId).childByAutoId().setValue(chatDict as [String:AnyObject])

                } else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }

        // You can also observe the progress of the upload task if needed.
        uploadTask.observe(.progress) { snapshot in
            // Handle progress here
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Upload progress: \(percentComplete)%")
        }

        onSuccess("Sussesful uploaded ......")
    }
    
    
    // MARK:- Upload PDF url to firebase server

    func uploadDocumentToFirebase(request: Message1,docUrl: Data, onSuccess:@escaping(String) -> Void){
        
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        let databaseNode = userType == "AGENT" ? "Agents" : "partners"
        
        var conversationId = ""
        conversationId = NSUUID().uuidString.lowercased()

        // Step 1: Get a reference to your Firebase Storage
        
        let storage = Storage.storage()
        let storageRef = storage.reference()

        // Step 2: Create a reference to the image you want to upload (e.g., "images/imageName.jpg")
        
        let docName = "\(request.timestamp!)temp.pdf" //"imageName.jpg"
        let imageRef = storageRef.child(docName) //(timestamp+imageUri!!.name)

        // Step 3: Upload the image URL to Firebase Storage
        
        let uploadTask = imageRef.putData(docUrl, metadata: nil) { metadata, error in
            guard metadata != nil else {
                print("Error uploading image URL: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // You can get the download URL if you need it.
            
            imageRef.downloadURL { url, error in
                if let downloadURL = url {
                    print("Image download URL: \(downloadURL)")

                    var chatDict: [String:AnyObject] = [:]
                    chatDict = [
                        "senderId"      : request.senderId!,
                        "receiverId"    : request.receiverId!,
                        "message"       : "\(downloadURL)",
                        "timestamp"     : request.timestamp!,
                        "type"          : request.type!,
                       // "isSeen"        : request.isSeen!
                    ] as [String : AnyObject]

                  //  self.fdbRef.child("Chat").childByAutoId().updateChildValues(chatDict)
                    
                    AppKeys.refFbdb.child(databaseNode).child(partnerId).child("users").child(self.senderId).child("conversations").child(conversationId).childByAutoId().setValue(chatDict as [String:AnyObject])
                    
                    AppKeys.refFbdb.child("conversations").child(conversationId).childByAutoId().setValue(chatDict as [String:AnyObject])

                } else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }

        // You can also observe the progress of the upload task if needed.
        uploadTask.observe(.progress) { snapshot in
            // Handle progress here
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Upload progress: \(percentComplete)%")
        }

        onSuccess("Sussesful uploaded ......")
    }
}

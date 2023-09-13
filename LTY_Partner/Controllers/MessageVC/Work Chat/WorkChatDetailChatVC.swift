//
//  WorkChatDetailChatVC.swift
//  Skazule
//
//  Created by CTS-Jay Gupta on 28/06/23.
//

import UIKit
import FirebaseAuth
import SwiftyJSON
import IQKeyboardManagerSwift

struct NotificationKeys {
    static let MESSAGE = "Message"
}
//var isOnChatVC: Bool = false

class WorkChatDetailChatVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageBackView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var receiverName: UILabel!
    @IBOutlet weak var sendMsgTxtView: UITextView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var receiverProfileImgView: UIImageView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    var user: FirebaseUser?
    private let chatViewModel = ChatViewModel()
    var profilePhoto = String()
    let imagePicker = UIImagePickerController()
    var senderName = ""
    var senderId = ""
    var senderEmail = ""
    var senerImage = ""
    var receiverId = ""
    var profilePicUrl = ""
    var firstmessages = ""
    var conversationId: String?

    var fcmKeys = [JSON]()
    var messages = [Message]()
    var isUserPresentInfdb = false
    var fcmKeyValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetail()
        setDrowerHeight()

    }
    
    func getConversationId(){

        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let fromId = partnerId //Auth.auth().currentUser?.uid else { return }
        let toId = self.senderId
  
        let request = Message(fromID: fromId, toID: toId)

        chatViewModel.getConversationId(request: request) { (conversationId) in
            self.conversationId = conversationId
            self.getMessages()
        } onError: { (errorMesage) in
            DispatchQueue.main.async {

                self.ShowAlert(message: errorMesage)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getConversationId()
        checkIfUserExistInFDB()
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    
    //MARK:- backAction Btn
    @IBAction func backActionButton(_ sender: UIButton) {
        self.popVC(animated: true)

    }
    
    func checkIfUserExistInFDB() {
        AppKeys.refFbdb.child("Users").observeSingleEvent(of: .value) { snapshot in
            
            if snapshot.childrenCount != 0 {
                
                guard let result = snapshot.value as? [String: Any] else {
                    return
                }
                var userListArray = [String]()
                
                userListArray.removeAll()
                for (key, value) in result {
                    userListArray.append(key)
                    if key == self.senderId {
                        self.isUserPresentInfdb = true
                        
                        break
                    }
                }
                if !self.isUserPresentInfdb{
                    
                    let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

                    let userDict = [
                        "email": self.senderEmail,
                        "name" : self.senderName,
                        "type" : userType,
                        "pic": self.senerImage
                        
                        //"fcmKey" : UserDefaults.standard.object(forKey: "fcm_key") as! String
                    ]
                    
                    AppKeys.refFbdb.child("Users").child("\(self.senderId )").updateChildValues(userDict as [AnyHashable : Any])
                }
                
            }else {
                
            }
        }
        


    }

    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = 100//DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
    private func setDetail(){
        
        self.receiverName.text = self.senderName
        //let imageUrl = URL(string: self.profilePhoto)
        //self.receiverProfileImgView.image = UIImage(named: "user")
        
        self.receiverProfileImgView.sd_setImage(with:URL(string: senerImage ?? ""), placeholderImage:UIImage(named: "user"))
        
        self.sendMsgTxtView.placeholder = "Type a message..."
       
        self.messageBackView.layer.cornerRadius = 8
        
        
        self.tblView.register(UINib(nibName: "SenderCell", bundle: .main), forCellReuseIdentifier: "SenderCell")
        self.tblView.register(UINib(nibName: "SenderImageCell", bundle: .main), forCellReuseIdentifier: "SenderImageCell")
        self.tblView.register(UINib(nibName: "ReceiverCell", bundle: .main), forCellReuseIdentifier: "ReceiverCell")
        self.tblView.register(UINib(nibName: "ReceiverImageCell", bundle: .main), forCellReuseIdentifier: "ReceiverImageCell")
        self.tblView.register(UINib(nibName: "SenderdocCell", bundle: .main), forCellReuseIdentifier: "SenderdocCell")
        
    }
    

    func getMessages(){

        chatViewModel.getMessages(conversationId: self.conversationId) { (messages) in
            self.messages = messages
           // NotificationCenter.default.post(name: NSNotification.Name(NotificationKeys.MESSAGE), object: nil)
            DispatchQueue.main.async {
                self.tblView.reloadData()
                self.tblView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
//                DispatchQueue.main.async {
//                    self.tblView.beginUpdates()
//                    self.tblView.endUpdates()
//                }
//                self.tblView.beginUpdates()
//                self.tblView.endUpdates()
               
//                DispatchQueue.main.asyncAfter(deadline:.now() + 0.005) {
//                    self.tblView.beginUpdates()
//                    self.tblView.endUpdates()
//                }
                
            }
        }
    }
    //MARK:- Send Action Btn
    
    @IBAction func onClickSend(){
//        sendMsgTxtView.isUserInteractionEnabled = false
//        sendBtn.isUserInteractionEnabled = true
        let message = sendMsgTxtView.text.trim()
        guard !message.isEmpty else { return }
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let fromId = partnerId //Auth.auth().currentUser?.uid else { return }
        let toId = self.senderId
        if toId == ""
        {
            return
        }
        let timestamp = Int(Date().timeIntervalSince1970*1000)
        let isRead = false
        let type = "text"

        self.sendNotification(message: message, image: "")
        let request = Message(content: message, fromID: fromId, timestamp: "\(timestamp)", isRead: isRead, toID: toId, type: type, queryId: "")

        
        applicationFinishedRestoringState()

//        AppKeys.refFbdb.child("Users").child("\(senderId ?? "")").setValue(userDict as [AnyHashable : Any])
//        
        chatViewModel.sendMessage(request: request) { (conversationId) in
            if self.conversationId == nil{
                self.conversationId = conversationId

                self.getMessages()
            }
            self.sendMsgTxtView.text = ""
        }
    }
    
    func sendNotification(message : String, image: String) {
        let sender = PushNotificationSender()
        
        let name = kUserDefaults.value(forKey: AppKeys.agentName) as! String
//        let fcmKey = kUserDefaults.value(forKey: AppKeys.fcmKey) as? String
//        if fcmKey == nil {
//            self.fcmKeyValue = "dummmy_App_fcm"
//        }else{
//            self.fcmKeyValue = fcmKey ?? ""
//        }

        sender.sendPushNotification(to: self.fcmKeyValue , title: "New Message from \(name ?? "")", body: message,email : "", queryID : "", image: image)
    }

    @objc func handleKeyboard(_ notification: Notification){
  
    }
    
    @IBAction func onClickPickImage(){
        self.chooseMediaSelection()
    }

    
    //MARK:- UPDATE profile photo API
    /*
    func UPDATEprofile(imagepath : UIImage,isType : String,docurl : String){
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(self.view)
  
            
        }else{
            hideProgressOnView(self.view)
            UIAlertController.showInfoAlertWithTitle("Alert", message: "Please Check internet connection", buttonTitle: "Okay")
        }
    }
*/
    
}


extension WorkChatDetailChatVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let senderId = Auth.auth().currentUser?.uid
        let senderId = kUserDefaults.value(forKey: AppKeys.partnerID)  as? String
        let message = messages[indexPath.row]

        if message.fromID == senderId{
            if message.type == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderImageCell", for: indexPath)
                as! SenderImageCell
                cell.selectionStyle = .none
                cell.message = message
                return cell
                
            }else if message.type == "document" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderdocCell", for: indexPath) as! SenderdocCell
                cell.selectionStyle = .none
                cell.message = message
                return cell
                
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderCell
                cell.selectionStyle = .none
                cell.message = message
                return cell
            }
        }
        else{
            if message.type == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverImageCell", for: indexPath) as! ReceiverImageCell
                cell.selectionStyle = .none
                cell.message = message
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as! ReceiverCell
                cell.selectionStyle = .none
                cell.message = message
                return cell
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        if message.type == "document" {
            let doc = "\(String(describing: messages[indexPath.row].content ?? ""))"
            
            var dob = "\(messages[indexPath.row].content ?? "")"
            dob = dob.components(separatedBy: "o/")[0]
            if dob != "" {
            }

            
            if let url = URL(string:doc) {
                UIApplication.shared.open(url)
            }
        }
    }

}


extension WorkChatDetailChatVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray{
            textView.text = ""
            textView.textColor = .black
        }
//        sendMsgTxtView.isUserInteractionEnabled = true
//        sendBtn.isUserInteractionEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.textColor = .lightGray
            textView.placeholder = "Type something..."
        }
//        sendMsgTxtView.isUserInteractionEnabled = false
//        sendBtn.isUserInteractionEnabled = true
    }
}

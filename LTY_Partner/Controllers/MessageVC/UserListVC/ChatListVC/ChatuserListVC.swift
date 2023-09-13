//
//  ChatuserListVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/07/23.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ChatuserListVC: UIViewController {

    @IBOutlet weak var userListTable: UITableView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var userListArr = [FirebaseUser]()//[String]()
    var userEmailArr = [String]()
    private let chatViewModel = ChatViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setDrowerHeight()
        setupTableView()
        customNavDrower.titleLabel.text = "User List".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.rightBtn.setImage(UIImage(named: "add_blue"), for: .normal)

        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        customNavDrower.rightBtn.addTarget(self, action: #selector(openUserList(_:)), for: .touchUpInside)
    }

    func setupTableView(){
        
        userListTable.delegate = self
        userListTable.dataSource = self
        userListTable.register(UINib(nibName: "UserListTVC", bundle: .main), forCellReuseIdentifier: "UserListTVC")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getUserList()
        self.tabBarController?.tabBar.isHidden = true

    }

    func getUserList() {
        
        var users = [FirebaseUser]()
        let currentUserId = UserDefaults.standard.value(forKey:AppKeys.partnerID) as! String
        
        AppKeys.refFbdb.child("Users").child(currentUserId).child("conversations").observe(.value) { snapshot,data  in
            var userListArray = [String]()
            if snapshot.childrenCount != 0 {
                
                guard let result = snapshot.value as? [String: Any] else {
                    return
                }
                userListArray.removeAll()
                for (key, value) in result {
                    userListArray.append(key)
                }
                self.getAuthUser(listArr:userListArray)
                
            }else {
                self.noDataFoundView.isHidden = false
                self.userListTable.isHidden = true
                
            }
        }
    }
    
    
    func getAuthUser(listArr:[String]) {
        var users = [FirebaseUser]()
        self.userListArr.removeAll()

        for item in listArr{
           // SwiftLoader.show(animated: true)

            AppKeys.refFbdb.child("Users").child(item).observeSingleEvent(of: .value) { snapshot,data  in
                
                if snapshot.exists(){
                    var fcm_key = ""
                    var email = ""
                    var name = ""
                    var profile = ""
                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["fcmKey"] as? String {
                        fcm_key = postContent
                    } else {
                        
                    }
                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["email"] as? String {
                        email = postContent
                    } else {
                        
                    }
                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["name"] as? String {
                        name = postContent
                    } else {
                        
                    }
                    
                    if let dict = snapshot.value as? NSDictionary, let postContent = dict["pic"] as? String {
                        profile = postContent
                    } else {
                        
                    }
                    let enumrator = snapshot.children
                    while let snap = enumrator.nextObject() as? DataSnapshot{
                        
                        let frindanswer = snap.value as? [String:Any] ?? [String:Any]()
                        let dict = frindanswer
                     
                        for (key,value) in dict{
                            let partneID = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
                            if key == partneID {
                                let x = value as! [String:Any]

                                let lastMessage = x["lastMessage"] as? String
                                let timestamp = x["timestamp"] as? String
                                
                                let userInstance = FirebaseUser(uid: item, email: email, lastMessage:lastMessage,fcmKey:fcm_key, name:name, profilePic: profile, timestamp:timestamp)
                                self.userListArr.append(userInstance)
                                break
                            }
                        }
                        
                        if self.userListArr.count == 0 {
                           // SwiftLoader.hide()
                            self.noDataFoundView.isHidden = false
                            self.userListTable.isHidden = true
                        }
                        else{
                           // SwiftLoader.hide()
                            self.userListArr = self.userListArr.unique{$0.email ?? ""}
                            // Define a serial queue
//                            let serialQueue = DispatchQueue(label: "com.example.serialQueue")
//
//                            // Function 1
//                            func function1() {
//                                self.userListArr = self.userListArr.unique{$0.email ?? ""}
//                            }
//
//                            // Function 2
//                            func function2() {
//                                self.userListArr = self.chatViewModel.sortUsersListByTime(usersArray: self.userListArr)
//                            }
//
//
//                            // Execute functions in the serial queue
//                            serialQueue.async {
//                                function1()
//                            }
//
//                            serialQueue.async {
//                                function2()
//                            }

                            DispatchQueue.main.async {
                          
                                self.userListArr = self.sortUsersListByTime(usersArray: self.userListArr)
                                self.noDataFoundView.isHidden = true
                                self.userListTable.isHidden = false
                                self.userListTable.reloadData()
                                
                            }
                        }
                        
                    }
                } else {
                    self.noDataFoundView.isHidden = false
                    self.userListTable.isHidden = true
                }
                
                // users = sortUsersListByTime(usersArray: users)
                //onSuccess(sortedUserArray)
            }
            
        }

    }
    
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    @objc func openUserList(_ sender: UIButton) {
        let vc =  AllUsersVC.instantiate(fromAppStoryboard: .chatStoryboard)
        pushToVC(vc, animated: true)
        
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


extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}

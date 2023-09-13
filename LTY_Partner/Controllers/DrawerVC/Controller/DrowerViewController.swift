//
//  DrowerViewController.swift
//  LTY_Partner
//
//  Created by CTS on 17/05/23.
//

import UIKit
import SDWebImage

struct LogoutModel :Codable {
    let status: String?
    let data: LogoutData?
    let error: LogoutError?
}

struct LogoutData:Codable {
    let signedOut: Bool?
}

struct LogoutError: Codable {
    var errorCode: String?
    var serverErrorMessage: String?
    var clientErrorMessage: String?
    var clientErrorMessageInFrench: String?
}


class DrowerViewController: UIViewController {
    
    //MARK:- Variables
    //var window: UIWindow?
    var data = [LTYText.textDrower_Dashboard.localized(),LTYText.textDrower_Category.localized(),LTYText.textDrower_Agents.localized(),LTYText.textDrower_Customers.localized(),LTYText.textDrower_Manage_Proposal.localized(),LTYText.textDrower_Financial_Statements.localized(),LTYText.textDrower_Letter_Managements.localized(),LTYText.textDrower_Leads.localized(),LTYText.textDrower_Submissions.localized(),LTYText.textDrower_Rules_Access.localized(),LTYText.textDrower_Search_Cover.localized(),LTYText.textDrower_Message.localized(),LTYText.textDrower_Agenda.localized(),LTYText.textDrower_Language.localized(),"Delete Account".localized()]
    
    var images = [Asset.Assets.dashboard.image,Asset.Assets.category.image,Asset.Assets.agents.image,Asset.Assets.customer.image,Asset.Assets.manage_Proposal.image,Asset.Assets.financial_Statements.image,Asset.Assets.letter_Managements.image,Asset.Assets.leads.image,Asset.Assets.submissions.image,Asset.Assets.rules_Access.image,Asset.Assets.search_Cover.image,Asset.Assets.message.image,Asset.Assets.agenda.image,Asset.Assets.Select_Language.image,Asset.Assets.deleteDashboard.image]
    
    var agentData = [LTYText.textDrower_Dashboard.localized(),LTYText.textDrower_Commission.localized(),LTYText.textDrower_Customers.localized(),LTYText.textDrower_Manage_Proposal.localized(),LTYText.textDrower_Financial_Statements.localized(),LTYText.textDrower_Letter_Managements.localized(),LTYText.textDrower_Leads.localized(),LTYText.textDrower_Submissions.localized(),LTYText.textDrower_Search_Cover.localized(),LTYText.textDrower_Message.localized(),LTYText.textDrower_Agenda.localized(),LTYText.textDrower_Language.localized(),"Delete Account".localized()]
    
    var agentImages = [Asset.Assets.dashboard.image,Asset.Assets.dashboard.image,Asset.Assets.customer.image,Asset.Assets.manage_Proposal.image,Asset.Assets.financial_Statements.image,Asset.Assets.letter_Managements.image,Asset.Assets.leads.image,Asset.Assets.submissions.image,Asset.Assets.search_Cover.image,Asset.Assets.message.image,Asset.Assets.agenda.image,Asset.Assets.Select_Language.image,Asset.Assets.deleteDashboard.image]
    
    
    let userType = kUserDefaults.object(forKey: "userType")
    
    var picker = UIImagePickerController()
    var pickedImageUrl:URL?
    //MARK:- Outlets
    
    @IBOutlet var drowerTableView: UITableView!
    
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        

    } // END didload func
    
    override func viewWillAppear(_ animated: Bool) {
        setUpHeaderView()
        setUpTableView()
        setUpFooterView()
    }
    
    //MARK:- setUp tableview
    
    func setUpTableView() {
        
        drowerTableView.delegate = self
        drowerTableView.dataSource = self
        drowerTableView.separatorStyle = .none
        drowerTableView.showsVerticalScrollIndicator = false
        drowerTableView.register(UINib(nibName: "DrowerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "DrowerTableViewCell")
    }
    
    //MARK:- Setup HeaderView
    
    func setUpHeaderView(){
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.drowerTableView.frame.width,
                                              height: 100))
        headerView.backgroundColor = Asset.Colors.whiteColor.color
        self.drowerTableView.tableHeaderView = headerView
        
        // Add image
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 10, y: 10, width: 60, height: 60))
        
        if  let userImage = kUserDefaults.value(forKey: AppKeys.profile) {
            imageView.sd_setImage(with: URL(string:userImage as! String), placeholderImage: UIImage(named: "user"))

        }else{
            imageView.image  = UIImage(named: "user")

        }
      
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        headerView.addSubview(imageView)
        
        let name:UILabel = UILabel(frame: CGRect(x: imageView.frame.width + 23, y: imageView.frame.height - 50, width: headerView.frame.width - 95, height: 25))
        
        let userName = kUserDefaults.value(forKey: AppKeys.agentName)
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        let companyName = kUserDefaults.value(forKey: AppKeys.companyName)
        if userType == "PARTNER"{
            name.text = companyName as? String
        }else{
            name.text = userName as? String
        }

        name.textAlignment = .left
        name.font = FontSize.size20
        name.textColor = Asset.Colors.gray1.color
        headerView.addSubview(name)
        
        let attrs = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0),
            NSAttributedString.Key.foregroundColor : Asset.Colors.blueColor.color,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        
        let attributedString = NSMutableAttributedString(string:"")

        
        let viewProfileBtn:UIButton = UIButton(frame: CGRect(x: imageView.frame.width + 23, y:  imageView.frame.height - 20, width: headerView.frame.width - 95, height: 18))

        let buttonTitleStr = NSMutableAttributedString(string:LTYText.textDrower_ViewProfile.localized(), attributes:attrs)
        attributedString.append(buttonTitleStr)
        viewProfileBtn.setAttributedTitle(attributedString, for: .normal)
        viewProfileBtn.contentHorizontalAlignment = .left
        viewProfileBtn.addTarget(self, action: #selector(viewProileButton(_: )), for: UIControl.Event.touchUpInside)
        headerView.addSubview(viewProfileBtn)

        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 99.5, width: drowerTableView.frame.width, height: 0.5))
        label.backgroundColor = Asset.Colors.gray1.color
        headerView.addSubview(label)
        
    }
    
    @objc func viewProileButton(_ sender: UIButton) {
         let vc = ProfileVC.instantiate(fromAppStoryboard: .home)
         vc.isCommingFrom = "Profile"
         self.pushToVC(vc, animated: true)
         
     }
    //MARK:- SetUp footerView
    
    func setUpFooterView() {
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.drowerTableView.frame.width,
                                              height: 100))
        footerView.backgroundColor = Asset.Colors.whiteColor.color
        self.drowerTableView.tableFooterView = footerView
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 5, width: drowerTableView.frame.width, height: 0.5))
        label.backgroundColor = Asset.Colors.gray1.color
        footerView.addSubview(label)
        
        let logoutView :UIView = UIView(frame: CGRect(x: 0, y: 30, width: drowerTableView.frame.width, height: 50))
        logoutView.backgroundColor = .white
        
        var logoutImageView : UIImageView
        logoutImageView  = UIImageView(frame:CGRect(x: 20, y:logoutView.frame.height - 40, width: 30, height: 30))
        logoutImageView.image = Asset.Assets.logout.image
        logoutImageView.layer.masksToBounds = false
        logoutImageView.clipsToBounds = true
        logoutView.addSubview(logoutImageView)
        
        let logoutLabel:UILabel = UILabel(frame: CGRect(x: logoutImageView.frame.width + 30, y: logoutView.frame.height - 40, width: 200, height: 25))
        logoutLabel.text = "Logout".localized()
        let tapTOLogout = UITapGestureRecognizer(target: self, action:#selector(logOut(_: )))
        logoutView.addGestureRecognizer(tapTOLogout)
        logoutView.isUserInteractionEnabled = true

        logoutView.addSubview(logoutLabel)
        
        
        footerView.addSubview(logoutView)
        
    }
    
    @objc func logOut(_ sender: UITapGestureRecognizer) {
       // switchWelcomeVc()
        //setupAppropriateScreen()
        showSimpleAlert()
    }
 
    func logoutApi(_ hardSignOut: Bool) {
        let token = kUserDefaults.value(forKey: "token")
        let param :[String:Any] = ["token":token as! String,"hardSignOut":hardSignOut]
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_PARTNER + LTY_END_POINT_URL.signOut, method: "POST", passToken: false, expecting: LogoutModel.self, dataDict: param) { response in
            
            print(response)
            switch response {
            case .success(let result) :
               print(result)
                
                if result.status == "SUCCESS" {
                    if result.data?.signedOut == true {
                        DispatchQueue.main.async {
                            self.setupAppropriateScreen()
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        if result.error?.errorCode == AppKeys.invalidTokenCode {
                            
                            LTY_AppDelegate.setRootVC()
                        }else {
                            self.ShowAlert(message: result.error?.serverErrorMessage ?? "")
                        }
                    }
                }
            case .failure(let error) :
                print(error)
                
            }
        }
    }
    
    
    //MARK:- func go to Welcome Screen
 /*
    func switchWelcomeVc() {
        kUserDefaults.removeObject(forKey: "token")
        kUserDefaults.removeObject(forKey: "partnerID")
        kUserDefaults.removeObject(forKey: "userType")
        kUserDefaults.removeObject(forKey: "state")


        let vc = WelcomeScreenVC.instantiate(fromAppStoryboard:.main)
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        //self.window?.rootViewController = navVC
    }
    */
    func showSimpleAlert() {
        let alert = UIAlertController(title:"Alert".localized(), message: "Logout ?".localized(),  preferredStyle: UIAlertController.Style.alert)
        
        
//        alert.addAction(UIAlertAction(title: "Yes".localized().localized(), style: UIAlertAction.Style.default, handler: { _ in
//            self.dismiss(animated: true)
//        }))
        
        alert.addAction(UIAlertAction(title:"Logout from all devices.".localized(),
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
//            self.setupAppropriateScreen()
            self.logoutApi(true)
        }))
        
        alert.addAction(UIAlertAction(title: "Logout from this device only.".localized().localized(), style: UIAlertAction.Style.default, handler: { _ in
            self.logoutApi(false)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized().localized(), style: UIAlertAction.Style.cancel, handler: { _ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func setupAppropriateScreen() {

        kUserDefaults.removeObject(forKey: AppKeys.state)
       // kUserDefaults.removeObject(forKey: AppKeys.token)
        kUserDefaults.set("Invalid", forKey: AppKeys.token)
        kUserDefaults.removeObject(forKey: AppKeys.email)
        kUserDefaults.removeObject(forKey: AppKeys.sourceId)
        kUserDefaults.removeObject(forKey: AppKeys.roleList)
        kUserDefaults.removeObject(forKey: AppKeys.password)
        kUserDefaults.removeObject(forKey: AppKeys.partnerID)
        kUserDefaults.removeObject(forKey: AppKeys.agentName)
        kUserDefaults.removeObject(forKey: AppKeys.totalNotification)
        
        let vc = LoginVC.instantiate(fromAppStoryboard: .main)
        let nc = SwipeableNavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 13.0, *) {
            
            UIApplication.shared.windows.first?.rootViewController = nc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            let bounds = UIScreen.main.bounds
            LTY_AppDelegate.window = UIWindow(frame: bounds)
            LTY_AppDelegate.window?.rootViewController = nc
            LTY_AppDelegate.window?.makeKeyAndVisible()
        }
        
    }
    
    
    @IBAction func hideDroweronclickActionBtn(_ sender: Any) {
        
    hideDrower()
        
    }  // END hide drower on button click in swift
    
    func hideDrower() {
        showNavDrower = false
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
}

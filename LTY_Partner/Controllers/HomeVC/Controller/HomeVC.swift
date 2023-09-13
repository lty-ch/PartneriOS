//
//  HomeVC.swift
//  LTY_Partner
//
//  Created by CTS on 17/05/23.
//

import UIKit
import LocalAuthentication


struct Categories {
    
    var categoryType:CategoryType = .movies
    var categoeyData:[AnyObject] = []
    var categoeyData1:[String] = []
    var categoryName:String = ""
    var loadSection:Bool = false
    
}

enum CategoryType {
    case sports
    case news
    case movies
    case travel
    case politics
}


class HomeVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var customNavigationBarForDrawer: CustomNavigationBarForDrawer!
    @IBOutlet weak var mainView: UIView!
    
    // signUpView outlets
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var signContView: UIView!
    @IBOutlet weak var labelSignContDate: UILabel!
    @IBOutlet weak var labelTitleSignCont: UILabel!
    @IBOutlet weak var imageSignContract: UIImageView!
    @IBOutlet weak var signContImageHeaderView: UIView!
    @IBOutlet weak var imageSignContArrow: UIImageView!
    @IBOutlet weak var CollectionViewHomeVc: UICollectionView!
    @IBOutlet weak var labelSignContPercentage: UILabel!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    // registerView outlets
    
    @IBOutlet weak var regCustView: UIView!
    @IBOutlet weak var regCustDateView: UIView!
    @IBOutlet weak var imageRegUser: UIImageView!
    @IBOutlet weak var labelregCustDate: UILabel!
    @IBOutlet weak var labelRegCustTitle: UILabel!
    @IBOutlet weak var imageRegCustArrow: UIImageView!
    @IBOutlet weak var regCustImageHeaderView: UIView!
    @IBOutlet weak var labelRegCustPercentage: UILabel!
    
    @IBOutlet weak var hometablHeight: NSLayoutConstraint!
    
    var categories = [Categories]()
    var leadListViewModel = LeadListViewModel()
    var leadListArr = [LeadList]()
    var proposalVM = ProposalViewModel()
    var expiredLisArr = [SubmissionProposalsList]()
    var agendaViewModel = AgendaViewModel()
    var agendaListArr = [AgendaList]()
    
    var notificationListArr = [NotificationList]()
    var notificationViewModel = NotificationViewModel()

    var homeVcViewModel = HomeVCViewModel()
    
    var reloadAgendaListDelegate :ReloadAgendaListDelegate?
    var shouldActivateFaceId = false
    let context = LAContext()
    
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavDrower = false
        notificationViewModel.delegate = self
        
        self.tabBarController?.tabBar.isHidden = true
     
        self.customNavigationBarForDrawer.isHidden = true
        if kUserDefaults.bool(forKey: AppKeys.shouldActivateFaceId) {
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // Biometric authentication is available
                //            self.ShowAlert(message: "Authentication Available")
                let reason = "Authenticate using Touch ID"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                    if success {
                        DispatchQueue.main.async {
                            self.authView.isHidden = true
                            self.tabBarController?.tabBar.isHidden = false
                            self.customNavigationBarForDrawer.isHidden = false
                        }
                        
                    } else {
                        // Authentication failed or was canceled by the user
                        DispatchQueue.main.async {
                            self.authView.isHidden = false
                            self.tabBarController?.tabBar.isHidden = true
                            self.customNavigationBarForDrawer.isHidden = true
                        }
                    }
                }
            } else {
                // Biometric authentication is not available
                //                self.ShowAlert(message: "Authentication Not available")
                self.authView.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
                self.customNavigationBarForDrawer.isHidden = false
            }
            
        } else {
            DispatchQueue.main.async {
                self.authView.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
                self.customNavigationBarForDrawer.isHidden = false
                
            }
        }
        
        setUpView()
        setUpCollection()
        setDrowerHeight()
        callApiinDispatchGrp()
        
        leadListViewModel.delegate = self
        proposalVM.expireDelegate = self
        agendaViewModel.delegate = self
        homeVcViewModel.delegate = self
        
        //Add observer for update mobile and email
        NotificationCenter.default.addObserver(self, selector: #selector(handlesNotification(_:)), name: NSNotification.Name(rawValue: "CallAgendaApiDashborad"), object: nil)
        
    }
    
    
    
    @objc func handlesNotification(_ sender: Notification) {
        
        let senderData = sender.userInfo
        if let data = senderData as? [String: String] {
            
            let dataEmail = data["CallApi"]
            
            
            if dataEmail != nil{
                //callApiinDispatchGrp()
                getAppoinmentsApi()
                
            }
            
        }
    }
    
    func callApiinDispatchGrp(){
        
        categories.removeAll()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getAppoinmentsApi()
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        ApiCallingFunc(status:"PENDING")
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        proposalListApiCall(state:"", withInMonth: 0)
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        proposalListApiCall(state:"", withInMonth: 3)
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        getdashboardDataApi()
        dispatchGroup.leave()
        
//        dispatchGroup.enter()
//        getNotificationApi()
//        dispatchGroup.leave()

        
        dispatchGroup.notify(queue: .main) {
            print("success")
            self.homeTableView.reloadData()
        }
        
    }
    
    func getdashboardDataApi () {
        print("success1")
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        
        let param :[String:Any] = [ "entityType": entityType, "entityId": partnerID, "days": 10]
        homeVcViewModel.dashboardInfoApi(param: param)
        
    }
    
    
    func getAppoinmentsApi () {
        print("success2")
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let param :[String:Any] = [ "entityType": entityType, "entityId": partnerID, "pageSize": 3, "pageCount": 1]
        agendaViewModel.agendaListApi(param: param)
        
    }
    
    func getNotificationApi(){
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let param : [String:Any] = ["userId":partnerId]
        notificationViewModel.notificationListApi(param: param)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        kUserDefaults.set("home", forKey: AppKeys.tabName)
        self.homeTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        getNotificationApi()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.homeTableView.removeObserver(self, forKeyPath: "contentSize")
        
        if showNavDrower == true {
            showNavDrower = false
            
        }
        
    }

    @IBAction func onClickDashboradBtn(_ sender: UIButton) {
        if sender.tag == 101 {
            let vc = SubmissionListVC.instantiate(fromAppStoryboard: .submissionStoryboard)
            vc.pageSize = Int(self.labelSignContDate.text!)!
            pushToVC(vc, animated: true)
        }else{
            let vc = CustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
            vc.pageSize = Int(self.labelregCustDate.text!)!
            pushToVC(vc, animated: true)
        }
    }
    
    //MARK:- Api call func
    
    func proposalListApiCall(state:String, withInMonth: Int) {
        print("success3")
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
        let param:[String: Any] = ["entityType": entityType,"entityId": partnerId, "expiringWithinMonth": withInMonth, "pageSize": 3, "pageCount": 1]
        
        proposalVM.expiredProposalListApi(param: param, withInMonth: withInMonth)
    }
    
    //MARK:- Api call func
    
    func ApiCallingFunc(status:String) {
        print("success4")
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerID = kUserDefaults.value(forKey: "partnerID")
        let param: [String : Any] = [ "entityType": entityType, "entityId": partnerID as Any, "status": status, "pageSize": 3, "pageCount": 1]
        
        
        leadListViewModel.leadListApiCall(param:param)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        hometablHeight.constant = homeTableView.contentSize.height
        homeTableView.reloadData()
        
    }
    /*
     override func viewWillAppear(_ animated: Bool) {
     let partnerID = kUserDefaults.value(forKey: "partnerID")
     let param : [String:Any] = ["userId":partnerID,]
     self.getUserRoleApi(param: param)
     }
     
     //MARK:- Check UserRole Api
     
     
     func getUserRoleApi(param:[String:Any]) {
     SwiftLoader.show(animated: true)
     
     Services.shareInstance.postRequestApi(url:LTY_BASE_URL.BASE_URL_ROLES + LTY_END_POINT_URL.getUserRole, method: "POST", passToken: true, expecting:RoleDetailModel.self, dataDict: param) { response in
     
     print(response)
     switch response {
     
     case .success(let result):
     SwiftLoader.hide()
     
     DispatchQueue.main.async {
     //  self.delegate?.setAllRolesData(data: result)
     
     }
     
     case .failure(let error):
     SwiftLoader.hide()
     DispatchQueue.main.async {
     
     
     //self.delegate?.popupMsg(msg:error.localizedDescription)
     
     }
     }
     
     }
     
     }
     */
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    
    //MARK:- SetUp CollectionView
    
    func setUpCollection() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.register(UINib(nibName: "HomeTVC", bundle: .main), forCellReuseIdentifier: "HomeTVC")
        homeTableView.register(UINib(nibName: "HomeInsuranceTVC", bundle: .main), forCellReuseIdentifier: "HomeInsuranceTVC")
        homeTableView.register(UINib(nibName: "HomeExpiringTVC", bundle: .main), forCellReuseIdentifier: "HomeExpiringTVC")
        
        let headerNib = UINib(nibName: "HomeHeaderView", bundle: .main)
        let footerNib = UINib(nibName: "HomeFooterView", bundle: .main)
        homeTableView.register(footerNib, forHeaderFooterViewReuseIdentifier: "HomeFooterView")
        homeTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HomeHeaderView")
        
        
        
    }
    //MARK:- setUpView
    
    func setUpView() {
        
        customNavigationBarForDrawer.titleLabel.text = LTYText.textHomeVC_Title.localized()
        customNavigationBarForDrawer.leftSideMenuButtonItem.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        
        mainView.viewCorner(8)
        imageRegCustArrow.image = Asset.Assets.arrowUp.image
        imageRegUser.image = Asset.Assets.customer.image
        imageSignContArrow.image = Asset.Assets.arrowUp.image
        imageSignContract.image = Asset.Assets.contract.image
        
        
        
        dateView.viewCorner(10)
        regCustView.viewCorner(8)
        signContView.viewCorner(8)
        regCustDateView.viewCorner(10)
        regCustImageHeaderView.viewCorner(6)
        signContImageHeaderView.viewCorner(6)
        
        dateView.backgroundColor = Asset.Colors.redColor.color
        regCustView.backgroundColor = Asset.Colors.lightPurple.color
        signContView.backgroundColor = Asset.Colors.lightSkyBlue.color
        regCustDateView.backgroundColor = Asset.Colors.greenColor.color
        regCustImageHeaderView.backgroundColor = Asset.Colors.meduimPurpleColor.color
        signContImageHeaderView.backgroundColor = Asset.Colors.mediumSkybluColor.color
        
        
        
        labelregCustDate.font = FontSize.size24
        labelSignContDate.font = FontSize.size24
        labelRegCustTitle.font = FontSize.size12
        labelTitleSignCont.font = FontSize.size12
        labelRegCustPercentage.font = FontSize.size12
        labelSignContPercentage.font = FontSize.size12
        
        labelregCustDate.text = "04"
        labelSignContDate.text = "12"
        labelRegCustPercentage.text = "1.5 %"
        labelSignContPercentage.text = "0.2 %"
        labelTitleSignCont.text = LTYText.textHomeVC_New_Signed_Contract.localized()
        labelRegCustTitle.text = LTYText.textHomeVC_New_Registered_customers.localized()
        
        labelregCustDate.textColor = Asset.Colors.meduimPurpleColor.color
        labelRegCustPercentage.textColor = Asset.Colors.whiteColor.color
        labelSignContPercentage.textColor = Asset.Colors.whiteColor.color
        labelSignContDate.textColor = Asset.Colors.blueColor.color
        
        
        if kUserDefaults.bool(forKey: AppKeys.isDefaultPasswordSet) {
            let vc = ChangePasswordVC.instantiate(fromAppStoryboard: .main)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    @objc func didTapMenuButton (_ sender:UIButton) {
        
        if showNavDrower == false {
            let menuVC =  DrowerViewController.instantiate(fromAppStoryboard: .home)
            showNavDrower = true
            //self.storyboard?.instantiateViewController(withIdentifier: "DrowerViewController") as! DrowerViewController
            
            self.view.addSubview(menuVC.view)
            self.addChild(menuVC)
            menuVC.view.layoutIfNeeded()
            menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width - 100, y: 0, width: UIScreen.main.bounds.size.width - 100, height: UIScreen.main.bounds.size.height);
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height);
            }, completion:nil)
            self.navigationController?.navigationBar.isHidden = true
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.hometablHeight.constant = newsize.height
            }
        }
        
    }
    
    
}

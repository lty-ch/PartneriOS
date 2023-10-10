//
//  NotificationVC.swift
//  LTY_Partner
//
//  Created by CTS on 18/05/23.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var notifiacationTable: UITableView!
    

    var notificationListArr = [NotificationList]()
    var notificationViewModel = NotificationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
    
        notifiacationTable.delegate = self
        notifiacationTable.dataSource = self
        notificationViewModel.delegate = self
    
        notifiacationTable.register(UINib(nibName: "NotificationTVC", bundle: .main), forCellReuseIdentifier: "NotificationTVC")
        
        customNavDrower.titleLabel.text = "Notifications".localized()
        customNavDrower.titleLabel.textAlignment = .center
        //customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.menu.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(didTapMenuButton(_:)), for: .touchUpInside)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let param : [String:Any] = ["userId":partnerId]
        notificationViewModel.notificationListApi(param: param)
        
        DispatchQueue.main.async {
            if let tabItems = self.tabBarController?.tabBar.items {
                // In this case we want to modify the badge number of the third tab:
                let tabItem = tabItems[1]
                tabItem.badgeValue = nil
            }
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if showNavDrower == true {
            showNavDrower = false

        }
    }
    
    @objc func didTapMenuButton (_ sender: UIButton) {
        
        if showNavDrower == false {
            
            let menuVC =  DrowerViewController.instantiate(fromAppStoryboard: .home)
            showNavDrower = true
            
            //self.storyboard?.instantiateViewController(withIdentifier: "DrowerViewController") as! DrowerViewController
            
            self.view.addSubview(menuVC.view)
            self.addChild(menuVC)
            menuVC.view.layoutIfNeeded()
            menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width - 100, y: 0, width: UIScreen.main.bounds.size.width - 100, height: UIScreen.main.bounds.size.height);
            
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height);
            }, completion:nil)
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
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

extension NotificationVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notifiacationTable.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as! NotificationTVC
        let info = notificationListArr[indexPath.row]
        cell.lblTitle.text = info.title ?? ""
        cell.lblDiscription.text = info.body ?? ""
        
    /*
        var createdDate = "\(info.createdOn ?? "")"
        createdDate = createdDate.components(separatedBy: "T")[0]
        cell.lblDate.text = returnDOB(date: createdDate)
        
        var createdTime = "\(info.createdOn ?? "")"
        createdTime = createdTime.components(separatedBy: "T")[1]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "H:mm:ss"
        if let inDate = dateFormatter.date(from: createdTime) {
            dateFormatter.dateFormat = "h:mm a"
            let outTime = dateFormatter.string(from:inDate)
            //print("in \(time)")
           // print("out \(outTime)")
            cell.lblTime.text = "\(outTime)"
          //  arrayTimes[index] = outTime
        }
        */
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deep_link
        let info = notificationListArr[indexPath.row]
        
        if info.deep_link == "LEAD"{
            
            let vc = LeadListVC.instantiate(fromAppStoryboard: .leadStoryboard)
            self.pushToVC(vc, animated: true)
            
        } else if info.deep_link == "PROPOSAL"{
            
            let vc = ProposalVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            self.pushToVC(vc, animated: true)
            
        } else if info.deep_link == "PROFILE"{
            
            let vc = ProfileVC.instantiate(fromAppStoryboard: .home)
            vc.isCommingFrom = "Notification"
            self.pushToVC(vc, animated: true)
            
        }else if info.deep_link == "USER"{
            
            let vc = CustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
            self.pushToVC(vc, animated: true)
            
        }

    }
}

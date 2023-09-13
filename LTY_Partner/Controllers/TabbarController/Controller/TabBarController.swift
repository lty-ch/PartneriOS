//
//  TabBarController.swift
//  LTY_Partner
//
//  Created by CTS on 18/05/23.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: Properties
    
    var homeBtn : UITabBarItem!
    var searchBtn : UITabBarItem!
    var profileBtn : UITabBarItem!
    var notifcationBtn : UITabBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = Asset.Colors.blueColor.color
        self.tabBar.makeSpecificCornerRound(corners: .topTwo, radius: 20)
        UITabBar.appearance().unselectedItemTintColor = Asset.Colors.darkGrayColor.color
       // UITabBar.appearance().selectedImageTintColor = Asset.Colors.blueColor.color

       // setUpTabController()
    
    setUpTabbarNavigation()
}

    
    func setUpTabController () {
        
     
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 6/255.0, green: 159/255.0, blue: 190/255.0, alpha: 1.0)
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            
            
            self.tabBarController?.tabBar.standardAppearance = appearance
            // Update for iOS 15, Xcode 13
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
            }
        }
        
    }
override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    setShadow()
}


// MARK: -  set Tabbar Navigation

    private func setUpTabbarNavigation() {
        
        homeBtn = UITabBarItem()
        searchBtn = UITabBarItem()
        profileBtn = UITabBarItem()
        notifcationBtn = UITabBarItem()
        
        setUpTabBarElements()
        
        //MARK: set controller  in tabbar button
  
        let VC1 = HomeVC.instantiate(fromAppStoryboard: .home)
        let nav1 = SwipeableNavigationController(rootViewController: VC1)
        nav1.isNavigationBarHidden = true
        
//        let VC2 = SearchVC.instantiate(fromAppStoryboard: .home)
//        let nav2 = SwipeableNavigationController(rootViewController: VC2)
//        nav2.isNavigationBarHidden = true
        
        let VC3 = NotificationVC.instantiate(fromAppStoryboard: .home)
        // VC3.hidesBottomBarWhenPushed = true
        let nav3 = SwipeableNavigationController(rootViewController: VC3)
        nav3.isNavigationBarHidden = true
        
        let VC4 = ProfileVC.instantiate(fromAppStoryboard: .home)
        let nav4 = SwipeableNavigationController(rootViewController: VC4)
        nav4.isNavigationBarHidden = true
        
        VC1.tabBarItem = homeBtn
        VC4.tabBarItem =  profileBtn
        VC3.tabBarItem = notifcationBtn
       // VC2.tabBarItem = searchBtn
        
        let viewControllers = [nav1,nav3,nav4] //[nav1, nav2, nav3,nav4]
        
        
        self.viewControllers = viewControllers
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
    }

// MARK: - Tabbar Elemements / Like as image and name

private func setUpTabBarElements() {
    
    self.homeBtn.imageInsets = UIEdgeInsets(top:0, left:0, bottom: 0, right: 0)
  //  self.searchBtn.imageInsets = UIEdgeInsets(top:0, left:0, bottom: 0, right: 0)
    self.profileBtn.imageInsets = UIEdgeInsets(top:0, left:0, bottom: 0, right: 0)
    self.notifcationBtn.imageInsets = UIEdgeInsets(top:0, left:0, bottom: 0, right: 0)

    
    self.homeBtn.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
   // self.searchBtn.image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
    self.profileBtn.image = UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate)
    self.notifcationBtn.image = UIImage(named: "notification")?.withRenderingMode(.alwaysTemplate)
   
    
    self.homeBtn.selectedImage = UIImage(named: "home1")?.withRenderingMode(.alwaysOriginal)
   // self.searchBtn.selectedImage = UIImage(named: "search1")?.withRenderingMode(.alwaysOriginal)
    self.profileBtn.selectedImage = UIImage(named: "profile1")?.withRenderingMode(.alwaysOriginal)
    self.notifcationBtn.selectedImage = UIImage(named: "notification1")?.withRenderingMode(.alwaysOriginal)
    
    self.homeBtn.title = "Home".localized()
    //self.searchBtn.title = "Search".localized()
    self.profileBtn.title = "Profile".localized()
    self.notifcationBtn.title = "Notification".localized()
    
}
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print(item.tag)
//        
//    }
//MARK: should select func in tabbar controller

//func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//
//    guard let allVC = (viewController as? UINavigationController)?.viewControllers else{
//        return true
//    }
//    for vc in allVC{
//
//        if vc.isKind(of: AddRequestDetailMainContainerVc.self){
//            let vc = AddRequestDetailMainContainerVc.instantiate(fromAppStoryboard: .staffProfile)
//            vc.hidesBottomBarWhenPushed = true
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overCurrentContext
//            (viewController as? UINavigationController)?.tabBarController?.present(vc, animated: true)
//            return false
//        }
//    }
//
//    return true
//}

//MARK: FOR TAB BAR SHADOW AND CORNER

func setShadow(){
    
    if tabBar.viewWithTag(200) != nil{
        return
    }
    
    var height = 0.0
    var width = 0.0
    if UIDevice.hasNotch{
        height = tabBar.frame.height * 1
        width = tabBar.frame.width * 1
    }
    else{
        
        height = tabBar.frame.height * 1
        width = tabBar.frame.width * 1
    }
    
    let x = (tabBar.frame.width - width) / 2
    tabBar.clipsToBounds = false
    tabBar.shadowImage = UIImage()
    tabBar.backgroundImage = UIImage()
    tabBar.backgroundColor = Asset.Colors.mediumWhite.color
    
    let tabGradientView = UIView(frame: CGRect(x: x, y: 0, width: width, height: height))
    tabGradientView.tag = 200
    tabGradientView.layer.cornerRadius = 25
    tabGradientView.layer.shadowRadius = 4.0
    tabGradientView.layer.shadowOpacity = 0.6
    
    tabGradientView.layer.shadowColor = UIColor.gray.cgColor
    //tabGradientView.backgroundColor = Asset.Colors.lightPurple.color//UIColor.white
    tabGradientView.translatesAutoresizingMaskIntoConstraints = false;
    // tabGradientView.layer.cornerRadius = tabGradientView.frame.height / 2
    tabGradientView.layer.shadowOffset = CGSize(width: 0, height: 0)
    tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tabGradientView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    tabBar.addSubview(tabGradientView)
    // tabGradientView.center = tabBar.center
    tabBar.sendSubviewToBack(tabGradientView)
}

}

extension UIDevice {
    
    static var hasNotch: Bool {
        
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}

//
//  AgentCommissionVC.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import UIKit

class AgentCommissionVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var labelCommesion: UILabel!
    @IBOutlet weak var commisionView: UIView!

    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var agentCommissionTableView: UITableView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavigationBar: CustomNavigationBarForDrawer!
    
    //MARK:- Variables
    var agentId = ""
    var agentCommissionList = [AgentCommissionDetailList]()
     var agentCommissionViewModel = AgentCommissionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDrowerHeight()
        setUpTableView()
        setUpView()
        agentCommissionViewModel.delegate = self

        customNavigationBar.titleLabel.text = "Commission List".localized()
        customNavigationBar.titleLabel.textAlignment = .center
        customNavigationBar.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigationBar.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
    }
    //MARK:- back Action btn
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        checkConnection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
  
    // MARK:- setUpView
    
    func setUpView() {
        commisionView.viewCorner(6)
        
        labelCommesion.font = FontSize.size14
        labelCommesion.textColor = Asset.Colors.lightBlue.color
        labelCommesion.text = "Manage Commissions".localized()
        
        
        commisionView.backgroundColor = Asset.Colors.lightSkyBlue.color


    }
    
    //MARK:- check InternetConnection
    
    func checkConnection() {
        if internetConnection.isConnectedToNetwork() == true {
         
            let param :[String:Any] = ["agentId":agentId ]
            agentCommissionViewModel.agentCommissionListApi(param: param)
        }
        else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
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
    
    //MARK:- SetUp TabelView
    
    func setUpTableView() {
        agentCommissionTableView.delegate = self
        agentCommissionTableView.dataSource = self
        agentCommissionTableView.separatorStyle = .none
        agentCommissionTableView.backgroundColor = Asset.Colors.mediumWhite.color
        agentCommissionTableView.register(UINib(nibName: "AgentCommTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AgentCommTableViewCell") 
    }

    @IBAction func onClickManageCommission(_ sender: UIButton) {
        let vc = ManageCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
       // vc.agentListData = self.agentListData
        self.pushToVC(vc, animated: true)
    }
    
}

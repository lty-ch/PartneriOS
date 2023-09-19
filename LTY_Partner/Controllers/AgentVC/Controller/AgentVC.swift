//
//  AgentVC.swift
//  LTY_Partner
//
//  Created by CTS on 19/05/23.
//

import UIKit

class AgentVC: UIViewController, UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchCloseBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var AddNewView: UIView!
    @IBOutlet weak var labelAddNew: UILabel!
    @IBOutlet weak var tableViewAgentVC: UITableView!
    @IBOutlet weak var customNavigationBarForDrawer: CustomNavigationBar!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    
    //MARK:- Variables
    var timer = Timer()
    var blockStatus = ""
    var agentVCViewModel = AgentVCViewModel()
    var agentListData = [AgentsList]()
    var indexValue = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpView()
        setDrowerHeight()
        agentVCViewModel.delegate = self
       // self.searchTf.delegate = self
        self.searchTf.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addNewAgent(_:)))
        AddNewView.addGestureRecognizer(tap)
        AddNewView.isUserInteractionEnabled = true


    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            self.searchView.isHidden = false
            self.AddNewView.isHidden = true
            self.searchCloseBtn.isHidden = false
            self.searchBtn.isHidden = true
//            self.viewHeaderBar.isHidden = false

//            self.consSearchViewWidth.constant = 0

            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func onClickSearchClose(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            self.searchView.isHidden = true
            self.AddNewView.isHidden = false
            self.searchCloseBtn.isHidden = true
            self.searchBtn.isHidden = false
            self.searchTf.text = ""
//            self.viewHeaderBar.isHidden = false

//            self.consSearchViewWidth.constant = 0

            self.view.layoutIfNeeded()
        }
        if self.searchTf.text != "" {
            checkNetwork()
        }
        

    }

    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    
    
    //MARK:- Add New Agent
    
    @objc func addNewAgent(_ sender: UITapGestureRecognizer? = nil) {
        let vc = AddNewAgentVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
        self.pushToVC(vc, animated: true)
    }
    
    //MARK:- will apperar func
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        checkNetwork()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func checkNetwork(){
        let partnerId =  kUserDefaults.string(forKey: "partnerID")

        if internetConnection.isConnectedToNetwork() == true {
            
            let param :[String:Any]  = ["partnerId":partnerId,"searchBy":self.searchTf.text!]
           // checkNetwork(phoneOtp: "",emailOtp: "", param: param)
            
            agentVCViewModel.agentListApi(param: param)
        }
        else {
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert)

        }
    }
    //MARK:- SetUp TabelView
    
    func setUpTableView() {
        tableViewAgentVC.delegate = self
        tableViewAgentVC.dataSource = self
        tableViewAgentVC.separatorStyle = .none
        tableViewAgentVC.backgroundColor = Asset.Colors.mediumWhite.color
        tableViewAgentVC.register(UINib(nibName: "AgentTableCell", bundle: Bundle.main), forCellReuseIdentifier: "AgentTableCell")
    }
    
    // MARK:- setUpView
    
    func setUpView() {
        searchView.viewCorner(6)
        AddNewView.viewCorner(6)
        
        labelAddNew.font = FontSize.size14
        labelAddNew.textColor = Asset.Colors.whiteColor.color
        
        
        searchView.backgroundColor = Asset.Colors.grayColor.color
        AddNewView.backgroundColor = Asset.Colors.blueColor.color

        
        customNavigationBarForDrawer.titleLabel.text = "Agents".localized()
        customNavigationBarForDrawer.titleLabel.textAlignment = .center
        customNavigationBarForDrawer.leftBarButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigationBarForDrawer.leftBarButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

    }

    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    @IBAction func onClickManageCommission(_ sender: UIButton) {
        let vc = ManageCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
       // vc.agentListData = self.agentListData
        self.pushToVC(vc, animated: true)
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        checkNetwork()
//    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("searchText \(textField.text)")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.output), userInfo: textField.text, repeats: false)
    }
    
    @objc func output(){
        if timer.userInfo != nil {
            checkNetwork()
        }
        timer.invalidate()
    }


}

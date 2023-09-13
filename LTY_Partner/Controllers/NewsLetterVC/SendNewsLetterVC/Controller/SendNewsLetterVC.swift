//
//  SendNewsLetterVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 09/08/23.
//

import UIKit

class SendNewsLetterVC: UIViewController {
    
    @IBOutlet weak var newsLettterTableView: UITableView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
   var newLetterViewModel = NewLetterViewModel()
    var newsTemplateArr = [SendNewsLetterTemplateList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        setupTableView()
        newLetterViewModel.delegate = self
        customNavDrower.titleLabel.text = "News Letter Templates".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
    }
    
    func setupTableView(){
        
        newsLettterTableView.delegate = self
        newsLettterTableView.dataSource = self
        newsLettterTableView.separatorStyle = .none
       // newsLettterTableView.register(UINib(nibName: "NewsLetterTVC", bundle: .main), forCellReuseIdentifier: "NewsLetterTVC")
        newsLettterTableView.register(UINib(nibName: "SendLetterTVC", bundle: .main), forCellReuseIdentifier: "SendLetterTVC")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""

        let param:[String: Any] = ["entityType": entityType,"entityId": partnerId]
        
        newLetterViewModel.getNewTemplateApiCall(param: param)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
    
    @IBAction func AddNewTempLate(_ sender: UIButton) {
        let vc = AddNewTemplateVC.instantiate(fromAppStoryboard: .newsLetter)
        pushToVC(vc, animated: true)
    }
}

extension SendNewsLetterVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTemplateArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsLettterTableView.dequeueReusableCell(withIdentifier: "SendLetterTVC", for: indexPath) as! SendLetterTVC
        cell.selectionStyle = .none

        let info = newsTemplateArr[indexPath.row]
        cell.lblUserName.text = info.templateName
       
        cell.lblAgentName.text = info.partnerName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddNewTemplateVC.instantiate(fromAppStoryboard: .newsLetter)
        let info = newsTemplateArr[indexPath.row]
        
        vc.isComingFrom = "Edit"
        vc.tempId = info.templateId ?? ""
        pushToVC(vc, animated: true)
    }
    
    
}

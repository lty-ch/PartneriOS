//
//  EditAgentCommissionVC.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import UIKit

class EditAgentCommissionVC: UIViewController {

    // MARK:- Outlets
    
    @IBOutlet weak var labelSelectAgent: UILabel!
    @IBOutlet weak var labelCompReserve: UILabel!
    @IBOutlet weak var labelAgentReserve: UILabel!
    @IBOutlet weak var labelSelectSubCat: UILabel!
    @IBOutlet weak var labelselectCategory: UILabel!
    @IBOutlet weak var labelAgentCommission: UILabel!
    @IBOutlet weak var textCompReserve: CustomTextField!
    @IBOutlet weak var textSelectagent: CustomTextField!
    @IBOutlet weak var textAgentReserve: CustomTextField!
    @IBOutlet weak var textSelectSubCat: CustomTextField!
    @IBOutlet weak var textSelectCategory: CustomTextField!
    @IBOutlet weak var textAgentCommission: CustomTextField!
   
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK:- Variables
    var feedId = ""
    var editAgentCommViewModel = EditAgentCommViewModel()
    var editAgentCommissionData = [EditAgentCommissionModel]() // Add Data
    var editAgentCommListProtocolDelegate:EditAgentCommListProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUpView()
        SetData()
        setDrowerHeight()
        editAgentCommViewModel.delegate = self

        customNavDrower.titleLabel.text = " Edit Commission".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
     
    }
    
    // MARK:- func set Data
    func SetData () {
        for item in editAgentCommissionData{
            //textCompReserve.text = "\(String(describing: item.CompnyReserve ?? 0.0))"
            textSelectagent.text = "\(String(describing: item.agentName!))"
            textAgentReserve.text = "\(String(describing: item.agentReserve ?? 0.0))"
           // textSelectSubCat.text = "\(String(describing: item.subCategoryName!))"
            textSelectCategory.text = "\(String(describing: item.categoryName!))"
            textAgentCommission.text = "\(String(describing: item.agentCommission ?? 0.0))"
        }
     
        
    } // End set data func
    
    //MARK:- will apperar func
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- back Action btn
    
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
    //MARK:- SetUpView
    
    func SetUpView() {
        btnDone.viewCorner(8)
        
        textSelectagent.isUserInteractionEnabled = false
        textSelectSubCat.isUserInteractionEnabled = false
        textSelectCategory.isUserInteractionEnabled = false
        btnDone.backgroundColor = Asset.Colors.skyBlue.color

        textCompReserve.font = FontSize.size14
        textSelectagent.font = FontSize.size14
        textAgentReserve.font = FontSize.size14
        textSelectSubCat.font = FontSize.size14
        textSelectCategory.font = FontSize.size14
        textAgentCommission.font = FontSize.size14
        
        labelSelectAgent.font = FontSize.boldsize14
        labelCompReserve.font = FontSize.boldsize14
        labelAgentReserve.font = FontSize.boldsize14
        labelSelectSubCat.font = FontSize.boldsize14
        labelselectCategory.font = FontSize.boldsize14
        labelAgentCommission.font = FontSize.boldsize14
        
        textCompReserve.textColor = Asset.Colors.darkGrayColor.color
        textSelectagent.textColor = Asset.Colors.darkGrayColor.color
        textAgentReserve.textColor = Asset.Colors.darkGrayColor.color
        textSelectSubCat.textColor = Asset.Colors.darkGrayColor.color
        textSelectCategory.textColor = Asset.Colors.darkGrayColor.color
        textAgentCommission.textColor = Asset.Colors.darkGrayColor.color
        
        textCompReserve.backgroundColor = Asset.Colors.backGroundColor.color
        textSelectagent.backgroundColor = Asset.Colors.backGroundColor.color
        textAgentReserve.backgroundColor = Asset.Colors.backGroundColor.color
        textSelectSubCat.backgroundColor = Asset.Colors.backGroundColor.color
        textSelectCategory.backgroundColor = Asset.Colors.backGroundColor.color
        textAgentCommission.backgroundColor = Asset.Colors.backGroundColor.color

        labelSelectAgent.textColor = Asset.Colors.blackColor.color
        labelCompReserve.textColor = Asset.Colors.blackColor.color
        labelAgentReserve.textColor = Asset.Colors.blackColor.color
        labelSelectSubCat.textColor = Asset.Colors.blackColor.color
        labelselectCategory.textColor = Asset.Colors.blackColor.color
        labelAgentCommission.textColor = Asset.Colors.blackColor.color
        
        labelSelectAgent.text = LTYText.text_EditAgentComm_SelectAgent.localized()
        labelCompReserve.text = LTYText.text_EditAgentComm_Comp_Reserve.localized()
        labelselectCategory.text = LTYText.text_EditAgentComm_SelectCat.localized()
        labelAgentCommission.text = LTYText.text_EditAgentComm_AgentComm.localized()
        labelAgentReserve.text = LTYText.text_EditAgentComm_Agent_Reserve.localized()
        labelSelectSubCat.text = LTYText.text_EditAgentComm_Select_SubCat.localized()


    }
    
    func checkValidation() {
        let agentReserveComm = Int(textAgentReserve.text ?? "")
        let companyReserve = Int(textCompReserve.text ?? "")
        let  agentCommission = Int(textAgentCommission.text ?? "")
        /*
     //   if textAgentReserve.text != "" || textCompReserve.text != "" || textAgentCommission.text != "" {
            
        
        if agentReserveComm ?? 0 > 100 {
            self.ShowAlert(message: "agent Reserve should not be greater than 100".localized())
            return
        }
        
        else if companyReserve ?? 0 > 100 {
            self.ShowAlert(message: "company Reserve should not be greater than 100".localized())
            return
            
        }
        */
            if textAgentCommission.text != "" {

           if agentCommission ?? 0 > 100 {
                self.ShowAlert(message: "agent Commission should not be greater than 100".localized())
                return
                
            }
        }
        checkInternetConnection()
    }
    
//MARK:- Done ActionBtn
    
    @IBAction func btnDoneAction(_ sender: UIButton) {
        checkValidation()
    }
    
    //MARK:- Check Internet
    
    func checkInternetConnection() {
        if internetConnection.isConnectedToNetwork() == true{
            let token = kUserDefaults.value(forKey: "token")
            self.textCompReserve.text = ""
            
            let param:[String:Any] = ["feeId":feedId.self,"commissionDetails":["agentReserve":textAgentReserve.text,"companyReserve":textCompReserve.text,"agentCommission":textAgentCommission.text]]
            editAgentCommViewModel.updateCommissionListApi(param: param)
            
        }
        else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
        }
    }
    //MARK:- Cancel Action Btn
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.popVC(animated: true)

    }
    
}

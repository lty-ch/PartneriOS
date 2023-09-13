//
//  AddNewTemplateVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 09/08/23.
//

import UIKit

class AddNewTemplateVC: UIViewController {

    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    @IBOutlet weak var lblTitleTemplateName: UILabel!
    @IBOutlet weak var lblTitleTemplateSetting: UILabel!
    @IBOutlet weak var lblTitleTemplateTitle: UILabel!
    @IBOutlet weak var lblTitleSenderName: UILabel!
    @IBOutlet weak var lblTitleSenderEmail: UILabel!
    @IBOutlet weak var lblTitlepersonal: UILabel!
    @IBOutlet weak var lblTitlePFirstName: UILabel!
    @IBOutlet weak var lblTitlePLastName: UILabel!
    @IBOutlet weak var lblTitlePMobileNo: UILabel!
    @IBOutlet weak var lblTitlePEmail: UILabel!
    @IBOutlet weak var lblTitleComp: UILabel!
    @IBOutlet weak var lblCompanyTitle: UILabel!
    @IBOutlet weak var lblTitleCompAddress: UILabel!
    @IBOutlet weak var lblTitleCompMobile: UILabel!
    @IBOutlet weak var lblTitleCopywrite: UILabel!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var textTemplateName: UITextField!
    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var textTemplateTitle: UITextField!
    @IBOutlet weak var textTemplateSenderName: UITextField!
    @IBOutlet weak var textTemplatesenderEmail: UITextField!
    @IBOutlet weak var textPUserFirstName: UITextField!
    @IBOutlet weak var textPUserLastName: UITextField!
    @IBOutlet weak var textPUserMobile: UITextField!
    @IBOutlet weak var textPUserEmail: UITextField!
    @IBOutlet weak var textCompTitle: UITextField!
    @IBOutlet weak var textCompAddress: UITextField!
    @IBOutlet weak var textCompMobile: UITextField!
    @IBOutlet weak var textCompCopyWrite: UITextField!
    @IBOutlet weak var btnView: UIView!
    
    var isComingFrom = ""
    var tempId = ""
    
    var AddNewTempDict = [String:Any]()
    var addNewTemplateViewModel = AddNewTemplateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        addNewTemplateViewModel.delegate = self
        if isComingFrom == "Edit" {
            customNavDrower.titleLabel.text = "View News Template Details".localized()
        }else{
            customNavDrower.titleLabel.text = "Add New Template".localized()
        }
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        setUplocalization()
    }
    
    func setUplocalization(){
        self.lblTitleTemplateName .text = "Template  name".localized()
        self.lblTitleTemplateSetting .text = "Template settings".localized()
        self.lblTitleTemplateTitle .text = "Template title".localized()
        self.lblTitleSenderName .text = "Sender’s name".localized()
        self.lblTitleSenderEmail .text = "Sender’s email".localized()
        self.lblTitlepersonal .text = "Personalisation field".localized()
        self.lblTitlePFirstName .text = "First name".localized()
        self.lblTitlePLastName .text = "Last name".localized()
        self.lblTitlePMobileNo .text = "Mobile number".localized()
        self.lblTitlePEmail .text = "Email".localized()
        self.lblTitleComp .text = "Company field".localized()
        self.lblCompanyTitle .text = "Company title".localized()
        self.lblTitleCompAddress .text = "Address".localized()
        self.lblTitleCompMobile .text = "Mobile number".localized()
        self.lblTitleCopywrite .text = "Copy write".localized()
        btnAdd.setTitle("Add".localized(), for: .normal)
        btnCancel.setTitle("Cancel".localized(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        if isComingFrom == "Edit" {
            btnView.isHidden = true
            self.textTemplateName.isUserInteractionEnabled = false
            self.textContent.isUserInteractionEnabled = false
            self.textTemplateTitle.isUserInteractionEnabled = false
            self.textTemplateSenderName.isUserInteractionEnabled = false
            self.textTemplatesenderEmail.isUserInteractionEnabled = false
            self.textPUserFirstName.isUserInteractionEnabled = false
            self.textPUserLastName.isUserInteractionEnabled = false
            self.textPUserMobile.isUserInteractionEnabled = false
            self.textPUserEmail.isUserInteractionEnabled = false
            self.textCompTitle.isUserInteractionEnabled = false
            self.textCompAddress.isUserInteractionEnabled = false
            self.textCompMobile.isUserInteractionEnabled = false
            self.textCompCopyWrite.isUserInteractionEnabled = false
            let param : [String:Any] = ["templateId":tempId]
            addNewTemplateViewModel.getTempDetailsApiCall(param: param)
        }else{
            btnView.isHidden = false
            self.textTemplateName.isUserInteractionEnabled = true
            self.textContent.isUserInteractionEnabled = true
            self.textTemplateTitle.isUserInteractionEnabled = true
            self.textTemplateSenderName.isUserInteractionEnabled = true
            self.textTemplatesenderEmail.isUserInteractionEnabled = true
            self.textPUserFirstName.isUserInteractionEnabled = true
            self.textPUserLastName.isUserInteractionEnabled = true
            self.textPUserMobile.isUserInteractionEnabled = true
            self.textPUserEmail.isUserInteractionEnabled = true
            self.textCompTitle.isUserInteractionEnabled = true
            self.textCompAddress.isUserInteractionEnabled = true
            self.textCompMobile.isUserInteractionEnabled = true
            self.textCompCopyWrite.isUserInteractionEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    func checkValidation(){

        guard let tempName = textTemplateName.text?.trim() , !tempName.isEmpty else {
            
            self.ShowAlert(message:"Please enter template name")
            
            return
        }
        
        guard let content = textContent.text?.trim() , !content.isEmpty else {
            
             self.ShowAlert(message:"Please enter content")
            
            return
        }
        guard let tempTitle = textTemplateTitle.text?.trim() , !tempTitle.isEmpty else {
            
             self.ShowAlert(message:"Please enter template title")
            
            return
        }
        guard let tempSenderName = textTemplateSenderName.text?.trim() , !tempSenderName.isEmpty else {
            
             self.ShowAlert(message:"Please enter template name")
            
            return
        }
        guard let tempEmail = textTemplatesenderEmail.text?.trim() , !tempEmail.isEmpty else {
            
             self.ShowAlert(message:"Please enter template name")
            
            return
        }
        
        guard tempEmail.isValidEmail() else {
            self.ShowAlert(message: LTY_AlterText.messageEmailVarification.localized(), title: LTY_AlterText.email.localized())
            return
        }
        guard let firstName = textPUserFirstName.text?.trim() , !firstName.isEmpty else {
            
             self.ShowAlert(message:"Please enter first name")
            
            return
        }
        guard let lastName = textPUserLastName.text?.trim() , !lastName.isEmpty else {
            
             self.ShowAlert(message:"Please enter last name")
            
            return
        }

        guard let mobile = textPUserMobile.text?.trim() , !mobile.isEmpty else {
            
             self.ShowAlert(message:"Please enter Mobile Number")
            
            return
        }
        guard mobile.isLengthValid(minLength: 8, maxLength: 13) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation.localized(), title: LTY_AlterText.mobile.localized())
            return
        }
      
      
        guard let email = textPUserEmail.text?.trim() , !email.isEmpty else {
            
             self.ShowAlert(message:"Please enter template name")
            
            return
        }
        
        guard email.isValidEmail() else {
            self.ShowAlert(message: LTY_AlterText.messageEmailVarification.localized(), title: LTY_AlterText.email.localized())
            return
        }
        
        guard let compTitle = textCompTitle.text?.trim() , !compTitle.isEmpty else {
            
             self.ShowAlert(message:"Please enter company Title")
            
            return
        }
        guard let compAddress = textCompAddress.text?.trim() , !compAddress.isEmpty else {
            
             self.ShowAlert(message:"Please enter company Address")
            
            return
        }
        guard let compMobile = textCompMobile.text?.trim() , !compMobile.isEmpty else {
            
             self.ShowAlert(message:"Please enter company Mobile")
            
            return
        }
        
        guard compMobile.isLengthValid(minLength: 9, maxLength: 13) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation.localized(), title: LTY_AlterText.mobile.localized())
            return
        }
        
        guard let compCopyWrite = textCompCopyWrite.text?.trim() , !compCopyWrite.isEmpty else {
            
             self.ShowAlert(message:"Please enter copy Write")
            
            return
        }

        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        
        if userType as! String == "AGENT" {
            AddNewTempDict["partnerId"] = sourceId
            AddNewTempDict["agentId"] = PartnerId
        } else {
            AddNewTempDict["partnerId"] = PartnerId
            AddNewTempDict["agentId"] = ""
        }
   
        
        AddNewTempDict["templateName"] = tempName
        AddNewTempDict["content"] = content
        
        var temDetailsDic = NSMutableDictionary()
        temDetailsDic.setValue(tempTitle, forKey: "title")
        temDetailsDic.setValue(tempSenderName, forKey: "name")
        temDetailsDic.setValue(tempEmail, forKey: "email")
        AddNewTempDict["templateSettingDetails"] = temDetailsDic
        
        var personalDetailsDic = NSMutableDictionary()
        personalDetailsDic.setValue(firstName, forKey: "firstName")
        personalDetailsDic.setValue(lastName, forKey: "lastName")
        personalDetailsDic.setValue(mobile, forKey: "mobile")
        personalDetailsDic.setValue(email, forKey: "email")
        AddNewTempDict["personalizationDetails"] = personalDetailsDic
        
        var companyDetailsDic = NSMutableDictionary()
        companyDetailsDic.setValue(compTitle, forKey: "title")
        companyDetailsDic.setValue(compAddress, forKey: "address")
        companyDetailsDic.setValue(compMobile, forKey: "mobile")
        companyDetailsDic.setValue(compCopyWrite, forKey: "copyRight")
        AddNewTempDict["companyDetails"] = companyDetailsDic
        print(AddNewTempDict)
        addNewTemplateViewModel.AddTemplateApiCall(param: AddNewTempDict)
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }

    @IBAction func onClickAddActionBtn(_ sender: UIButton) {
        checkValidation()
    }
    
    
    @IBAction func onClickCancelBtn(_ sender: UIButton) {
        self.popVC(animated: true)
    }
}

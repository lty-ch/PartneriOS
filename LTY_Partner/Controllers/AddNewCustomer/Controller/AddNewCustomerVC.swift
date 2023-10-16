//
//  AddNewCustomerVC.swift
//  LTY_Partner
//
//  Created by CTS on 26/05/23.
//

import UIKit
import GooglePlaces
import CountryPickerView

protocol AddNewCustomerCallback : AnyObject {
    func removeView()
}


class AddNewCustomerVC: UIViewController, SetDrpDownText,SetInsurerList{
 
    func setSelectedMemberList(arr: NSMutableArray, nameArr: NSMutableArray, memberList: [CategoryList] ) {
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
           let result = language as! NSArray
           
        if result[0] as! String == "fr" {
            textShowInsurerDoc.text = nameArr.componentsJoined(by: ",")
            memberIdArr = arr
            memberNameArr = nameArr
            
        }else{
            textShowInsurerDoc.text = nameArr.componentsJoined(by: ",")
            memberIdArr = arr
            memberNameArr = nameArr
            self.maincatArr = memberList
        }
    }
    
    @IBOutlet weak var phoneHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var countryCodeHeightOutlets: NSLayoutConstraint!
    @IBOutlet weak var btnViewFrontDoc: UIButton!
    @IBOutlet weak var btnViewBackDoc: UIButton!
    @IBOutlet weak var lblRegisterFrontID: UILabel!
    @IBOutlet weak var lblTitleBackId: UILabel!
    @IBOutlet weak var lblInsurerType: UILabel!
    
    @IBOutlet weak var btnUpdatePhone: UIButton!
    @IBOutlet weak var textShowInsurerDoc: CustomTextField!
    @IBOutlet weak var textShowBackDoc: CustomTextField!
    @IBOutlet weak var textShowFrontDoc: CustomTextField!
    @IBOutlet weak var btnAddAgent: UIButton!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var compnyView: UIView!
    @IBOutlet weak var imgCompnyUser: UIImageView!
    @IBOutlet weak var imgPersnalUser: UIImageView!
    @IBOutlet weak var lblCompUser: UILabel!
    @IBOutlet weak var btnCompUser: UIButton!
    @IBOutlet weak var lblPersnalUser: UILabel!
    @IBOutlet weak var btnPersnalUSer: UIButton!
    
    @IBOutlet weak var textCountryCode: UITextField!
    
    @IBOutlet weak var lblPersnalInfoCCode: UILabel!
    //MARK:- outlets for compny info
    
    @IBOutlet weak var viewCompnyID: UIView!
    @IBOutlet weak var viewCompnyName: UIView!
    @IBOutlet weak var maritailStatus: UIView!
    @IBOutlet weak var viewLegalEntity: UIView!
    @IBOutlet weak var viewCompnyWebsite: UIView!
    @IBOutlet weak var viewEmployeNumber: UIView!
    
    @IBOutlet weak var lblComName: UILabel!
    @IBOutlet weak var lblTotalEmp: UILabel!
    @IBOutlet weak var lblCompnyId: UILabel!
    @IBOutlet weak var lblCompWebsite: UILabel!
    @IBOutlet weak var lblLegalEntity: UILabel!
    @IBOutlet weak var lblMaritailStatus: UILabel!
    
    @IBOutlet weak var textCompName: CustomTextField!
    @IBOutlet weak var textTotalEmp: CustomTextField!
    @IBOutlet weak var textCompnyId: CustomTextField!
    @IBOutlet weak var textCompWebsite: CustomTextField!
    @IBOutlet weak var textLegalEntity: CustomTextField!
    @IBOutlet weak var textMaritialStatus: CustomTextField!
    
    @IBOutlet weak var headerStackView: UIStackView!
    //MARK:- outlets for persnol info
    
    @IBOutlet weak var btnUploadDocuments: UIButton!
    @IBOutlet weak var textDob: CustomTextField!
    @IBOutlet weak var textCity: CustomTextField!
    @IBOutlet weak var textPhone: CustomTextField!
    @IBOutlet weak var textState: CustomTextField!
    @IBOutlet weak var textEmail: CustomTextField!
    @IBOutlet weak var textGender: CustomTextField!
    @IBOutlet weak var textAddress: CustomTextField!
    @IBOutlet weak var textCountry: CustomTextField!
    @IBOutlet weak var textPostCode: CustomTextField!
    @IBOutlet weak var textAgentName: CustomTextField!
    @IBOutlet weak var textFirstName: CustomTextField!
    
    @IBOutlet weak var textLastName: CustomTextField!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var btnSelectState: UIButton!
    @IBOutlet weak var btnSelectCounty: UIButton!
    
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblSatet: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPostCode: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblSelectGender: UILabel!
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var datePicker = UIDatePicker()
    var selectedTxtFieldTag = 0
    
    var memberIdArr = NSMutableArray()
    var memberNameArr = NSMutableArray()
    
    var customCountryDDView : CustomCountryDDView!
    var drpDownCounrtyListArray = [CountryModel]()
    var drpDownStateListArray = [StateModel]()
    var drpDownCityListArray = [CityModel]()
    
    var newDrpDownCounrtyListArray = [DrpDownListStruct]()
    var newDrpDownStateListArray = [DrpDownListStruct]()
    var newDrpDownCityListArray = [DrpDownListStruct]()
    var addNewCustomerViewModel = AddNewCustomerViewModel()
    
    var companyDetailsDic = [String:Any]()
    var bankDetailsDic = [String:Any]()
    var mainDic = [String:Any]()
    var updateDic = [String:Any]()
    
    var customerVM = CustomerViewModel()
    var customerAgentArr = [CustomerActiveAgentsList]()
    var agentId = ""
    var agentDob = ""
    weak var delegate:AddNewCustomerCallback?
    var isComingFrom = "Edit"
    var customerObj: CustomerUpdateDataClass?
    var entityId = ""
    var userType :Bool = true
    var type = "Personal"
    var pickedImageUrl:URL?
    var picker = UIImagePickerController()
    
    var registerFrontId = ""
    var registerBackId = ""
    var insurerCompanyId = ""
    var btnTag = 0
    var selectCatVM = SelectCatViewModel()
    var maincatArr = [CategoryList]()
   
    var countryPickerView: CountryPickerView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setDrowerHeight()
        
        textCountryCode.delegate = self
        configCountryCodePicker()
        
        selectCatVM.delegate = self
        selectCatVM.mainCatListApi(param: ["searchBy": ""])
        
        hideView(setUserType: true)
        
        textDob.delegate = self
        addNewCustomerViewModel.delegate = self
        
        customerVM.delegate = self
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let agentParam:[String:Any] = ["partnerId": partnerId, "searchBy": ""]
        customerVM.getCustomerActiveAgent(param: agentParam)
        
        addNewCustomerViewModel.getCountryListApi()
        
        
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        headerStackView.isHidden = true
        headerViewHeight.constant = 0
        customNavDrower.titleLabel.text = "Add New Customer".localized()
        
        
        if self.isComingFrom == "Edit" {
            phoneHeightConstant.constant = 10
            countryCodeHeightOutlets.constant = 10
            
            textEmail.isUserInteractionEnabled = false
            self.btnAdd.setTitle("Update".localized(), for: .normal)
            textPhone.isUserInteractionEnabled = false
            textCountryCode.isUserInteractionEnabled = false
            btnUpdatePhone.isHidden = false
            
            customNavDrower.titleLabel.text = "Edit Customer".localized()
            headerStackView.isHidden = true
            headerViewHeight.constant = 0
            let param:[String:Any] = ["entityId": self.entityId, "entityType": "USER_ID"]
            self.getCustomerDetailApi(param: param)
            //            self.updateCustomerApi(param: param)
            
        } else {
            self.btnAdd.setTitle("Add".localized(), for: .normal)
            btnUpdatePhone.isHidden = true
            textEmail.isUserInteractionEnabled = true
            textPhone.isUserInteractionEnabled = true
            textCountryCode.isUserInteractionEnabled = true
            headerViewHeight.constant = 70
            headerStackView.isHidden = false
            phoneHeightConstant.constant = 10
            countryCodeHeightOutlets.constant = 10
            
        }
        
        
        textCountry.text = "Switzerland" //214
        textCountryCode.text = "+41"
        var urlStr = ""
        urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(textCountry.text!)"
        let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        addNewCustomerViewModel.getStateListApi(url: encodedURLString)
      
        NotificationCenter.default.addObserver(self, selector: #selector(handlesNotification(_:)), name: NSNotification.Name(rawValue: "updateEmailPhone"), object: nil)
        setUpLocalization()
    }
    
    @objc func handlesNotification(_ sender: Notification) {
        
        let senderData = sender.userInfo
        if let data = senderData as? [String: String] {
            
            let dataEmail = data["email"]
            let dataMobile = data["mobile"]
            let countryCode = data["countryCode"]

            if dataEmail != nil{
                self.textEmail.text = dataEmail

            }
            if dataMobile != nil{
               self.textPhone.text = dataMobile
                self.textCountryCode.text = countryCode

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)
        let agentId = kUserDefaults.value(forKey: AppKeys.partnerID)
        
        if usertype as! String == "PARTNER"{
            btnAddAgent.isUserInteractionEnabled = true
        }else {
            let userName = kUserDefaults.value(forKey: AppKeys.agentName)
            
            btnAddAgent.isUserInteractionEnabled = false
            self.textAgentName.text = userName as! String
            self.agentId = agentId as! String
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    @IBAction func btnOnClickCountryCode(_ sender: UIButton) {
        print("open country code picker")
        self.countryPickerView?.showCountriesList(from: self)
    }
    
    func setUpLocalization() {
        self.btnViewFrontDoc.setTitle("View Attachment".localized(), for: .normal)
        self.btnViewBackDoc.setTitle("View Attachment".localized(), for: .normal)
        self.lblRegisterFrontID.text = "Upload Register ID (Front)".localized()
        self.lblTitleBackId.text = "Upload Register ID (Back)".localized()
        self.lblInsurerType.text = "Insurer Company".localized()
    }
    //MARK:- setUp View
    
    func setupView(){
        compnyView.viewCorner(8)
        userView.viewCorner(8)
        btnAdd.viewCorner(8)
        
        lblPersnalInfoCCode.font             = FontSize.size16
        lblPersnalInfoCCode.textColor        = Asset.Colors.gray1.color
        textCountryCode.font              = FontSize.size16
        textCountryCode.textColor         = Asset.Colors.darkGrayColor.color
        textCountryCode.backgroundColor   = Asset.Colors.grayColor.color
        
        
        // dob
        
        lblDob.font             = FontSize.size16
        lblDob.textColor        = Asset.Colors.gray1.color
        lblDob.text             = LTYText.dob.localized()
        textDob.font              = FontSize.size16
        textDob.textColor         = Asset.Colors.darkGrayColor.color
        textDob.backgroundColor   = Asset.Colors.grayColor.color
        lblDob.makeTextMandatory()
        
        //city
        
        lblCity.font             = FontSize.size16
        lblCity.textColor        = Asset.Colors.gray1.color
        lblCity.text             = LTYText.textSignUpVCCity.localized()
        textCity.font              = FontSize.size16
        textCity.textColor         = Asset.Colors.darkGrayColor.color
        textCity.backgroundColor   = Asset.Colors.grayColor.color
        lblCity.makeTextMandatory()
        
        //Phone
        
        lblPhone.font             = FontSize.size16
        lblPhone.textColor        = Asset.Colors.gray1.color
        lblPhone.text             = LTYText.text_AgentPhone.localized()
        textPhone.font              = FontSize.size16
        textPhone.textColor         = Asset.Colors.darkGrayColor.color
        textPhone.backgroundColor   = Asset.Colors.grayColor.color
        lblPhone.makeTextMandatory()
        
        // Email
        
        lblEmail.font             = FontSize.size16
        lblEmail.textColor        = Asset.Colors.gray1.color
        lblEmail.text             = LTYText.textSignUpVCEmail.localized()
        textEmail.font              = FontSize.size16
        textEmail.textColor         = Asset.Colors.darkGrayColor.color
        textEmail.backgroundColor   = Asset.Colors.grayColor.color
        lblEmail.makeTextMandatory()
        
        //State
        
        lblSatet.font             = FontSize.size16
        lblSatet.textColor        = Asset.Colors.gray1.color
        lblSatet.text             = LTYText.textSignUpVCState.localized()
        textState.font              = FontSize.size16
        textState.textColor         = Asset.Colors.darkGrayColor.color
        textState.backgroundColor   = Asset.Colors.grayColor.color
        lblSatet.makeTextMandatory()
        
        //country
        
        lblCountry.font             = FontSize.size16
        lblCountry.textColor        = Asset.Colors.gray1.color
        lblCountry.text             = LTYText.textSignUpVCCountry.localized()
        textCountry.font              = FontSize.size16
        textCountry.textColor         = Asset.Colors.darkGrayColor.color
        textCountry.backgroundColor   = Asset.Colors.grayColor.color
        lblCountry.makeTextMandatory()
        
        // Address
        
        lblAddress.font             = FontSize.size16
        lblAddress.textColor        = Asset.Colors.gray1.color
        lblAddress.text             = LTYText.text_AgentAddress.localized()
        textAddress.font              = FontSize.size16
        textAddress.textColor         = Asset.Colors.darkGrayColor.color
        textAddress.backgroundColor   = Asset.Colors.grayColor.color
        lblAddress.makeTextMandatory()
        
        //post code
        
        lblPostCode.font             = FontSize.size16
        lblPostCode.textColor        = Asset.Colors.gray1.color
        lblPostCode.text             = LTYText.textSignUpVCPostCode.localized()
        textPostCode.font              = FontSize.size16
        textPostCode.textColor         = Asset.Colors.darkGrayColor.color
        textPostCode.backgroundColor   = Asset.Colors.grayColor.color
        lblPostCode.makeTextMandatory()
        
        // Agent Name
        
        lblAgentName.font             = FontSize.size16
        lblAgentName.textColor        = Asset.Colors.gray1.color
        lblAgentName.text             = LTYText.agentName.localized()
        textAgentName.font              = FontSize.size16
        textAgentName.textColor         = Asset.Colors.darkGrayColor.color
        textAgentName.backgroundColor   = Asset.Colors.grayColor.color
       // lblAgentName.makeTextMandatory()
        
        //First name
        
        lblFirstName.font             = FontSize.size16
        lblFirstName.textColor        = Asset.Colors.gray1.color
        lblFirstName.text             = LTYText.fullName.localized()
        textFirstName.font              = FontSize.size16
        textFirstName.textColor         = Asset.Colors.darkGrayColor.color
        textFirstName.backgroundColor   = Asset.Colors.grayColor.color
        lblFirstName.makeTextMandatory()
        
        //Last name
        
        lblLastName.font             = FontSize.size16
        lblLastName.textColor        = Asset.Colors.gray1.color
        lblLastName.text             = LTYText.lastName.localized()
        textLastName.font              = FontSize.size16
        textLastName.textColor         = Asset.Colors.darkGrayColor.color
        textLastName.backgroundColor   = Asset.Colors.grayColor.color
        lblLastName.makeTextMandatory()
        
        // select gender
        
        lblSelectGender.font             = FontSize.size16
        lblSelectGender.textColor        = Asset.Colors.gray1.color
        lblSelectGender.text             = LTYText.selectGender.localized()
        textGender.font              = FontSize.size16
        textGender.textColor         = Asset.Colors.darkGrayColor.color
        textGender.backgroundColor   = Asset.Colors.grayColor.color
        lblSelectGender.makeTextMandatory()
        
        //lblMaritailStatus
        
        lblMaritailStatus.font             = FontSize.size16
        lblMaritailStatus.textColor        = Asset.Colors.gray1.color
        lblMaritailStatus.text             = LTYText.maritialStatus.localized()
        textMaritialStatus.font              = FontSize.size16
        textMaritialStatus.textColor         = Asset.Colors.darkGrayColor.color
        textMaritialStatus.backgroundColor   = Asset.Colors.grayColor.color
        lblMaritailStatus.makeTextMandatory()
        
        lblComName.font             = FontSize.size16
        lblComName.textColor        = Asset.Colors.gray1.color
        lblComName.text             = LTYText.compName.localized()
        textCompName.font              = FontSize.size16
        textCompName.textColor         = Asset.Colors.darkGrayColor.color
        textCompName.backgroundColor   = Asset.Colors.grayColor.color
        lblComName.makeTextMandatory()
        
        lblTotalEmp.font             = FontSize.size16
        lblTotalEmp.textColor        = Asset.Colors.gray1.color
        lblTotalEmp.text             = LTYText.totalEmp.localized()
        textTotalEmp.font              = FontSize.size16
        textTotalEmp.textColor         = Asset.Colors.darkGrayColor.color
        textTotalEmp.backgroundColor   = Asset.Colors.grayColor.color
       // lblTotalEmp.makeTextMandatory()
        
        lblCompnyId.font             = FontSize.size16
        lblCompnyId.textColor        = Asset.Colors.gray1.color
        lblCompnyId.text             = LTYText.comp_Id.localized()
        textCompnyId.font              = FontSize.size16
        textCompnyId.textColor         = Asset.Colors.darkGrayColor.color
        textCompnyId.backgroundColor   = Asset.Colors.grayColor.color
        //lblCompnyId.makeTextMandatory()
        
        lblCompWebsite.font             = FontSize.size16
        lblCompWebsite.textColor        = Asset.Colors.gray1.color
        lblCompWebsite.text             = LTYText.compWebsite.localized()
        textCompWebsite.font              = FontSize.size16
        textCompWebsite.textColor         = Asset.Colors.darkGrayColor.color
        textCompWebsite.backgroundColor   = Asset.Colors.grayColor.color
        lblCompWebsite.makeTextMandatory()
        
        lblLegalEntity.font             = FontSize.size16
        lblLegalEntity.textColor        = Asset.Colors.gray1.color
        lblLegalEntity.text             = LTYText.legalEntity.localized()
        textLegalEntity.font              = FontSize.size16
        textLegalEntity.textColor         = Asset.Colors.darkGrayColor.color
        textLegalEntity.backgroundColor   = Asset.Colors.grayColor.color
      //  lblLegalEntity.makeTextMandatory()
        
        lblPersnalUser.font             = FontSize.size16
        lblPersnalUser.text             = LTYText.persnalUser.localized()
        lblPersnalUser.textColor        = Asset.Colors.gray1.color
        
        lblCompUser.font             = FontSize.size16
        lblCompUser.text             = LTYText.compUser.localized()
        lblCompUser.textColor        = Asset.Colors.gray1.color
        
    }
    
    //MARK:- Show DatePicker
    
    func showDatePicker(){
        
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        var comps = DateComponents()
    
        components.year = -150
        comps.year = -16
        let minDate = calendar.date(byAdding: components, to: Date())
        let maxDate = calendar.date(byAdding: comps, to: Date())
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate//Date()
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //  use this case for set date in multiple textfiled using same picker
        
        
        textDob.inputView = datePicker
        textDob.inputAccessoryView = toolbar
        
    }
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"//"dd MMMM yyyy"
        
        formatter.dateFormat = "yyyy-MM-dd"//"dd MMMM yyyy"
        agentDob = "\(formatter.string(from: datePicker.date))"
        
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd.MM.yyyy"
    
        textDob.text = formatter1.string(from: datePicker.date)
        
        self.view.endEditing(true)
        
    }
    
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    
    
    //MARK:- hide / show views
    
    func hideView(setUserType:Bool) {
        if setUserType == true {
            
            userType = true
            viewCompnyID.isHidden = true
            viewCompnyName.isHidden = true
            viewLegalEntity.isHidden = true
            viewCompnyWebsite.isHidden = true
            viewEmployeNumber.isHidden = true
            customNavDrower.titleLabel.text = "Add New Customer".localized()
            imgPersnalUser.image = Asset.Assets.checkRadioImage.image
            imgCompnyUser.image = Asset.Assets.uncheckRadioImage.image
            
        }
        else {
            userType = false
            viewCompnyID.isHidden = false
            viewCompnyName.isHidden = false
            viewLegalEntity.isHidden = false
            viewCompnyWebsite.isHidden = false
            viewEmployeNumber.isHidden = false
            customNavDrower.titleLabel.text = "Company User".localized()
            imgCompnyUser.image = Asset.Assets.checkRadioImage.image
            imgPersnalUser.image = Asset.Assets.uncheckRadioImage.image
            
        }
    }
    
    //MARK:- btn agent Action
    
    @IBAction func agentActionBtn(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in customerAgentArr {
            let fName = item.firstName ?? ""
            let lName = item.lastName ?? ""
            
            let action = UIAlertAction(title: "\(fName) \(lName)", style: .default) { (action) in
                
                self.textAgentName.text = "\(fName) \(lName)"
                self.agentId = item.partnerId ?? ""
            }
            
            //              let icon = UIImage.init(named: cat.icon)
            
            //              action.setValue(icon, forKey: "image")
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    func checkPersonalInfoValidation() {
        
        if userType == false {
            
            guard let compName = textCompName.text, !compName.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageCompanyName, title: LTY_AlterText.companyName)
                return
            }
           
            guard let website = textCompWebsite.text, !website.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageWebsite.localized(), title: LTY_AlterText.website.localized())
                return
            }
            guard  website.isValidUrl(url: website)else {
                self.ShowAlert(message: LTY_AlterText.messageValidWebsite.localized(), title: LTY_AlterText.website.localized())
                return
            }
            /*
            guard let totalEmp = textTotalEmp.text, !totalEmp.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageTotalEmploye, title: LTY_AlterText.totalEmploye)
                return
            }
            guard let compnyId = textCompnyId.text, !compnyId.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageCompnyID, title: LTY_AlterText.compnyID)
                return
            }
            guard let legalEntity = textLegalEntity.text, !legalEntity.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageLegalEntity, title: LTY_AlterText.legalEntity)
                return
            }
            */
        }
        
        
        guard let firstName = textFirstName.text, !firstName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageFirstName, title: LTY_AlterText.firstName)
            return
        }
        if containsNumbers(textField: textFirstName) {
            self.ShowAlert(message: LTY_AlterText.messageFirstNameNumberValidation, title: LTY_AlterText.firstName)
            return
        }
        guard  let lastName = textLastName.text, !lastName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageLastName, title: LTY_AlterText.lastName)
            return
        }
        if containsNumbers(textField: textLastName) {
            self.ShowAlert(message: LTY_AlterText.messageLastNameNumberValidation, title: LTY_AlterText.lastName)
            return
        }
        guard let mobile = textPhone.text, !mobile.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageMobile, title: LTY_AlterText.mobile)
            return
        }
        guard mobile.isLengthValid(minLength: 8, maxLength: 13) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation, title: LTY_AlterText.mobile)
            return
        }
        guard let email = textEmail.text?.trim() , !email.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageEmail, title: LTY_AlterText.email)
            return
        }
        guard email.isValidEmail() else {
            self.ShowAlert(message: LTY_AlterText.messageEmailVarification, title: LTY_AlterText.email)
            return
        }
        guard  let address = textAddress.text, !address.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
            return
        }
        if address.containsOnlyAlphanumeric() {
            print("Contains only alphanumeric characters, white spaces, and allowed special characters!")
        } else {
            self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
            return
        }

        guard  let country = textCountry.text, !country.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCountry, title: LTY_AlterText.country)
            return
        }
        guard let state = textState.text, !state.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageState, title: LTY_AlterText.state)
            return
        }
        guard let city = textCity.text, !city.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCity, title: LTY_AlterText.city)
            return
        }
        guard  let postCode = textPostCode.text, !postCode.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messagePostCode, title: LTY_AlterText.postCode)
            return
        }
        
        guard postCode.isLengthValid(minLength: 4, maxLength: 6) else  {
            self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation, title: LTY_AlterText.messagePostCodeValidation)
            return
        }
        
        guard let maritalStatus = textMaritialStatus.text, !maritalStatus.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.maritalStatusAlert, title: LTY_AlterText.maritalStatus)
            return
        }
        guard  let gender = textGender.text, !gender.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messagegender, title: LTY_AlterText.gender)
            return
        }
        
        if agentDob == ""{
            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)
            return
        }
//        guard let dob = textDob.text, !dob.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)
//
//            return
//        }
//        guard let agentName = textAgentName.text, !agentName.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.messageAgentName, title: LTY_AlterText.agentName)
//
//            return
//        }
//        guard let frontDocType = textShowFrontDoc.text, !frontDocType.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.frontMessageUploadDoc, title: LTY_AlterText.frontDocType)
//            
//            return
//        }
//        guard let backDocType = textShowBackDoc.text, !backDocType.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.backMessageUploadDoc, title: LTY_AlterText.backDocType)
//            
//            return
//        }
        guard let insurerCompanyType = textShowInsurerDoc.text, !insurerCompanyType.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.insurerCompanydoc, title: LTY_AlterText.insurerCompanyType)
            
            return
        }
        
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
        self.companyDetailsDic["companyName"] = self.textCompName.text!
        self.companyDetailsDic["website"] = self.textCompWebsite.text!
        self.companyDetailsDic["noOfEmployee"] = self.textTotalEmp.text!
        self.companyDetailsDic["companyId"] = self.textCompnyId.text!
        self.companyDetailsDic["legalEntity"] = self.textLegalEntity.text!
        
        self.bankDetailsDic["iban"] = ""
        self.bankDetailsDic["swift"] = ""
        self.bankDetailsDic["bank"] = ""
        self.bankDetailsDic["country"] = ""
        self.bankDetailsDic["postCode"] = ""
        self.bankDetailsDic["address"] = ""
        self.bankDetailsDic["houseOwned"] = ""
        
        
        self.mainDic["source"] = partnerId
        self.mainDic["type"] = self.type
        self.mainDic["firstName"] = self.textFirstName.text!
        self.mainDic["lastName"] = self.textLastName.text!
        self.mainDic["mobile"] = self.textPhone.text!
        self.mainDic["countryCode"] = self.textCountryCode.text!
        
        self.mainDic["email"] = self.textEmail.text!
        //        self.mainDic["dob"] = self.textDob.text!
        self.mainDic["dob"] = agentDob
        //        self.mainDic["country"] = self.textCountry.text!
        //        self.mainDic["state"] = self.textState.text!
        //        self.mainDic["city"] = self.textCity.text!
        self.mainDic["country"] = self.textCountry.text!
        self.mainDic["state"] = self.textState.text!
        self.mainDic["city"] = self.textCity.text!
        
        self.mainDic["address"] = self.textAddress.text!
        self.mainDic["postCode"] = self.textPostCode.text!
        //        self.mainDic["maritalStatus"] = self.textMaritialStatus.text!
        self.mainDic["maritalStatus"] = self.textMaritialStatus.text!
        self.mainDic["gender"] = self.textGender.text!
        let arr = NSMutableArray()
        arr[0] = self.registerFrontId
        arr[1] = self.registerBackId
        self.mainDic["registrationIds"] = arr
        self.mainDic["insurerCompanies"] = memberNameArr
        
        self.mainDic["member_id"] = "0"
        self.mainDic["agentId"] = self.agentId
        
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        
        if usertype as! String == "PARTNER"{
            self.mainDic["partnerId"] = partnerId
        }else {
            self.mainDic["partnerId"] = sourceId
            
        }
        self.mainDic["profilePic"] = ""
        self.mainDic["password"] = ""
        self.mainDic["companyDetails"] = self.companyDetailsDic
        self.mainDic["bankDetails"] = self.bankDetailsDic
        
        //print(mainDic)
        
        if self.isComingFrom == "Edit" {
            self.updateDic["userId"] = self.entityId
            self.updateDic["userDetail"] = self.mainDic
            DispatchQueue.main.async {
                
               
                self.btnAdd.setTitle("Update".localized(), for: .normal)
                
            }
        self.updateCustomerApi(param: self.updateDic)
            
        } else {
            DispatchQueue.main.async {
                self.btnAdd.setTitle("Add".localized(), for: .normal)
                
            }
            self.addCustomerApi(param: self.mainDic)
      
        }
        
        
        
    }
    
    @IBAction func onClickInsurerBtn(_ sender: UIButton) {
        
        let vc = SelectInsurerVC.instantiate(fromAppStoryboard: .customerStoryboard)
       
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        vc.memberIdArr = self.memberIdArr
        vc.memberNameArr = self.memberNameArr
        vc.insurerList = maincatArr
        vc.delegate = self
        self.present(vc, animated: true)
       
/*
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            for cat in maincatArr {
                let action = UIAlertAction(title: cat.category, style: .default) { (action) in
                    
                    self.textShowInsurerDoc.text = cat.category ?? ""
                    self.insurerCompanyId = cat.categoryId ?? ""
                    
              }

//              let icon = UIImage.init(named: cat.icon)

//              action.setValue(icon, forKey: "image")
              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            }

            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)
       */
    }
    
    //MARK:- personal  user  action
    
    @IBAction func btnPernalUserAction(_ sender: UIButton) {
        self.type = "Personal"
        hideView(setUserType: true)
        
    }
    
    //MARK:- comp user action
    
    @IBAction func btnCompUserAction(_ sender: UIButton) {
        self.type = "Company"
        hideView(setUserType: false)
        
    }
    //MARK:- Cancel Action btn
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    @IBAction func btnUpdatePhoneAction(_ sender: UIButton) {
        
      let vc = UpdatePhoneEmailVC.instantiate(fromAppStoryboard: .home) //self.storyboard?.instantiateViewController(withIdentifier:"UpdatePhoneEmailVC") as! UpdatePhoneEmailVC
        vc.agentId = entityId
        vc.modalPresentationStyle = .overCurrentContext
        
        vc.isCommingFrom = "update_phone"
        
        vc.delegate = self
        self.present(vc, animated: true)
    }
    //MARK:- Add Action btn
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        
        checkPersonalInfoValidation()
        
    }
    
    func addCustomerApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.addNewCustomer, method: "POST", passToken: true, expecting:AddNewCustomerModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                if result.status == "SUCCESS" {
                    DispatchQueue.main.async {
                        self.showOkAlertWithHandler(result.data?.message ?? "") {
                            self.delegate?.removeView()
                            self.popVC(animated: true)
                        }
                    }
                    //                    self.ShowAlert(message: result.data?.message ?? "")
                }else{
                    DispatchQueue.main.async {
                        self.ShowAlert(message:result.error?.serverErrorMessage ?? "")
                    }
                }
                
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.ShowAlert(message: error.localizedDescription)
                    //                    self.delegate?.popupMsg(msg:error.localizedDescription)
                    
                }
            }
            
            
        }
        
    }
    
    func getCustomerDetailApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomerDetails, method: "POST", passToken: true, expecting:CustomerUpdateModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                DispatchQueue.main.async {
                    self.customerObj = result.data
                    
                    DispatchQueue.main.async {
                        self.setCustomerData()
                    }
                    //                    self.delegate?.setCustomerList(data: result)
                    
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.ShowAlert(message: error.localizedDescription)
                    //                    self.delegate?.popupMsg(msg:error.localizedDescription)
                }
            }
        }
        
    }
    
    func updateCustomerApi (param:[String:Any]) {
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.updateCustomer, method: "put", isPassToken: true, expecting:CustomerUpdateModel.self, dataDict: param) { response
            in
            switch response {
            case .success(let result):
                
                DispatchQueue.main.async {
                    self.showOkAlertWithHandler("profile update successfully".localized()) {
                        self.delegate?.removeView()
                        self.popVC(animated: true)
                    }
                }
                //                self.delegatee?.setBlockCustomerdata(data: result)
                
                
            case .failure(let error):
                self.ShowAlert(message: error.localizedDescription)
                
            }
            
        }
    }
    
    
    //    func getProfileApi(_ tokenStr: String) {
    //
    //        let param:[String:Any] = ["token":tokenStr]
    //        ServerClass.sharedInstance.postRequestWithUrlParameters(param, path: LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.updateCustomer, successBlock: { (json) in
    //            print(json)
    ////            hideAllProgressOnView(appDelegateInstance.window!)
    //            let success = json["success"].stringValue
    //            if success == "true"
    //            {
    //
    //
    //
    //            }
    //            else {
    ////                UIAlertController.showInfoAlertWithTitle("Message", message: json["message"].stringValue, buttonTitle: "Okay")
    //            }
    //        }, errorBlock: { (NSError) in
    ////            UIAlertController.showInfoAlertWithTitle("Alert", message: kUnexpectedErrorAlertString, buttonTitle: "Okay")
    ////            hideAllProgressOnView(appDelegateInstance.window!)
    //        })    }
    
    
    @IBAction func btnDropDownSelectAction(_ sender: UIButton) {
        self.customCountryDDView = CustomCountryDDView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.customCountryDDView.delegate = self
        self.selectedTxtFieldTag = sender.tag
        switch sender.tag {
        case 201:
            print("Country Drop Down")
            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        case 202:
            print("State Drop Down")
            guard self.textCountry.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownStateListArray
            self.customCountryDDView.filteredData = newDrpDownStateListArray
        case 203:
            print("City Drop Down")
            guard self.textState.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageState, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownCityListArray
            self.customCountryDDView.filteredData = newDrpDownCityListArray
        case 701:
            print("open country code picker")

//            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
//            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
            
          //  self.countryPickerView?.showCountriesList(from: self)
 
        default:
            print("Have you done something new?")
        }
        self.view.addSubview(self.customCountryDDView)
    }
    
    
    func setDrpDownText(id: String, name: String, phoneCode:Int) {
        var urlStr = ""
        switch self.selectedTxtFieldTag {
            
            
        case 701:
            self.textCountryCode.text = "\("+")\(phoneCode)"
            
        case 201:
            self.textCountry.text = name
            self.textState.text = ""
            self.textCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
//            urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            addNewCustomerViewModel.getStateListApi(url: encodedURLString)
        case 202:
            if self.textCountry.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
            }
            else
            {
                self.textState.text = name
                self.textCity.text = ""
                self.newDrpDownCityListArray.removeAll()
                urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.CITY_URL)\(name)"
              //  urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
                let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                addNewCustomerViewModel.getCityListApi(url: encodedURLString)
            }
        case 203:
            if self.textState.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageState, title: "")
            }
            else
            {
                self.textCity.text = name
            }
            //        case 204:
            //            self.textLanguage.text = name
            //        case 205:
            //            self.textNationality.text = name
            //        case 206:
            //            self.textCompCountry.text = name
        default:
            print("nothing")
        }
    }
    
    @IBAction func onClickMartialStatus(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let martialArr = ["Single".localized(), "Married".localized()]
        
        for item in martialArr {
            
            let action = UIAlertAction(title: item, style: .default) { (action) in
                
                self.textMaritialStatus.text = item
            }
            
            //              let icon = UIImage.init(named: cat.icon)
            
            //              action.setValue(icon, forKey: "image")
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickGender(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let martialArr = ["Male".localized(), "Female".localized()]
        
        for item in martialArr {
            
            let action = UIAlertAction(title: item, style: .default) { (action) in
                
                self.textGender.text = item
            }
            
            //              let icon = UIImage.init(named: cat.icon)
            
            //              action.setValue(icon, forKey: "image")
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    func configCountryCodePicker(){
        self.countryPickerView = CountryPickerView()
        self.countryPickerView?.delegate = self
        self.countryPickerView?.dataSource = self
        
//        let locale = Locale.current
//        let code = ((locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?)
//        self.countryPickerView?.setCountryByCode(code)
    }
    
    func setCustomerData() {
        
        self.textFirstName.text = self.customerObj?.firstName?.capitalized   ?? ""
        self.textLastName.text = self.customerObj?.lastName?.capitalized   ?? ""
        self.textDob.text = returnDOB(date: self.customerObj?.dob ?? "")//self.customerObj?.dob ?? ""
        self.agentDob = self.customerObj?.dob ?? ""
        self.textAgentName.text = self.customerObj?.agentName ?? "Unassigned".localized()
        self.textEmail.text = self.customerObj?.email ?? ""
        self.textPhone.text = self.customerObj?.mobile ?? ""
        self.textCountryCode.text = self.customerObj?.countryCode ?? ""
        self.textGender.text = self.customerObj?.gender ?? ""
        self.textMaritialStatus.text = self.customerObj?.maritalStatus ?? ""
        self.textCountry.text = self.customerObj?.country ?? ""
        self.textState.text = self.customerObj?.state ?? ""
        self.textCity.text = self.customerObj?.city ?? ""
        self.textAddress.text = self.customerObj?.address ?? ""
        self.textPostCode.text = self.customerObj?.postCode ?? ""
        
            if let registrationIdArr = self.customerObj?.registrationIds, registrationIdArr.count > 0 {

           // let registrationIdArr = self.customerObj?.registrationIds
           // print(registrationIdArr)
            self.registerFrontId = registrationIdArr[0] ?? ""
            self.registerBackId = registrationIdArr[1] ?? ""
            
            //        self.membersArr = addProposalDic["memberId"] as! NSMutableArray
            //        lblMembarName.text = membersDetails.componentsJoined(by: ",")
            //
            var insurerDoc = self.customerObj?.insurerCompanies
            var arr = NSMutableArray()
            for item in insurerDoc! {
                
                arr.add(item)
                memberNameArr.add(item)
            }
            textShowInsurerDoc.text = arr.componentsJoined(by: ",")
            
           // memberIdArr =
                self.textShowFrontDoc.text = self.registerFrontId
//            let data = self.registerFrontId
//            if let lastSlashIndex = data.lastIndex(of: "/") {
//                let fileName = String(data[data.index(after: lastSlashIndex)...])
//                self.textShowFrontDoc.text = fileName
//                //            print("File Name: \(fileName)")
//            } else {
//                print("Invalid URL format")
//            }
//
                
                self.textShowFrontDoc.text = self.registerBackId
//            let data1 = self.registerBackId
//            if let lastSlashIndex = data1.lastIndex(of: "/") {
//                let fileName = String(data1[data1.index(after: lastSlashIndex)...])
//                self.textShowBackDoc.text = fileName
//                //            print("File Name: \(fileName)")
//            } else {
//                print("Invalid URL format")
//            }
        }
        //  self.textShowDoc.text = self.customerObj?.registrationId ?? ""
    }
    
    @IBAction func btnUploadDoc(_ sender: UIButton) {
        self.btnTag = sender.tag
        self.chooseWhatToUpload()
    }
    
    @IBAction func btnViewAtachmentAction(_ sender: UIButton) {
        if self.textShowFrontDoc.text?.isEmpty == true {
            self.ShowAlert(message: "No data found !!".localized())
        } else if self.textShowBackDoc.text?.isEmpty == true {
            self.ShowAlert(message: "No data found !!".localized())
        }else{
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = sender.tag == 601 ? self.registerFrontId : self.registerBackId
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
        }
    }
    
    @IBAction func setUserLocationBtn(_ sender: UIButton) {
   
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        present(autocompleteController, animated: true, completion: nil)
    }
    
 
}


extension AddNewCustomerVC: CustomerListProtocolDelegate {
    func setCustomerList(data: CustomerModel) {
        print("")
    }
    
    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        
        self.customerAgentArr = data.data?.agentsList ?? []
        
    }
    
}


extension AddNewCustomerVC :DismissScreenInProfileModule {

    func dismissScreenInProfileModule(setValue: Bool,data: ForgotPassValue, isComming:String) {
        if setValue == true
        {
            let vc = OtpVerifyVC.instantiate(fromAppStoryboard: .main)
            vc.comingFrom = isComming
            vc.otpId = data.otpID ?? "0"
            vc.agentID = entityId
            vc.verifiedEmail = data.userEmail ?? ""
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
     
            self.present(vc, animated: true)
        }
        else {}
            
            
            
            
//        {
//            let vc = OtpVerifyVC.instantiate(fromAppStoryboard: .main)
//            vc.comingFrom = isComming
//            vc.verifiedEmail = data.userEmail ?? ""
//            //vc.forgotPassData.append(ForgotPassData.init(otpID: data.otpID, duration: data.duration, remainingAttempts: data.remainingAttempts, resendOtpTime: data.resendOtpTime))
//            vc.modalPresentationStyle = .overCurrentContext
//            self.present(vc, animated: true)
//        }
//        else {}
    }
}

extension AddNewCustomerVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        
        let geocoder = CLGeocoder()
        let locValue: CLLocationCoordinate2D = place.coordinate
        print("locations with lat & long = \(locValue.latitude) \(locValue.longitude) \(place.name ?? "")")
        
        let latitude = locValue.latitude // Replace with the latitude of your location
        let longitude = locValue.longitude // Replace with the longitude of your location
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    print("City: \(city)")
                    
                    self.textAddress.text = "\(place.name ?? "") \(city)"
                    self.textCity.text = city
                    
                }
                
                if let state = placemark.administrativeArea {
                    print("State: \(state)")
                    
                    self.textState.text = state
                    
                }
                if let country = placemark.country {
                    print("Country: \(country)")
                    
                    self.textCountry.text = country
                    
                }
                if let postCode = placemark.postalCode {
                    print("PostCode: \(postCode)")
                    
                    self.textPostCode.text = postCode
                    
                }
            }
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}

extension AddNewCustomerVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.textCountryCode.text = country.phoneCode
//        if self.isFrom == "Phone" {
//            txtCountryCode.text = country.phoneCode
//        } else if self.isFrom == "Country" {
//            countryTxt.text = country.name
//        }
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select your country"
    }
    
}

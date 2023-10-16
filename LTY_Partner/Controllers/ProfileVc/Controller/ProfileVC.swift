//
//  ProfileVC.swift
//  LTY_Partner
//
//  Created by CTS on 18/05/23.
//

import UIKit
import SDWebImage
import MobileCoreServices
import UniformTypeIdentifiers
import GooglePlaces
import CountryPickerView


class ProfileVC: UIViewController, SetDrpDownText {
    //MARK:- Outlets
    
    @IBOutlet weak var textBankCity: CustomTextField!
    @IBOutlet weak var lblBankCity: UILabel!
    @IBOutlet weak var lblBankState: UILabel!
    @IBOutlet weak var textBankSate: CustomTextField!
    
    
    @IBOutlet weak var btnUpdateCompEmail: UIButton!
    @IBOutlet weak var btnUpdateCompMobile: UIButton!
    
    
    @IBOutlet weak var viewCompPO: UIView!
    @IBOutlet weak var viewPrivateOP: UIView!
    @IBOutlet weak var viewPrivateCriminalRecord: UIView!
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var customNavigationBarForDrawer: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var agentCommission1BackView: UIStackView!
    @IBOutlet weak var agentCommission2BackView: UIStackView!
    
    @IBOutlet weak var labelAgentComission: UILabel!
    @IBOutlet weak var labelCompReserve: UILabel!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var txtProfile: CustomTextField!
    @IBOutlet weak var labelAgentReserve: UILabel!
    @IBOutlet weak var txtAgentCommision: CustomTextField!
    @IBOutlet weak var txtCompReserve: CustomTextField!
    @IBOutlet weak var txtAgentReserve: CustomTextField!
    
    @IBOutlet weak var btnPersonalInfo: UIButton!
    @IBOutlet weak var btnCompanyInfo: UIButton!
    @IBOutlet weak var btnBankingInfo: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    
    @IBOutlet weak var personalInfoBackView: UIView!
    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var textFirstName: CustomTextField!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var textLastName: CustomTextField!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textPhone: CustomTextField!
    @IBOutlet weak var btnUpdatetPhoneNumber: UIButton!
    @IBOutlet weak var labelDOB: UILabel!
    @IBOutlet weak var textDOB: CustomTextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textEmail: CustomTextField!
    @IBOutlet weak var btnUpdatetEmailId: UIButton!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var textAddress: CustomTextField!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var textCountry: CustomTextField!
    @IBOutlet weak var btnDDCountry: UIButton!
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var textState: CustomTextField!
    @IBOutlet weak var btnDDState: UIButton!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var textCity: CustomTextField!
    @IBOutlet weak var btnDDCity: UIButton!
    @IBOutlet weak var labelPostCode: UILabel!
    @IBOutlet weak var textPostCode: CustomTextField!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var textLanguage: CustomTextField!
    @IBOutlet weak var btnDDLanguage: UIButton!
    @IBOutlet weak var labelNationality: UILabel!
    @IBOutlet weak var textNationality: CustomTextField!
    @IBOutlet weak var btnDDNationality: UIButton!
    @IBOutlet weak var btnPersonalInfoUpdate: UIButton!
    
    @IBOutlet weak var companyInfoBackView: UIView!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var btnSelectCountyCode: UIButton!
    @IBOutlet weak var textCompanyName: CustomTextField!
    @IBOutlet weak var labelWebSite: UILabel!
    @IBOutlet weak var textWebSite: CustomTextField!
    @IBOutlet weak var btnCompInfoUpdate: UIButton!
    
    @IBOutlet weak var bankInfoBackView: UIView!
    @IBOutlet weak var labelIBAN: UILabel!
    @IBOutlet weak var textIBAN: CustomTextField!
    @IBOutlet weak var labelSwiftBIC: UILabel!
    @IBOutlet weak var textSwiftBIC: CustomTextField!
    @IBOutlet weak var labelBank: UILabel!
    @IBOutlet weak var textBank: CustomTextField!
    @IBOutlet weak var labelCompAddress: UILabel!
    @IBOutlet weak var textCompAddress: CustomTextField!
    @IBOutlet weak var labelCompPostCode: UILabel!
    @IBOutlet weak var textCompPostCode: CustomTextField!
    @IBOutlet weak var labelCompCountry: UILabel!
    @IBOutlet weak var textBankCountry: CustomTextField!
    @IBOutlet weak var btnDDCompCountry: UIButton!
    @IBOutlet weak var btnBankInfoUpdate: UIButton!
    
    @IBOutlet weak var changePassBackView: UIView!
    @IBOutlet weak var labelOldPass: UILabel!
    @IBOutlet weak var textOldPass: CustomTextField!
    @IBOutlet weak var labelNewPass: UILabel!
    @IBOutlet weak var textNewPass: CustomTextField!
    @IBOutlet weak var labelConfirmPass: UILabel!
    @IBOutlet weak var textConfirmPass: CustomTextField!
    @IBOutlet weak var btnUpdatePass: UIButton!
    
    
    @IBOutlet weak var textPersnalInfoCCode: UITextField!
    @IBOutlet weak var lblPersnalInfoCCode: UILabel!
    
    //MARK:- comp outlets
    
    @IBOutlet weak var lblCompanyCCode: UILabel!
    @IBOutlet weak var textCompanyCCode: UITextField!
    
    @IBOutlet weak var lblCompnyPO: UILabel!
    @IBOutlet weak var btnCompnyPO: UIButton!
    @IBOutlet weak var textCompnyPO: CustomTextField!
    
    @IBOutlet weak var lblPrivateCriminalRecord: UILabel!
    @IBOutlet weak var btnPrivateCrimalRecord: UIButton!
    @IBOutlet weak var textPrivateCriminalRecord: CustomTextField!
    
    @IBOutlet weak var lblPrivateOP: UILabel!
    @IBOutlet weak var btnPribateOP: UIButton!
    @IBOutlet weak var textPrivateOP: CustomTextField!
    
    @IBOutlet weak var lblCompAddress: UILabel!
    @IBOutlet weak var textCompAdd: CustomTextField!
    
    @IBOutlet weak var lblCompPostCode: UILabel!
    @IBOutlet weak var textCompPost: CustomTextField!
    
    @IBOutlet weak var btnCompState: UIButton!
    @IBOutlet weak var lblCompState: UILabel!
    @IBOutlet weak var textCompState: CustomTextField!

    @IBOutlet weak var btnCompCity: UIButton!
    @IBOutlet weak var lblCompCity: UILabel!
    @IBOutlet weak var textCompCity: CustomTextField!

    @IBOutlet weak var btnCompCountry: UIButton!
    @IBOutlet weak var lblCompCountry: UILabel!
    @IBOutlet weak var textCCountry: CustomTextField!

    @IBOutlet weak var lblCompMobile: UILabel!
    @IBOutlet weak var textCompMobile: CustomTextField!
    
    @IBOutlet weak var lblCompEmail: UILabel!
    @IBOutlet weak var textCompEmail: CustomTextField!

    @IBOutlet weak var lblCiceroNo: UILabel!
    @IBOutlet weak var textCireoNo: CustomTextField!

    @IBOutlet weak var lblFirmNo: UILabel!
    @IBOutlet weak var textFiemNo: CustomTextField!
    @IBOutlet weak var btnUpdateProfile: UIButton!
    
    //MARK:- Variables
    
    var addNewAgentViewModel = AddNewAgentViewModel()
    
    var profileModelClass = ProfileViewModel()
    var customCountryDDView : CustomCountryDDView!
    
    var drpDownCounrtyListArray = [CountryModel]()
    var drpDownStateListArray = [StateModel]()
    var drpDownCityListArray = [CityModel]()
    var datePicker = UIDatePicker()
    
    var newDrpDownCounrtyListArray = [DrpDownListStruct]()
    var newDrpDownStateListArray = [DrpDownListStruct]()
    var newDrpDownCityListArray = [DrpDownListStruct]()
    
    var selectedTxtFieldTag = 0
    
    var setLocality = ""
    var agentId = ""
    var agentDob = ""
    var isCommingFrom = ""
    var pickedImageUrl:URL?
    var picker = UIImagePickerController()
    var selectedTf: UITextField!
    var profileImage = ""
    
    var privateCriminalRecord = ""
    var privateOP = ""
    var companyPO = ""
    
    var countryPickerView: CountryPickerView?
    var selectedCountryCodePicker = ""

    
    //For set updatephone and email title underline
    var attrs = [
        NSAttributedString.Key.font : FontSize.size16 ?? UIFont.systemFont(ofSize: 15.0),
        NSAttributedString.Key.foregroundColor : Asset.Colors.lightBlue.color ,
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
    //    var attributedString = NSMutableAttributedString(string:"")
    var attributedEmailStr = NSMutableAttributedString(string:"")
    var attributedPhoneStr = NSMutableAttributedString(string:"")
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        textPersnalInfoCCode.isUserInteractionEnabled = false
        btnUpdateCompEmail.setTitle("Update Email Address".localized(), for: .normal)
        btnUpdateCompMobile.setTitle("Update Phone Number".localized(), for: .normal)
        btnUpdateCompEmail.titleLabel?.numberOfLines = 2
        btnUpdateCompMobile.titleLabel?.numberOfLines = 2

        if userType as! String == "AGENT" {
            self.viewCompPO.isHidden = true
            self.viewPrivateOP.isHidden = true
            self.viewPrivateCriminalRecord.isHidden = true
            btnCompanyInfo.isHidden = true
            companyInfoBackView.isHidden = true
            btnUpdatetEmailId.isHidden = false
            btnUpdatetPhoneNumber.isHidden = false
            textPhone.isUserInteractionEnabled = false
            textEmail.isUserInteractionEnabled = false
            btnSelectCountyCode.isUserInteractionEnabled = false

            setUpView()
        }else {
            btnCompanyInfo.isHidden = false
            companyInfoBackView.isHidden = true
            self.viewCompPO.isHidden = false
            self.viewPrivateOP.isHidden = false
            self.viewPrivateCriminalRecord.isHidden = false
            textPhone.isUserInteractionEnabled = true
            textEmail.isUserInteractionEnabled = true
            btnSelectCountyCode.isUserInteractionEnabled = true
            btnUpdatetEmailId.isHidden = true
            btnUpdatetPhoneNumber.isHidden = true
            setUpView()
        }
        
        if isCommingFrom == "Edit_agent_detail"{
            btnCompanyInfo.isHidden = true
            btnUpdateProfile.isUserInteractionEnabled = false
            btnUpdatetEmailId.isHidden = false
            btnUpdatetPhoneNumber.isHidden = false
            btnUpdatetEmailId.isHidden = true
            
            textPhone.isUserInteractionEnabled = false
            textEmail.isUserInteractionEnabled = true
            
            btnSelectCountyCode.isUserInteractionEnabled = false
            tabBarController?.tabBar.isHidden = true
        }
        
        if isCommingFrom == "Edit_agent_detail"
        {
            self.agentCommission1BackView.isHidden = false
            self.agentCommission2BackView.isHidden = false
            checkNetworkForAgentDetailApi()
        }
        else
        {
            self.agentCommission1BackView.isHidden = true
            self.agentCommission2BackView.isHidden = true
            //Profile Detail Api call here
            let LTY_UserDefaults = UserDefaults.standard
            let token = LTY_UserDefaults.value(forKey: "token") as? String
            print(token ?? "")
            if token != "" {
                checkNetworkForProfileDetailApi(tokenStr: token ?? "")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if isCommingFrom == "Edit_agent_detail"{
            tabBarController?.tabBar.isHidden = false
            btnUpdateProfile.isUserInteractionEnabled = true
           // btnCompanyInfo.isHidden = false

        }
        
        if showNavDrower == true {
            showNavDrower = false

        }
        
    }

    //MARK:- Didload func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textPersnalInfoCCode.delegate = self
        textCompanyCCode.delegate = self
        configCountryCodePicker()
        
        showNavDrower = false
        setUpView()
        setDrowerHeight()
        setNavigationDrower()
        imgUserImage.makeRounded()
        textDOB.delegate = self
        addNewAgentViewModel.delegate = self
        profileModelClass.delegate = self
        addNewAgentViewModel.getCountryListApi()
        
        if isCommingFrom == "Edit_agent_detail"
        {
            self.agentCommission1BackView.isHidden = false
            self.agentCommission2BackView.isHidden = false
            checkNetworkForAgentDetailApi()
        }
        else
        {
            self.agentCommission1BackView.isHidden = true
            self.agentCommission2BackView.isHidden = true
            //Profile Detail Api call here
            let LTY_UserDefaults = UserDefaults.standard
            let token = LTY_UserDefaults.value(forKey: "token") as? String
            print(token ?? "")
            if token != ""
            {
                checkNetworkForProfileDetailApi(tokenStr: token ?? "")
            }
        }
    
        //Add observer for update mobile and email
        NotificationCenter.default.addObserver(self, selector: #selector(handlesNotification(_:)), name: NSNotification.Name(rawValue: "updateEmailPhone"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfileData(_:)), name: NSNotification.Name(rawValue: "UpdateProfileData"), object: nil)
        

//        attributedPhoneStr.append(NSMutableAttributedString(string:LTYText.textProfileVCUpdatePhone, attributes:attrs))
//        attributedEmailStr.append(NSMutableAttributedString(string:LTYText.textProfileVCUpdateEmail, attributes:attrs))
    }
    
    @objc func updateProfileData(_ sender: Notification) {
        
        let senderData = sender.userInfo
        let userType = kUserDefaults.value(forKey:AppKeys.userType) as! String
        if let data = senderData as? [String: String] {
            
            let dataEmail = data["UpdateProfileData"]

            if dataEmail != nil{
                if isCommingFrom == "Edit_agent_detail" {
       
                    checkNetworkForAgentDetailApi()
                }
                else {

                    let LTY_UserDefaults = UserDefaults.standard
                    let token = LTY_UserDefaults.value(forKey: "token") as? String
                    print(token ?? "")
                    if token != ""
                    {
                        checkNetworkForProfileDetailApi(tokenStr: token ?? "")
                    }
                }
  print("update Profile success")
            }

        }
    }
    
    @objc func handlesNotification(_ sender: Notification) {
        
        let senderData = sender.userInfo
        let userType = kUserDefaults.value(forKey:AppKeys.userType) as! String
        if let data = senderData as? [String: String] {
            
            let dataEmail = data["email"]
            let dataMobile = data["mobile"]
            let countryCode = data["countryCode"]

            if dataEmail != nil{
              if isCommingFrom == "Edit_agent_detail" {
                    self.textEmail.text = dataEmail
                }
                if userType == "AGENT" {
                    self.textEmail.text = dataEmail

                }
                else{
                    self.textCompEmail.text = dataEmail
                    //self.textEmail.text = dataEmail
                }
            }
            if dataMobile != nil{
                  if isCommingFrom == "Edit_agent_detail" {
                    self.textPhone.text = dataMobile
                     self.textPersnalInfoCCode.text = countryCode
                    
                }
                if userType == "AGENT" {
                    self.textPhone.text = dataMobile
                     self.textPersnalInfoCCode.text = countryCode
                }else{
                    self.textCompMobile.text = dataMobile
                    self.textCompanyCCode.text = countryCode
                    
                }
           


            }
        }
    }
    
    // MARK:- SetNavigation Drower
    
    func setNavigationDrower() {
        
        customNavigationBarForDrawer.titleLabel.textAlignment = .center
        
        if isCommingFrom == "Edit_agent_detail" {
            customNavigationBarForDrawer.titleLabel.text = "Agent Detail".localized()
            txtCompReserve.isUserInteractionEnabled = false
            txtAgentReserve.isUserInteractionEnabled = false
            txtAgentCommision.isUserInteractionEnabled = false
            tabBarController?.tabBar.isHidden = true
            
            customNavigationBarForDrawer.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
            customNavigationBarForDrawer.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        }
        else if isCommingFrom == "Notification"{
            customNavigationBarForDrawer.titleLabel.text = "Profile".localized()
            txtCompReserve.isUserInteractionEnabled = true
            txtAgentReserve.isUserInteractionEnabled = true
            txtAgentCommision.isUserInteractionEnabled = true
            tabBarController?.tabBar.isHidden = true
            
            customNavigationBarForDrawer.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
            customNavigationBarForDrawer.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        }
        else {
            
            txtCompReserve.isUserInteractionEnabled = true
            txtAgentReserve.isUserInteractionEnabled = true
            txtAgentCommision.isUserInteractionEnabled = true
            customNavigationBarForDrawer.titleLabel.text = "Profile".localized()
            
            tabBarController?.tabBar.isHidden = false
            
            customNavigationBarForDrawer.leftSideMenuButtonItem.setImage(Asset.Assets.menu.image, for: .normal)
            customNavigationBarForDrawer.leftSideMenuButtonItem.addTarget(self, action: #selector(didTapMenuButton(_:)), for: .touchUpInside)
            kUserDefaults.set("ProfileTab", forKey: AppKeys.tabName)
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
    
 
    //MARK:- Back Action Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    
     //MARK:- Open  Gallary
     
     @IBAction func openGallaryActionBtn(_ sender: UIButton) {
         self.openGalary()
     }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
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
        components.calendar = calendar
        
        components.year = -150
        comps.year = -16
        let minDate = calendar.date(byAdding: components, to: Date())
        let maxDate = calendar.date(byAdding: comps, to: Date())
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate//Date()
        
//        components.year = -150
//        let minDate = calendar.date(byAdding: components, to: Date())
//        datePicker.minimumDate = minDate
//
//        datePicker.maximumDate = Date()
//
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //  use this case for set date in multiple textfiled using same picker
        
        
        textDOB.inputView = datePicker
        textDOB.inputAccessoryView = toolbar
        
    }
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"//"dd MMMM yyyy"
       
        agentDob = "\(formatter.string(from: datePicker.date))"
        
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd.MM.yyyy"
    
        textDOB.text = formatter1.string(from: datePicker.date)
        
        self.view.endEditing(true)
        
    }
    
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    
    
    
    func checkNetworkUpdate(params:EditAgentModel, isCommings: String) {
        
        if internetConnection.isConnectedToNetwork() == true {
            addNewAgentViewModel.updateAgentApi(param: params, isCommingFrom: isCommings)
        }
        else {
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert)
        }
    }
    
    //MARK:- SetUpView
    
    func setUpView () {
        //customNavigationBarForDrawer.titleLabel.text = "Profile"
       
        
        personalInfoBackView.isHidden   = false
        companyInfoBackView.isHidden    = true
        bankInfoBackView.isHidden       = true
        changePassBackView.isHidden     = true
        
        
        lblBankCity.font             = FontSize.size16
        lblBankCity.textColor        = Asset.Colors.gray1.color
        textBankCity.font              = FontSize.size16
        textBankCity.textColor         = Asset.Colors.darkGrayColor.color
        textBankCity.backgroundColor   = Asset.Colors.grayColor.color
        
        lblBankState.font             = FontSize.size16
        lblBankState.textColor        = Asset.Colors.gray1.color
        textBankSate.font              = FontSize.size16
        textBankSate.textColor         = Asset.Colors.darkGrayColor.color
        textBankSate.backgroundColor   = Asset.Colors.grayColor.color
        
        
        lblPersnalInfoCCode.font             = FontSize.size16
        lblPersnalInfoCCode.textColor        = Asset.Colors.gray1.color
        textPersnalInfoCCode.font              = FontSize.size16
        textPersnalInfoCCode.textColor         = Asset.Colors.darkGrayColor.color
        textPersnalInfoCCode.backgroundColor   = Asset.Colors.grayColor.color
        
        
        lblCompanyCCode.font             = FontSize.size16
        lblCompanyCCode.textColor        = Asset.Colors.gray1.color
        textCompanyCCode.font              = FontSize.size16
        textCompanyCCode.textColor         = Asset.Colors.darkGrayColor.color
        textCompanyCCode.backgroundColor   = Asset.Colors.grayColor.color
        
        //Agent Commision
        labelAgentComission.font             = FontSize.size16
        labelAgentComission.textColor        = Asset.Colors.gray1.color
        labelAgentComission.text             = LTYText.agentCommision.localized()
        txtAgentCommision.font              = FontSize.size16
        txtAgentCommision.textColor         = Asset.Colors.darkGrayColor.color
        txtAgentCommision.backgroundColor   = Asset.Colors.grayColor.color
        labelAgentComission.makeTextMandatory()
        
        //CommissionReservve
        
        labelCompReserve.font             = FontSize.size16
        labelCompReserve.textColor        = Asset.Colors.gray1.color
        labelCompReserve.text             = LTYText.compReserve.localized()
        txtCompReserve.font              = FontSize.size16
        txtCompReserve.textColor         = Asset.Colors.darkGrayColor.color
        txtCompReserve.backgroundColor   = Asset.Colors.grayColor.color
        labelCompReserve.makeTextMandatory()
        
        // profile
        labelProfile.font             = FontSize.size16
        labelProfile.textColor        = Asset.Colors.gray1.color
        labelProfile.text             = LTYText.profile.localized()
        txtProfile.font              = FontSize.size16
        txtProfile.textColor         = Asset.Colors.darkGrayColor.color
        txtProfile.backgroundColor   = Asset.Colors.grayColor.color
        labelProfile.makeTextMandatory()
        
        //Agent Reserve
        labelAgentReserve.font             = FontSize.size16
        labelAgentReserve.textColor        = Asset.Colors.gray1.color
        labelAgentReserve.text             = LTYText.agentReserve.localized()
        txtAgentReserve.font              = FontSize.size16
        txtAgentReserve.textColor         = Asset.Colors.darkGrayColor.color
        txtAgentReserve.backgroundColor   = Asset.Colors.grayColor.color
        labelAgentReserve.makeTextMandatory()
        
        // 1
        labelFirstName.font             = FontSize.size16
        labelFirstName.textColor        = Asset.Colors.gray1.color
        labelFirstName.text             = LTYText.textSignUpVCFName.localized()
        textFirstName.font              = FontSize.size16
        textFirstName.textColor         = Asset.Colors.darkGrayColor.color
        textFirstName.backgroundColor   = Asset.Colors.grayColor.color
        labelFirstName.makeTextMandatory()
        
        labelLastName.font              = FontSize.size16
        labelLastName.textColor         = Asset.Colors.gray1.color
        labelLastName.text              = LTYText.textSignUpVCLName.localized()
        textLastName.font               = FontSize.size16
        textLastName.textColor          = Asset.Colors.darkGrayColor.color
        textLastName.backgroundColor    = Asset.Colors.grayColor.color
        labelLastName.makeTextMandatory()
        
        labelPhone.font                 = FontSize.size16
        labelPhone.textColor            = Asset.Colors.gray1.color
        labelPhone.text                 = LTYText.textSignUpVCPhone.localized()
        textPhone.font                  = FontSize.size16
        textPhone.textColor             = Asset.Colors.darkGrayColor.color
        textPhone.backgroundColor       = Asset.Colors.grayColor.color
        labelPhone.makeTextMandatory()
        //btnUpdatetPhoneNumber.setTitle(LTYText.textProfileVCUpdatePhone, for: .normal)
     //   attributedPhoneStr.append(NSMutableAttributedString(string:LTYText.textProfileVCUpdatePhone, attributes:attrs))
       // btnUpdatetPhoneNumber.setAttributedTitle(attributedPhoneStr, for: .normal)
        
        labelDOB.font                 = FontSize.size16
        labelDOB.textColor            = Asset.Colors.gray1.color
        labelDOB.text                 = LTYText.textProfileUpVCDOB.localized()
        textDOB.font                  = FontSize.size16
        textDOB.textColor             = Asset.Colors.darkGrayColor.color
        textDOB.backgroundColor       = Asset.Colors.grayColor.color
        labelDOB.makeTextMandatory()
        
        labelEmail.font                 = FontSize.size16
        labelEmail.textColor            = Asset.Colors.gray1.color
        labelEmail.text                 = LTYText.textSignUpVCEmail.localized()
        textEmail.font                  = FontSize.size16
        textEmail.textColor             = Asset.Colors.darkGrayColor.color
        textEmail.backgroundColor       = Asset.Colors.grayColor.color
        labelEmail.makeTextMandatory()
        //btnUpdatetEmailId.setTitle(LTYText.textProfileVCUpdateEmail, for: .normal)
//        attributedEmailStr.append(NSMutableAttributedString(string:LTYText.textProfileVCUpdateEmail, attributes:attrs))
//        btnUpdatetEmailId.setAttributedTitle(attributedEmailStr, for: .normal)
        
        labelAddress.font               = FontSize.size16
        labelAddress.textColor          = Asset.Colors.gray1.color
        labelAddress.text               = LTYText.textSignUpVCAddress.localized()
        textAddress.font                = FontSize.size16
        textAddress.textColor           = Asset.Colors.darkGrayColor.color
        textAddress.backgroundColor     = Asset.Colors.grayColor.color
        labelAddress.makeTextMandatory()
        
        labelCountry.font               = FontSize.size16
        labelCountry.textColor          = Asset.Colors.gray1.color
        labelCountry.text               = LTYText.textSignUpVCCountry.localized()
        textCountry.font                = FontSize.size16
        textCountry.textColor           = Asset.Colors.darkGrayColor.color
        textCountry.backgroundColor     = Asset.Colors.grayColor.color
        textCountry.placeholder         = LTYText.textSignUpVCCountryPlaceHolder
        labelCountry.makeTextMandatory()
        
        labelState.font                 = FontSize.size16
        labelState.textColor            = Asset.Colors.gray1.color
        labelState.text                 = LTYText.textSignUpVCState.localized()
        textState.font                  = FontSize.size16
        textState.textColor             = Asset.Colors.darkGrayColor.color
        textState.backgroundColor       = Asset.Colors.grayColor.color
        textState.placeholder         = LTYText.textSignUpVCStatePlaceHolder
        labelState.makeTextMandatory()
        
        labelCity.font                  = FontSize.size16
        labelCity.textColor             = Asset.Colors.gray1.color
        labelCity.text                  = LTYText.textSignUpVCCity.localized()
        textCity.font                   = FontSize.size16
        textCity.textColor              = Asset.Colors.darkGrayColor.color
        textCity.backgroundColor        = Asset.Colors.grayColor.color
        textCity.placeholder            = LTYText.textSignUpVCCityPlaceHolder
        labelCity.makeTextMandatory()
        
        labelPostCode.font              = FontSize.size16
        labelPostCode.textColor         = Asset.Colors.gray1.color
        labelPostCode.text              = LTYText.textSignUpVCPostCode.localized()
        textPostCode.font               = FontSize.size16
        textPostCode.textColor          = Asset.Colors.darkGrayColor.color
        textPostCode.backgroundColor    = Asset.Colors.grayColor.color
        labelPostCode.makeTextMandatory()
        
        labelLanguage.font              = FontSize.size16
        labelLanguage.textColor         = Asset.Colors.gray1.color
        labelLanguage.text              = LTYText.textSignUpVCLanguage.localized()
        textLanguage.font               = FontSize.size16
        textLanguage.textColor          = Asset.Colors.darkGrayColor.color
        textLanguage.backgroundColor    = Asset.Colors.grayColor.color
        textLanguage.placeholder        = LTYText.textSignUpVCLanguagePlaceHolder
        labelLanguage.makeTextMandatory()
        
        labelNationality.font           = FontSize.size16
        labelNationality.textColor      = Asset.Colors.gray1.color
        labelNationality.text           = LTYText.textSignUpVCNationality.localized()
        textNationality.font            = FontSize.size16
        textNationality.textColor       = Asset.Colors.darkGrayColor.color
        textNationality.backgroundColor = Asset.Colors.grayColor.color
        textNationality.placeholder     = LTYText.textSignUpVCNationalityPlaceHolder
        labelNationality.makeTextMandatory()
        
        //2
        labelCompanyName.font             = FontSize.size16
        labelCompanyName.textColor        = Asset.Colors.gray1.color
        labelCompanyName.text             = LTYText.textSignUpVCComName.localized()
        textCompanyName.font              = FontSize.size16
        textCompanyName.textColor         = Asset.Colors.darkGrayColor.color
        textCompanyName.backgroundColor   = Asset.Colors.grayColor.color
        labelCompanyName.makeTextMandatory()
        
        labelWebSite.font             = FontSize.size16
        labelWebSite.textColor        = Asset.Colors.gray1.color
        labelWebSite.text             = LTYText.textSignUpVCBusWebsite.localized()
        textWebSite.font              = FontSize.size16
        textWebSite.textColor         = Asset.Colors.darkGrayColor.color
        textWebSite.backgroundColor   = Asset.Colors.grayColor.color
      //  labelWebSite.makeTextMandatory()
        
        //3
        labelIBAN.font              = FontSize.size16
        labelIBAN.textColor         = Asset.Colors.gray1.color
        labelIBAN.text              = LTYText.textSignUpVCIBAN.localized()
        textIBAN.font               = FontSize.size16
        textIBAN.textColor          = Asset.Colors.darkGrayColor.color
        textIBAN.backgroundColor    = Asset.Colors.grayColor.color
        
        labelSwiftBIC.font                 = FontSize.size16
        labelSwiftBIC.textColor            = Asset.Colors.gray1.color
        labelSwiftBIC.text                 = LTYText.textSignUpVCSBIC.localized()
        textSwiftBIC.font                  = FontSize.size16
        textSwiftBIC.textColor             = Asset.Colors.darkGrayColor.color
        textSwiftBIC.backgroundColor       = Asset.Colors.grayColor.color
        
        labelBank.font                 = FontSize.size16
        labelBank.textColor            = Asset.Colors.gray1.color
        labelBank.text                 = LTYText.textSignUpVCBank.localized()
        textBank.font                  = FontSize.size16
        textBank.textColor             = Asset.Colors.darkGrayColor.color
        textBank.backgroundColor       = Asset.Colors.grayColor.color
        
        labelCompAddress.font               = FontSize.size16
        labelCompAddress.textColor          = Asset.Colors.gray1.color
        labelCompAddress.text               = LTYText.textSignUpVCComAddress.localized()
        textCompAddress.font                = FontSize.size16
        textCompAddress.textColor           = Asset.Colors.darkGrayColor.color
        textCompAddress.backgroundColor     = Asset.Colors.grayColor.color
        
        labelCompPostCode.font              = FontSize.size16
        labelCompPostCode.textColor         = Asset.Colors.gray1.color
        labelCompPostCode.text              = LTYText.textSignUpVCComPostCode.localized()
        textCompPostCode.font               = FontSize.size16
        textCompPostCode.textColor          = Asset.Colors.darkGrayColor.color
        textCompPostCode.backgroundColor    = Asset.Colors.grayColor.color
        
        labelCompCountry.font               = FontSize.size16
        labelCompCountry.textColor          = Asset.Colors.gray1.color
        labelCompCountry.text               = LTYText.textSignUpVCComCountry.localized()
        textBankCountry.font                = FontSize.size16
        textBankCountry.textColor           = Asset.Colors.darkGrayColor.color
        textBankCountry.backgroundColor     = Asset.Colors.grayColor.color
        textBankCountry.placeholder         = LTYText.textSignUpVCComCountryPlaceHolder
        
        // 4
        labelOldPass.font             = FontSize.size16
        labelOldPass.textColor        = Asset.Colors.gray1.color
        labelOldPass.text             = LTYText.textProfileUpVCOldPass.localized()
        textOldPass.font              = FontSize.size16
        textOldPass.textColor         = Asset.Colors.darkGrayColor.color
        textOldPass.backgroundColor   = Asset.Colors.grayColor.color
        textOldPass.placeholder       = LTYText.textProfileUpVCOldPass
        labelOldPass.makeTextMandatory()
        
        labelNewPass.font             = FontSize.size16
        labelNewPass.textColor        = Asset.Colors.gray1.color
        labelNewPass.text             = LTYText.textProfileUpVCNewPass.localized()
        textNewPass.font              = FontSize.size16
        textNewPass.textColor         = Asset.Colors.darkGrayColor.color
        textNewPass.backgroundColor   = Asset.Colors.grayColor.color
        textNewPass.placeholder       = LTYText.textProfileUpVCNewPass
        labelNewPass.makeTextMandatory()
        
        labelConfirmPass.font              = FontSize.size16
        labelConfirmPass.textColor         = Asset.Colors.gray1.color
        labelConfirmPass.text              = LTYText.textSignUpVCConfPass.localized()
        textConfirmPass.font               = FontSize.size16
        textConfirmPass.textColor          = Asset.Colors.darkGrayColor.color
        textConfirmPass.backgroundColor    = Asset.Colors.grayColor.color
        textConfirmPass.placeholder        = LTYText.textSignUpVCConfPassPlaceHolder
        labelConfirmPass.makeTextMandatory()
        
        //MARK:- compny Details
        
        lblCompAddress.font                 = FontSize.size16
        lblCompAddress.textColor            = Asset.Colors.gray1.color
        lblCompAddress.text                 = LTYText.text_AgentAddress.localized()
        textCompAdd.font                  = FontSize.size16
        textCompAdd.textColor             = Asset.Colors.darkGrayColor.color
        textCompAdd.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompPostCode.font                 = FontSize.size16
        lblCompPostCode.textColor            = Asset.Colors.gray1.color
        lblCompPostCode.text                 = LTYText.textSignUpVCPostCode.localized()
        textCompPost.font                  = FontSize.size16
        textCompPost.textColor             = Asset.Colors.darkGrayColor.color
        textCompPost.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompState.font                 = FontSize.size16
        lblCompState.textColor            = Asset.Colors.gray1.color
        lblCompState.text                 = LTYText.textSignUpVCState.localized()
        textCompState.font                  = FontSize.size16
        textCompState.textColor             = Asset.Colors.darkGrayColor.color
        textCompState.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompCity.font                 = FontSize.size16
        lblCompCity.textColor            = Asset.Colors.gray1.color
        lblCompCity.text                 = LTYText.textSignUpVCCity.localized()
        textCompCity.font                  = FontSize.size16
        textCompCity.textColor             = Asset.Colors.darkGrayColor.color
        textCompCity.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompCountry.font                 = FontSize.size16
        lblCompCountry.textColor            = Asset.Colors.gray1.color
        lblCompCountry.text                 = LTYText.textSignUpVCCountry.localized()
        textCCountry.font                  = FontSize.size16
        textCCountry.textColor             = Asset.Colors.darkGrayColor.color
        textCCountry.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompMobile.font                 = FontSize.size16
        lblCompMobile.textColor            = Asset.Colors.gray1.color
        lblCompMobile.text                 = LTYText.textSignUpVCPhone.localized()
        textCompMobile.font                  = FontSize.size16
        textCompMobile.textColor             = Asset.Colors.darkGrayColor.color
        textCompMobile.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompEmail.font                 = FontSize.size16
        lblCompEmail.textColor            = Asset.Colors.gray1.color
        lblCompEmail.text                 = LTYText.textSignUpVCEmail.localized()
        textCompEmail.font                  = FontSize.size16
        textCompEmail.textColor             = Asset.Colors.darkGrayColor.color
        textCompEmail.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCiceroNo.font                 = FontSize.size16
        lblCiceroNo.textColor            = Asset.Colors.gray1.color
        lblCiceroNo.text                 = LTYText.textCircioNo.localized()
        textCireoNo.font                  = FontSize.size16
        textCireoNo.textColor             = Asset.Colors.darkGrayColor.color
        textCireoNo.backgroundColor       = Asset.Colors.grayColor.color
        
        lblFirmNo.font                 = FontSize.size16
        lblFirmNo.textColor            = Asset.Colors.gray1.color
        lblFirmNo.text                 = LTYText.textFirmNo.localized()
        textFiemNo.font                  = FontSize.size16
        textFiemNo.textColor             = Asset.Colors.darkGrayColor.color
        textFiemNo.backgroundColor       = Asset.Colors.grayColor.color
        
        lblPrivateCriminalRecord.font                 = FontSize.size16
        lblPrivateCriminalRecord.textColor            = Asset.Colors.gray1.color
        lblPrivateCriminalRecord.text                 = LTYText.textCriminalRecod.localized()
        textPrivateCriminalRecord.font                  = FontSize.size16
        textPrivateCriminalRecord.textColor             = Asset.Colors.darkGrayColor.color
        textPrivateCriminalRecord.backgroundColor       = Asset.Colors.grayColor.color
        
        lblPrivateOP.font                 = FontSize.size16
        lblPrivateOP.textColor            = Asset.Colors.gray1.color
        lblPrivateOP.text                 = LTYText.textPrivateOP.localized()
        textPrivateOP.font                  = FontSize.size16
        textPrivateOP.textColor             = Asset.Colors.darkGrayColor.color
        textPrivateOP.backgroundColor       = Asset.Colors.grayColor.color
        
        lblCompnyPO.font                 = FontSize.size16
        lblCompnyPO.textColor            = Asset.Colors.gray1.color
        lblCompnyPO.text                 = LTYText.textCompnyPO.localized()
        textCompnyPO.font                  = FontSize.size16
        textCompnyPO.textColor             = Asset.Colors.darkGrayColor.color
        textCompnyPO.backgroundColor       = Asset.Colors.grayColor.color
        
        
        //1
        btnPersonalInfoUpdate.viewCorner(8)
        btnPersonalInfoUpdate.backgroundColor = Asset.Colors.lightBlue.color
        btnPersonalInfoUpdate.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnPersonalInfoUpdate.setTitle(LTYText.textProfileVCUpdate.localized(), for: .normal)
        //2
        btnCompInfoUpdate.viewCorner(8)
        btnCompInfoUpdate.backgroundColor = Asset.Colors.lightBlue.color
        btnCompInfoUpdate.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnCompInfoUpdate.setTitle(LTYText.textProfileVCUpdate.localized(), for: .normal)
        //3
        btnBankInfoUpdate.viewCorner(8)
        btnBankInfoUpdate.backgroundColor = Asset.Colors.lightBlue.color
        btnBankInfoUpdate.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnBankInfoUpdate.setTitle(LTYText.textProfileVCUpdate.localized(), for: .normal)
        //4
        btnUpdatePass.viewCorner(8)
        btnUpdatePass.backgroundColor = Asset.Colors.lightBlue.color
        btnUpdatePass.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnUpdatePass.setTitle(LTYText.textProfileVCUpdate.localized(), for: .normal)
        
        setPersonalInfoBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
        setCompanyInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setBankingInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        
      /*
        if isCommingFrom == "Edit_agent_detail"
        {
            btnChangePassword.isHidden = true
            btnUpdatetEmailId.isHidden = true
            btnUpdatetPhoneNumber.isHidden = false
            textEmail.isUserInteractionEnabled = true
            textPhone.isUserInteractionEnabled = false
            textPersnalInfoCCode.isUserInteractionEnabled = false
            btnSelectCountyCode.isUserInteractionEnabled = false
        }
        else
        {
            btnChangePassword.isHidden = false
            setChangePasswordBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            btnUpdatetEmailId.isHidden = false
            btnUpdatetPhoneNumber.isHidden = false
            textEmail.isUserInteractionEnabled = false
            textPhone.isUserInteractionEnabled = false
            textPersnalInfoCCode.isUserInteractionEnabled = false
            btnSelectCountyCode.isUserInteractionEnabled = false
        }
        */
        
    }
    
    func setPersonalInfoBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnPersonalInfo.viewCorner(8)
        btnPersonalInfo.backgroundColor = backgroundColor
        btnPersonalInfo.setTitleColor(titleColor, for: .normal)
        btnPersonalInfo.setTitle(LTYText.textProfileVCPersonalInfo.localized(), for: .normal)
    }
    func setCompanyInfoBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnCompanyInfo.viewCorner(8)
        btnCompanyInfo.backgroundColor = backgroundColor
        btnCompanyInfo.setTitleColor(titleColor, for: .normal)
        btnCompanyInfo.setTitle(LTYText.textProfileVCCompanyInfo.localized(), for: .normal)
    }
    
    func setBankingInfoBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnBankingInfo.viewCorner(8)
        btnBankingInfo.backgroundColor = backgroundColor
        btnBankingInfo.setTitleColor(titleColor, for: .normal)
        btnBankingInfo.setTitle(LTYText.textProfileVCBankingInfo.localized(), for: .normal)
    }
    func setChangePasswordBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnChangePassword.viewCorner(8)
        btnChangePassword.backgroundColor = backgroundColor
        btnChangePassword.setTitleColor(titleColor, for: .normal)
        btnChangePassword.setTitle(LTYText.textProfileVCChangePassword.localized(), for: .normal)
    }
    
    //MARK:-  check internet Connection
    func checkNetworkForProfileDetailApi(tokenStr:String) {
        
        if internetConnection.isConnectedToNetwork() == true {
            let param :[String:Any]  = ["token":tokenStr]
            //profileModelClass.networkServiceCall(param:params)
            profileModelClass.profileDetailApi(param: param)
        }
        else {
            self.ShowAlert(message: "Please check your internet".localized())
        }
    }
    func checkNetworkForAgentDetailApi() {
        
        if internetConnection.isConnectedToNetwork() == true {
            let param :[String:Any]  = ["entityId":self.agentId, "entityType":"PARTNER_ID"]
            addNewAgentViewModel.agentEditDetailApi(param: param)
        }
        else {
            self.ShowAlert(message: "Please check your internet".localized())
        }
    }
    
    @IBAction func btnUpdateCompEmail(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePhoneEmailVC") as! UpdatePhoneEmailVC
        vc.agentId = agentId
        vc.modalPresentationStyle = .overCurrentContext
        vc.isCommingFrom = "update_email"
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func btnUpdateCopmanyMobile(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePhoneEmailVC") as! UpdatePhoneEmailVC
        vc.agentId = agentId
        vc.modalPresentationStyle = .overCurrentContext
        vc.isCommingFrom = "update_phone"
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    
    //MARK:- Update Phone/Email Id Btn Action
    @IBAction func btnUpdatePhoneEmailAction(_ sender: UIButton) {
        //501,502//
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePhoneEmailVC") as! UpdatePhoneEmailVC
        vc.agentId = agentId
        vc.modalPresentationStyle = .overCurrentContext
        if sender.tag == 502
        {
            vc.isCommingFrom = "update_email"
        }
        else
        {
            vc.isCommingFrom = "update_phone"
            
        }
        vc.delegate = self
        self.present(vc, animated: true)
        
    }
    //MARK:- Update Btn Action
    @IBAction func btnUpdateAction(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        switch sender.tag
        {
        case 101:
            checkPersonalInfoValidation()
        case 102:
            checkCompInfoValidation()
        case 103:
            checkBankInfoValidation()
        case 104:
            //                personalInfoBackView.isHidden   = true
            //                companyInfoBackView.isHidden    = true
            //                bankInfoBackView.isHidden       = true
            //                changePassBackView.isHidden     = false
            checkChangePassValidation()
        default:
            print("")
        }
        
        
    }
    //MARK:- check Personal Info all field text validation
    func checkPersonalInfoValidation() {
        
//        let agentReserveComm = Int(txtAgentReserve.text ?? "")
//        let companyReserve = Int(txtCompReserve.text ?? "")
//        let  agentCommission = Int(txtAgentCommision.text ?? "")
//
//        if txtAgentReserve.text != "" || txtCompReserve.text != "" || txtAgentCommision.text != "" {
//
//            if agentReserveComm ?? 0 > 100 {
//                self.ShowAlert(message: "agent Reserve should not be greater than 100".localized())
//                return
//            }
//
//            else if companyReserve ?? 0 > 100 {
//                self.ShowAlert(message: "company Reserve should not be greater than 100".localized())
//                return
//
//            }
//            else if agentCommission ?? 0 > 100 {
//                self.ShowAlert(message: "agent Commission should not be greater than 100".localized())
//                return
//
//            }
//        }
//        else{
//            guard let agentReserve = txtAgentReserve.text, !agentReserve.isEmpty else {
//                self.ShowAlert(message: LTY_AlterText.messageAgentReserve, title: LTY_AlterText.agentReserve)
//                return
//            }
//
//            guard let commisionReserve = txtCompReserve.text, !commisionReserve.isEmpty else {
//                self.ShowAlert(message: LTY_AlterText.messageCompnyReserve, title: LTY_AlterText.compReserve)
//                return
//            }
//
//            guard let agentCommision = txtAgentCommision.text, !agentCommision.isEmpty else {
//                self.ShowAlert(message: LTY_AlterText.messageAgentCommision, title: LTY_AlterText.agentCommision)
//                return
//            }
//        }
        
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
        guard let countryCode = textPersnalInfoCCode.text, !countryCode.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.countryCode, title: LTY_AlterText.alertCountryCode)
            return
        }
        guard let mobile = textPhone.text, !mobile.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageMobile, title: LTY_AlterText.mobile)
            return
        }
        guard mobile.isLengthValid(minLength: 9, maxLength: 12) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation, title: LTY_AlterText.mobile)
            return
        }
//        guard let dob = textDOB.text, !dob.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)
//            return
//        }
        if agentDob == ""{
            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)
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
            print("Contains only alphanumeric characters!")
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
        guard let language = textLanguage.text, !language.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageLanguage, title: LTY_AlterText.language)
            return
        }
        guard let nationality = textNationality.text, !nationality.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageNationality, title: LTY_AlterText.nationality)
            
            return
        }
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        if isCommingFrom == "Edit_agent_detail"
        {
            updateAgentDetailApiCall(isComming: "Edit_agent_detail")
            
        }
        else
        {
            updateAgentDetailApiCall(isComming: "profile_update")
            
        }
        
    }
    

    
    //MARK:- check Company Info all field text validation
    func checkCompInfoValidation() {
        
        guard let companyName = textCompanyName.text, !companyName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCompanyName, title: LTY_AlterText.companyName)
            return
        }
        
        if textWebSite.text != ""{
            
//            guard let website = textWebSite.text, !website.isEmpty else {
//                self.ShowAlert(message: LTY_AlterText.messageWebsite, title: LTY_AlterText.website)
//                return
//            }
            let website = textWebSite.text!
       
            guard  website.isValidUrl(url: website)else {
                self.ShowAlert(message: LTY_AlterText.messageValidWebsite.localized(), title: LTY_AlterText.website.localized())
                return
            }
         
        }
        

        guard let compEmail = textCompEmail.text?.trim() , !compEmail.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageEmail, title: LTY_AlterText.email)
            return
        }
        guard compEmail.isValidEmail() else {
            self.ShowAlert(message: LTY_AlterText.messageEmailVarification, title: LTY_AlterText.email)
            return
        }
//        guard let countryCode = textCompanyCCode.text, !countryCode.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.countryCode, title: LTY_AlterText.alertCountryCode)
//            return
//        }
        guard let compMobile = textCompMobile.text, !compMobile.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageMobile, title: LTY_AlterText.mobile)
            return
        }
        guard compMobile.isLengthValid(minLength: 9, maxLength: 12) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation, title: LTY_AlterText.mobile)
            return
        }
        
        if textCompPost.text == "" {
            
        }
        else {
            if let compPost = textCompPost.text {
                guard compPost.isLengthValid(minLength: 4, maxLength: 6) else  {
                    self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation, title: LTY_AlterText.postCode)
                    return
                }
            }
        }
     
        if textCompAdd.text != ""{
            
            if textCompAdd.text!.containsOnlyAlphanumeric() {
                print("Contains only alphanumeric characters!")
            } else {
                self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
                return
            }
        }
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        
        if isCommingFrom == "Edit_agent_detail"
        {
            updateAgentDetailApiCall(isComming: "Edit_agent_detail")
        }
        else
        {
            updateAgentDetailApiCall(isComming: "profile_update")
            
        }
    }
    
    func updateAgentDetailApiCall(isComming: String){
        
        var sourceID = ""
        var partnerId = ""
        
        if isComming == "Edit_agent_detail"
        {
            sourceID = kUserDefaults.value(forKey: "partnerID") as! String
            partnerId = "\(self.agentId)"
        }
        else
        {
            sourceID = LTY_SOURCE
            partnerId = kUserDefaults.value(forKey: "partnerID") as! String
        }
        
        let agentReserve    =  txtAgentReserve.text ?? ""
        let companyReserve    = txtCompReserve.text ?? ""
        let agentCommission    = txtAgentCommision.text ?? ""
        let  profile         = txtProfile.text ?? ""
        let dob              = agentDob
        
        let firstName       = textFirstName.text ?? ""
        let lastName        =  textLastName.text ?? ""
        let email           =  textEmail.text ?? ""
        let mobile          = textPhone.text ?? ""
        let countryCode      = textPersnalInfoCCode.text ?? ""
        let country         = textCountry.text ?? ""
        let state           = textState.text ?? ""
        let city            = textCity.text ?? ""
        let address         = textAddress.text ?? ""
        let postCode        = textPostCode.text ?? ""
        let language        = textLanguage.text ?? ""
        let nationality     = textNationality.text ?? ""
        
         //MARK:- bank params
        
        let bankAddress     = textCompAddress.text ?? ""
        let bankPostCode    = textCompPostCode.text ?? ""
        let bankCountry     = textBankCountry.text ?? ""
        let bankState     = textBankSate.text ?? ""
        let bankCity     = textBankCity.text ?? ""
        let iban            = textIBAN.text ?? ""
        let swift           = textSwiftBIC.text ?? ""
        let bank            = textBank.text ?? ""
        
        //MARK:- company params
        
        let companyName     = textCompanyName.text ?? ""
        let website         = textWebSite.text ?? ""
        let finamNo = textFiemNo.text ?? ""
        let carcioNo = textCireoNo.text ?? ""
        let compPhone = textCompMobile.text ?? ""
        let compCountCode = textCompanyCCode.text ?? ""
        var compEmail = textCompEmail.text ?? ""
        let compCity = textCompCity.text ?? ""
        let compState = textCompState.text ?? ""
        let compAddress     = textCompAdd.text ?? ""
        let compPostCode    = textCompPost.text ?? ""
        let compCountry     = textCCountry.text ?? ""
        
        if kUserDefaults.value(forKey: AppKeys.profile) != nil {
            let profileImage1 = kUserDefaults.value(forKey: AppKeys.profile) as! String
            
            if profileImage1.isEmpty == false{
                profileImage = profileImage1
            }else{
                profileImage = ""
            }
        }

        
        if isComming == "Edit_agent_detail"{
            compEmail = ""
            checkNetworkUpdate(params: EditAgentModel(partnerId: partnerId, profilePic: profileImage, profile: profile, firstName: firstName, lastName: lastName, mobile: mobile, countryCode: countryCode, email: email, dob: dob, password: "", country: country, state: state, city: city, address: address, gender: "", postCode: postCode, language: language, nationality: nationality, roleType: "", roleId: "", companyDetails: EditCompanyDetails.init(companyName: companyName, website: website, logo: "", finamNo:finamNo, ciceroNo:carcioNo, email:compEmail, telephone:compPhone, countryCode: compCountCode,country: compCountry, state:compState, city:compCity, address: compAddress, postCode: compPostCode, privateCriminalRecord: privateCriminalRecord, privateOp:privateOP, companyPo: companyPO), commissionDetails: EditCommissionDetails.init(agentReserve: agentReserve, companyReserve: companyReserve, agentCommission: agentCommission), bankDetails: EditBankDetails.init(iban: iban, swift: swift, bank: bank, country:bankCountry,state:bankState ,city:bankCity, postCode:bankPostCode, address: bankAddress), source: sourceID),isCommings:isComming)
        } else {
            
            
            
            checkNetworkUpdate(params: EditAgentModel(partnerId: partnerId, profilePic: profileImage, profile: profile, firstName: firstName, lastName: lastName, mobile: compPhone, countryCode: compCountCode, email: compEmail, dob: dob, password: "", country: country, state: state, city: city, address: address, gender: "", postCode: postCode, language: language, nationality: nationality, roleType: "", roleId: "", companyDetails: EditCompanyDetails.init(companyName: companyName, website: website, logo: "", finamNo:finamNo, ciceroNo:carcioNo, email:email, telephone:mobile, countryCode: countryCode,country: compCountry, state:compState, city:compCity, address: compAddress, postCode: compPostCode, privateCriminalRecord: privateCriminalRecord, privateOp:privateOP, companyPo: companyPO), commissionDetails: EditCommissionDetails.init(agentReserve: agentReserve, companyReserve: companyReserve, agentCommission: agentCommission), bankDetails: EditBankDetails.init(iban: iban, swift: swift, bank: bank, country:bankCountry,state:bankState ,city:bankCity, postCode:bankPostCode, address: bankAddress), source: sourceID),isCommings:isComming)
        }
        
//        checkNetworkUpdate(params: EditAgentModel(partnerId: partnerId, profilePic: profileImage, profile: profile, firstName: firstName, lastName: lastName, mobile: mobile, countryCode: countryCode, email: email, dob: dob, password: "", country: country, state: state, city: city, address: address, postCode: postCode, language: language, nationality: nationality, roleType: "", roleId: "", companyDetails: EditCompanyDetails.init(companyName: companyName, website: website, logo: "", finamNo:finamNo, ciceroNo:carcioNo, email:compEmail, telephone:compPhone,country: compCountry, state:compState, city:compCity, address: compAddress, postCode: compPostCode, privateCriminalRecord: privateCriminalRecord, privateOp:privateOP, companyPo: companyPO), commissionDetails: EditCommissionDetails.init(agentReserve: agentReserve, companyReserve: companyReserve, agentCommission: agentCommission), bankDetails: EditBankDetails.init(iban: iban, swift: swift, bank: bank, country:bankCountry, postCode:bankPostCode, address: bankAddress), source: sourceID),isCommings:isComming)
        
     /*
        checkNetworkUpdate(params: EditAgentModel(partnerId: partnerId, profilePic: profileImage, firstName: firstName, lastName: lastName, mobile: mobile, countryCode: countryCode, email: email, dob: dob, password: "", country: country, state: state, city: city, address: address, postCode: postCode, language: language, nationality: nationality, roleType: "", roleId: "", companyDetails: EditCompanyDetails.init(companyName: companyName, website: website, logo: "", finamNo:finamNo, ciceroNo:carcioNo, email:compEmail, telephone:compPhone,country: compCountry, state:compState, city:compCity, address: compAddress, postCode: compPostCode, privateCriminalRecord: self.textPrivateCriminalRecord.text!, privateOp: self.textPrivateOP.text!, companyPo: self.textCompnyPO.text!), commissionDetails: EditCommissionDetails.init(agentReserve: agentReserve, companyReserve: companyReserve, agentCommission: agentCommission), bankDetails: EditBankDetails.init(iban: iban, swift: swift, bank: bank, country:bankCountry, postCode:bankPostCode, address: bankAddress), source: sourceID),isCommings:isComming)
        */
    }
    
    
    //MARK:- check Bank Info all field text validation
    func checkBankInfoValidation() {
        
//        guard let compAddress = textCompAddress.text, !compAddress.isEmpty else {
//            self.ShowAlert(message: "Please enter your Company Address", title: "Company Address")
//            return
//        }
//        guard let compPostCode = textCompPostCode.text, !compPostCode.isEmpty else {
//            self.ShowAlert(message: "Please enter your company PostCode", title: "Company PostCode")
//            return
//        }
//
//        guard compPostCode.isLengthValid(minLength: 4, maxLength: 6) else  {
//            self.ShowAlert(message: LTY_AlterText.messageMobileValidation, title: LTY_AlterText.messagePostCodeValidation)
//            return
//        }
//
//        guard let compCountry = textCompCountry.text, !compCountry.isEmpty else {
//            self.ShowAlert(message: "Please enter your company country".localized(), title: "Company Country".localized())
//            return
//        }
//        guard  let iban = textIBAN.text, !iban.isEmpty else {
//            self.ShowAlert(message: "Please enter your iban".localized(), title: "IBAN".localized())
//            return
//        }
//        guard  let swift = textSwiftBIC.text, !swift.isEmpty else {
//            self.ShowAlert(message: "Please enter your swift".localized(), title: "Swift".localized())
//            return
//        }
//        guard  let bank = textBank.text, !bank.isEmpty else {
//            self.ShowAlert(message: "Please enter your bank".localized(), title: "Bank".localized())
//            return
//        }
        if textCompAddress.text != ""{
            
   
            if textCompAddress.text!.containsOnlyAlphanumeric() {
                print("Contains only alphanumeric characters!")
            } else {
                self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
                return
            }
        }
        
        if textCompPostCode.text != ""{
            let postCode = textCompPostCode.text!
            guard postCode.isLengthValid(minLength: 4, maxLength: 6) else  {
                self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation.localized(), title: LTY_AlterText.messagePostCodeValidation.localized())
                return
            }
        }
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        if isCommingFrom == "Edit_agent_detail"
        {
            //here agent update API call
            updateAgentDetailApiCall(isComming: "Edit_agent_detail")
        }
        else
        {
            updateAgentDetailApiCall(isComming: "profile_update")
            
        }
    }
    //MARK:- check Change Password all field text validation
    func checkChangePassValidation() {
        
        guard let oldPassword = textOldPass.text, !oldPassword.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageOldPassword, title: LTY_AlterText.oldPassword)
            return
        }
        guard let newPassword = textNewPass.text, !newPassword.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageNewPassword, title: LTY_AlterText.newPassword)
            return
        }
        
        guard newPassword.isPasswordValidation(password: textNewPass.text!) else
        {
            self.ShowAlert(message: LTY_AlterText.messagePassValidation, title: LTY_AlterText.newPassword)
            return
        }
        
//        guard newPassword.isPasswordHasEightCharacter(password: textNewPass.text!) else
//        {
//            self.ShowAlert(message: LTY_AlterText.messagePassEightCharValidation, title: LTY_AlterText.newPassword)
//            return
//        }
//
//        guard newPassword.isPasswordHasNumberAndCharacter(password: textNewPass.text!) else
//        {
//            self.ShowAlert(message: LTY_AlterText.messagePassNumberAndCharValidation, title: LTY_AlterText.newPassword)
//            return
//        }
        
     
        guard let confirmPassword = textConfirmPass.text ,!confirmPassword.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageconfirmPass, title: LTY_AlterText.confirmPass)
            return
        }
        
        if newPassword == oldPassword {
            self.ShowAlert(message: LTY_AlterText.changePassword, title: "")

        }
        else if newPassword != confirmPassword {
            self.ShowAlert(message: LTY_AlterText.messageConfrimPassValidation, title: "")

        }
            
        else {
            
            let partnerId = kUserDefaults.value(forKey: "partnerID")
            
            let param:[String:Any] = ["partnerId":partnerId,"oldPassword":oldPassword,"newPassword":newPassword]
            checkNetwork(params: param)
        }
    }
    
    //MARK:-  check internet Connection
    func checkNetwork (params:[String:Any]) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            profileModelClass.chnagePassApi(param: params)
        }
        else {
            self.ShowAlert(message: "Please check your internet".localized())
        }
    }
    
    //MARK:-
    @IBAction func btnHideShowPasswordAction(_ sender: UIButton) {
        
        switch sender.tag{
        case 301:
            sender.isSelected = !sender.isSelected
            textOldPass.isSecureTextEntry = !textOldPass.isSecureTextEntry
        case 302:
            sender.isSelected = !sender.isSelected
            textNewPass.isSecureTextEntry = !textNewPass.isSecureTextEntry
        case 303:
            sender.isSelected = !sender.isSelected
            textConfirmPass.isSecureTextEntry = !textConfirmPass.isSecureTextEntry
        default:
            print("")
        }
    }
    //MARK:- Upload documents
    
    @IBAction func btnUploadDocuments(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 601:
            self.selectedTxtFieldTag = 601
            self.selectedTf = self.textPrivateCriminalRecord
            self.chooseWhatToUpload()
        case 602:
            self.selectedTxtFieldTag = 602
            self.selectedTf = self.textPrivateOP
            self.chooseWhatToUpload()
        case 603:
            self.selectedTxtFieldTag = 603
            self.selectedTf = self.textCompnyPO
            self.chooseWhatToUpload()
            
        default:
            print("")
        }

        
    }
    
    //MARK:- open all drop down
    
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
        case 204:
            print("Language Drop Down")
            let langArr = ["French".localized(),"English".localized(),"Italian".localized(), "Portuguese".localized(),"Albanian".localized()]
            var languageArr = [DrpDownListStruct]()
            for i in 0..<langArr.count
            {
                let id = i
                let name = langArr[i]
                languageArr.append(DrpDownListStruct(id: id, phoneCode: 0, name: name))
            }
            self.customCountryDDView.listArray = languageArr
            self.customCountryDDView.filteredData = languageArr
        case 205:
            print("Nationality Drop Down")
            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        case 206:
            print("Customer Country Drop Down")
            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
            
            
        case 207:
            print("State Drop Down")
            guard self.textBankCountry.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownStateListArray
            self.customCountryDDView.filteredData = newDrpDownStateListArray
        case 208:
            
            print("City Drop Down")
            guard self.textBankSate.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageState, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownCityListArray
            self.customCountryDDView.filteredData = newDrpDownCityListArray
            
            
            // for compny selction
        case 401:
            print("Country Drop Down")
            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        case 402:
            print("State Drop Down")
            guard self.textCCountry.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownStateListArray
            self.customCountryDDView.filteredData = newDrpDownStateListArray
        case 403:
            print("City Drop Down")
            guard self.textCompState.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageState, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownCityListArray
            self.customCountryDDView.filteredData = newDrpDownCityListArray
            
//        case 801:
//            print("open country code picker")
//
//            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
//            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
//
//        case 802:
//            print("open country code picker")
//
//            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
//            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        default:
            print("Have you done something new?")
        }
        self.view.addSubview(self.customCountryDDView)
    }
    
    func setDrpDownText(id: String, name: String,phoneCode:Int) {
        var urlStr = ""
        switch self.selectedTxtFieldTag {
            
//        case 801:
//            self.textPersnalInfoCCode.text = "\("+")\(phoneCode)"
//
//        case 802:
//            self.textCompanyCCode.text = "\("+")\(phoneCode)"
            
        case 201:
            self.textCountry.text = name
            self.textState.text = ""
            self.textCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
           // urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            addNewAgentViewModel.getStateListApi(url: encodedURLString)
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
//                urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
                let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                addNewAgentViewModel.getCityListApi(url: encodedURLString)
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
        case 204:
            self.textLanguage.text = name
        case 205:
            self.textNationality.text = name
            
        case 206:
            self.textBankCountry.text = name
            self.textBankCity.text = ""
            self.textBankSate.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            addNewAgentViewModel.getStateListApi(url: encodedURLString)
            
        case 207:
            if self.textBankCountry.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageCountry.localized(), title: "")
            }
            else
            {
                self.textBankSate.text = name
                self.textBankCity.text = ""
                self.newDrpDownCityListArray.removeAll()
                urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.CITY_URL)\(name)"
                let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                addNewAgentViewModel.getCityListApi(url: encodedURLString)
            }
        case 208:
            if self.textBankSate.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageState.localized(), title: "")
            }
            else
            {
                self.textBankCity.text = name
            }
          //MARK:-  for comp selection
              
            
        case 401:
            self.textCCountry.text = name
            self.textCompState.text = ""
            self.textCompCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
//            urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            addNewAgentViewModel.getStateListApi(url: encodedURLString)
            
        case 402:
            if self.textCCountry.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
            }
            else
            {
                self.textCompState.text = name
                self.textCompCity.text = ""
                self.newDrpDownCityListArray.removeAll()
                urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.CITY_URL)\(name)"
//                urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
                let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                addNewAgentViewModel.getCityListApi(url: encodedURLString)
            }
        case 403:
            if self.textCompState.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageState, title: "")
            }
            else
            {
                self.textCompCity.text = name
            }
            
            
        default:
            print("nothing")
        }
    }
    
    
    
    @IBAction func btnTopTabAction(_ sender: UIButton) {
        
        switch sender.tag
        {
        case 701:
            personalInfoBackView.isHidden   = false
            companyInfoBackView.isHidden    = true
            bankInfoBackView.isHidden       = true
            changePassBackView.isHidden     = true
            
            setPersonalInfoBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
            setCompanyInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setBankingInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setChangePasswordBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            
        case 702:
            personalInfoBackView.isHidden   = true
            companyInfoBackView.isHidden    = false
            bankInfoBackView.isHidden       = true
            changePassBackView.isHidden     = true
            
            setPersonalInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setCompanyInfoBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
            setBankingInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setChangePasswordBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        case 703:
            personalInfoBackView.isHidden   = true
            companyInfoBackView.isHidden    = true
            bankInfoBackView.isHidden       = false
            changePassBackView.isHidden     = true
            
            setPersonalInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setCompanyInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setBankingInfoBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
            setChangePasswordBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        case 704:
            personalInfoBackView.isHidden   = true
            companyInfoBackView.isHidden    = true
            bankInfoBackView.isHidden       = true
            changePassBackView.isHidden     = false
            
            setPersonalInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setCompanyInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setBankingInfoBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
            setChangePasswordBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
        default:
            print("")
        }
        
        
    }
    
    @IBAction func onClickViewAttachments(_ sender: UIButton) {
        if sender.tag == 201 {
            if self.privateCriminalRecord == "" {
                self.ShowAlert(message: "No data found !!".localized())
            }else{
                let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
                vc.attachmentStr = self.privateCriminalRecord//self.textPrivateCriminalRecord.text!
                //vc.attachmentStr = self.textPrivateCriminalRecord.text!
                self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            }
            
        } else if sender.tag == 202 {
            if self.privateOP == "" {
                self.ShowAlert(message: "No data found !!".localized())
            }else{
                let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
                vc.attachmentStr = self.privateOP
              //  vc.attachmentStr = self.textPrivateOP.text!
                self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            }
        } else if sender.tag == 203 {
            if self.companyPO == "" {
                self.ShowAlert(message: "No data found !!".localized())
            }else{
                let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
                vc.attachmentStr = self.companyPO
               // vc.attachmentStr = self.textCompnyPO.text!
                self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            }
        }
    }
    
    @IBAction func setUserLocationBtn(_ sender: UIButton) {
        
        if sender.tag == 901 {
            self.setLocality = "persnalInfo"
        }else if sender.tag == 902 {
            self.setLocality = "compInfo"
        }else{
            self.setLocality = "bankInfo"
        }
        
        // setLocation()
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnOnClickCountryCode(_ sender: UIButton) {
        print("open country code picker")
        if sender.tag == 801 {
            self.selectedCountryCodePicker = "Persnal"
            self.countryPickerView?.showCountriesList(from: self)
        }else{
            self.selectedCountryCodePicker = "Company"
            self.countryPickerView?.showCountriesList(from: self)
        }
    }
    
    func configCountryCodePicker(){
        self.countryPickerView = CountryPickerView()
        self.countryPickerView?.delegate = self
        self.countryPickerView?.dataSource = self
        
//        let locale = Locale.current
//        let code = ((locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?)
//        self.countryPickerView?.setCountryByCode(code)
    }
    
}


extension ProfileVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        
        if self.selectedCountryCodePicker == "Company"{
            self.textCompanyCCode.text = country.phoneCode

        }else {
            self.textPersnalInfoCCode.text = country.phoneCode
        }
        
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

extension ProfileVC: GMSAutocompleteViewControllerDelegate {

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
                  
                  if self.setLocality == "persnalInfo" {
                      self.textCity.text = city
                      self.textAddress.text = "\(place.name ?? "")"
                  }else if self.setLocality == "compInfo" {
                      self.textCompAdd.text = "\(place.name ?? "")"
                    self.textCompCity.text = city
                  }else{
                      self.textCompAddress.text = "\(place.name ?? "")"
                      self.textBankCity.text = city
                  }
                 
              }
              
              if let state = placemark.administrativeArea {
                  print("State: \(state)")
                  
                  if self.setLocality == "persnalInfo" {
                      self.textState.text = state
                  }else if self.setLocality == "compInfo" {
                      
                      self.textCompState.text = state
                  }else{
                      self.textBankSate.text = state
                  }
                  
              }
              if let country = placemark.country {
                  print("Country: \(country)")
                  
                  if self.setLocality == "persnalInfo" {
                      self.textCountry.text = country
                  }else if self.setLocality == "compInfo" {
                      
                      self.textCCountry.text = country
                  }else{
                      self.textBankCountry.text = country
                  }
                 
              }
              if let postCode = placemark.postalCode {
                  print("PostCode: \(postCode)")
                  
                  if self.setLocality == "persnalInfo" {
                      self.textPostCode.text = postCode
                  }else if self.setLocality == "compInfo" {
                      
                      self.textCompPost.text = postCode
                  }else{
                      self.textCompPostCode.text = postCode
                  }
                  
                
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

extension ProfileVC :DismissScreenInProfileModule {

    func dismissScreenInProfileModule(setValue: Bool,data: ForgotPassValue, isComming:String) {
        if setValue == true
        {
            let vc = OtpVerifyVC.instantiate(fromAppStoryboard: .main)
            vc.comingFrom = isComming
            vc.otpId = data.otpID ?? "0"
            vc.agentID = agentId
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


//
//  AddNewAgentVC.swift
//  LTY_Partner
//
//  Created by CTS on 22/05/23.
//

import UIKit
import DropDown
import GooglePlaces
import CountryPickerView



class AddNewAgentVC: UIViewController , SetDrpDownText {
    
    @IBOutlet weak var textSelectGender: CustomTextField!
    @IBOutlet weak var lblTiltleGender: UILabel!
    //MARK:- Outlets
    @IBOutlet weak var textBankCity: CustomTextField!
    @IBOutlet weak var lblBankCity: UILabel!
    @IBOutlet weak var lblBankState: UILabel!
    @IBOutlet weak var textBankSate: CustomTextField!
    
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var labelCompReserve: UILabel!
    @IBOutlet weak var labelAgentReserve: UILabel!
    @IBOutlet weak var labelAgentComission: UILabel!
    
    @IBOutlet weak var txtProfile: CustomTextField!
    
    @IBOutlet weak var txtAgentCommision: CustomTextField!
    
    @IBOutlet weak var txtCompReserve: CustomTextField!
    
    @IBOutlet weak var txtAgentReserve: CustomTextField!
    
    @IBOutlet weak var textDob: CustomTextField!
    @IBOutlet weak var labelDob: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    @IBOutlet weak var personalInfoSubTitleView: UIView!
    @IBOutlet weak var companyInfoSubTitleView: UIView!
    @IBOutlet weak var passwordInfoSubTitleView: UIView!
    
    @IBOutlet weak var personalInfoBackView: UIView!
    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var textFirstName: CustomTextField!
    
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var textLastName: CustomTextField!
    
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var textPhone: CustomTextField!
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textEmail: CustomTextField!
    
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var textAddress: CustomTextField!
    
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var btnDDCountry: UIButton!
    @IBOutlet weak var textCountry: CustomTextField!
    
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var btnDDState: UIButton!
    @IBOutlet weak var textState: CustomTextField!
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var btnDDCity: UIButton!
    @IBOutlet weak var textCity: CustomTextField!
    
    @IBOutlet weak var labelPostCode: UILabel!
    @IBOutlet weak var textPostCode: CustomTextField!
    
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var btnDDLanguage: UIButton!
    @IBOutlet weak var textLanguage: CustomTextField!
    
    @IBOutlet weak var labelNationality: UILabel!
    @IBOutlet weak var textNationality: CustomTextField!
    
    @IBOutlet weak var btnDDNationality: UIButton!
    @IBOutlet weak var btnPersonalInfoNext: UIButton!
    
    @IBOutlet weak var textPersnalInfoCCode: UITextField!
    @IBOutlet weak var lblPersnalInfoCCode: UILabel!
    
    
    @IBOutlet weak var textRole: CustomTextField!
    @IBOutlet weak var lblRole: UILabel!
    //MARK:- Compny outlets
    
    @IBOutlet weak var lblPrivateCriminalRecord: UILabel!
    @IBOutlet weak var btnPrivateCrimalRecord: UIButton!
    @IBOutlet weak var textPrivateCriminalRecord: CustomTextField!
    
    @IBOutlet weak var lblPrivateOP: UILabel!
    @IBOutlet weak var btnPribateOP: UIButton!
    @IBOutlet weak var textPrivateOP: CustomTextField!
    
    @IBOutlet weak var textCompAdd: CustomTextField!
    @IBOutlet weak var lblCompAddress: UILabel!
    
    @IBOutlet weak var companyInfoBackView: UIView!
    
    @IBOutlet weak var textCompPost: CustomTextField!
    @IBOutlet weak var lblCompPostCode: UILabel!
    
    @IBOutlet weak var btnCompState: UIButton!
    @IBOutlet weak var lblCompState: UILabel!
    @IBOutlet weak var textCompState: CustomTextField!

    @IBOutlet weak var btnCompCity: UIButton!
    @IBOutlet weak var lblCompCity: UILabel!
    @IBOutlet weak var textCompCity: CustomTextField!

    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var textCompanyName: CustomTextField!

    @IBOutlet weak var lblCompCountry: UILabel!
    @IBOutlet weak var btnCompCountry: UIButton!
    @IBOutlet weak var textCCountry: CustomTextField!

    @IBOutlet weak var lblCompMobile: UILabel!
    @IBOutlet weak var textCompMobile: CustomTextField!
    
    @IBOutlet weak var lblCiceroNo: UILabel!
    @IBOutlet weak var textCireoNo: CustomTextField!
    
    @IBOutlet weak var lblCompEmail: UILabel!
    @IBOutlet weak var textCompEmail: CustomTextField!

    @IBOutlet weak var labelWebSite: UILabel!
    @IBOutlet weak var textWebSite: CustomTextField!
    
    @IBOutlet weak var lblFirmNo: UILabel!
    @IBOutlet weak var textFiemNo: CustomTextField!
    
    //MARK:- bank view outlets
    
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
    
    @IBOutlet weak var btnCompNext: UIButton!
    @IBOutlet weak var btnDDCompCountry: UIButton!
    @IBOutlet weak var btnBankInfoBack: UIButton!
    @IBOutlet weak var btnBankInfoNext: UIButton!
    @IBOutlet weak var btnCompPrevious: UIButton!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    @IBOutlet weak var customNavigation: CustomNavigationBarForDrawer!

    //MARK:- Variables
    
    // var signUpModelClass = SignUpViewModel()
    var setLocality = ""
    var picker = UIImagePickerController()
    var pickedImageUrl:URL?
    var roleId = ""
    var agentDob = ""
    var customCountryDDView : CustomCountryDDView!
    
    var drpDownCounrtyListArray = [CountryModel]()
    var drpDownStateListArray = [StateModel]()
    var drpDownCityListArray = [CityModel]()
    
    var newDrpDownCounrtyListArray = [DrpDownListStruct]()
    var newDrpDownStateListArray = [DrpDownListStruct]()
    var newDrpDownCityListArray = [DrpDownListStruct]()
    var roleListArr = [rolesList]()
    
    var addNewAgentViewModel = AddNewAgentViewModel()
    
    var agentId = ""
    var isCommingFrom = ""
    var countryPickerView: CountryPickerView?

    var selectedTxtFieldTag = 0
    var datePicker = UIDatePicker()
    var profileOptionArr = [String]()
    var profileAPIArr = [String:InnerProfileData]()
    var rightBarDropDown = DropDown()
    var selectedTf: UITextField!
    
   
    //MARK:- Didload func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        textPersnalInfoCCode.delegate = self
        configCountryCodePicker()
        setDrowerHeight()
        self.getProfilesApi()
        if isCommingFrom == "Edit_agent_detail"
        {
        
            let param :[String:Any]  = ["entityId":self.agentId, "entityType":"PARTNER_ID"]
            addNewAgentViewModel.agentEditDetailApi(param: param)
        }
        
        textDob.delegate = self
        //addNewAgentViewModel.getProfile()
        addNewAgentViewModel.delegate = self
        
        addNewAgentViewModel.getCountryListApi()
        
        customNavigation.titleLabel.text = "Add Agent".localized()
        lblTiltleGender.text = "Gender".localized()
        customNavigation.titleLabel.textAlignment = .center
        customNavigation.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigation.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        self.txtProfile.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)

        
        textCountry.text = "Switzerland" //214
        textPersnalInfoCCode.text = "+41"
        var urlStr = ""
        urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(textCountry.text!)"
        let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        addNewAgentViewModel.getStateListApi(url: encodedURLString)
    }
    
    func configCountryCodePicker(){
        self.countryPickerView = CountryPickerView()
        self.countryPickerView?.delegate = self
        self.countryPickerView?.dataSource = self
        
//        let locale = Locale.current
//        let code = ((locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?)
//        self.countryPickerView?.setCountryByCode(code)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let param:[String:Any] = ["partnerId":partnerId]
        addNewAgentViewModel.getRolesApi(param: param)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
    
    @IBAction func btnSelectGender(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let martialArr = ["Male".localized(), "Female".localized()]
        
        for item in martialArr {
            
            let action = UIAlertAction(title: item, style: .default) { (action) in
                
                self.textSelectGender.text = item
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
    
    @objc func textFieldDidChange(textField: UITextField) {
        //your code
        
        rightBarDropDown.anchorView = textField
        rightBarDropDown.dataSource = self.profileOptionArr
        rightBarDropDown.cellConfiguration = { (index, item) in return "\(item)" }
        
        rightBarDropDown.selectionAction = { (index: Int, item: String) in
            
            print(item)
            self.getCommissionFromProfile(item)
            
        }
        
        // rightBarDropDown.width = cell.cellTextFieldd.frame.width//btnFilter.frame.width
        rightBarDropDown.width = 300
        rightBarDropDown.bottomOffset = CGPoint(x: 0, y:(rightBarDropDown.anchorView?.plainView.bounds.height)!)
        rightBarDropDown.show()
        
    }
    
    func getCommissionFromProfile(_ selectedProfile: String) {
        var index = -1
        for item in self.profileAPIArr.keys {
            if item == selectedProfile {
                self.txtAgentReserve.text = String(self.profileAPIArr["\(item)"]?.agentReserve ?? 0.0)
                self.txtCompReserve.text = String(self.profileAPIArr["\(item)"]?.companyReserve ?? 0.0)
                self.txtAgentCommision.text = String(self.profileAPIArr["\(item)"]?.agentCommission ?? 0.0)
                self.txtProfile.text = selectedProfile
            }
        }
    }
    
    func getProfilesApi() {
//        Services.shareInstance.requestGetApi(url: URL(string: LTY_BASE_URL.BASE_URL_GETPROFILE), shouldSendHeader: true, expecting: AgentProfileModel.self) { response in
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
        let param : [String:Any] = ["partnerId":partnerId]
            Services.shareInstance.postRequestApi(url:LTY_BASE_URL.BASE_URL_GETPROFILE, method: "POST", passToken: true, expecting:AgentProfileModel.self, dataDict: param) { response in
            switch response {
                
            case .success (let result) :
              //  print(response)
                if result.status == "SUCCESS"{
                    
                    self.profileAPIArr = (result.data?.profiles)!
                    if result.data?.profiles!.keys.count != 0
                    {
                        let keyCount = result.data?.profiles!.keys.count ?? 0
                        for item in result.data!.profiles!.keys
                        {
                            self.profileOptionArr.append("\(item)")
                            //                        print(result.data?.profiles["\(item)"]?.agentReserve as Any)
                        }
                    }
                    print(self.profileOptionArr)
                  
                }else{
                    self.ShowAlert(message: result.error?.serverErrorMessage ?? "")
                }
            case.failure (let error) :
                print(error)
            }

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
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    //MARK:- SetUpView
    
    func setUpView () {
        
        personalInfoBackView.isHidden   = false
        companyInfoBackView.isHidden    = true
        bankInfoBackView.isHidden   = true
        
        personalInfoSubTitleView.isHidden = false
        companyInfoSubTitleView.isHidden  = true
        passwordInfoSubTitleView.isHidden = true
        
        
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
        
        
        labelSubTitle.font = FontSize.size16
        labelSubTitle.text = LTYText.textSignUpVCSubTitle1.localized()
        
        btnCompNext.viewCorner(8)
        btnCompNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        btnCompNext.backgroundColor = Asset.Colors.blueColor.color
        btnCompNext.setTitleColor(.white, for: .normal)
     
        btnCompPrevious.viewCorner(8)
        btnCompPrevious.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        btnCompPrevious.setTitle(LTYText.textSignUpVCPrevious.localized(), for: .normal)
        btnCompPrevious.backgroundColor    = Asset.Colors.grayColor.color
        
  
        
        lblRole.font             = FontSize.size16
        lblRole.textColor        = Asset.Colors.gray1.color
        lblRole.text             = LTYText.agentRole.localized()
        textRole.font              = FontSize.size16
        textRole.textColor         = Asset.Colors.darkGrayColor.color
        textRole.backgroundColor   = Asset.Colors.grayColor.color
        
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
        
        //dob
        labelDob.font             = FontSize.size16
        labelDob.textColor        = Asset.Colors.gray1.color
        labelDob.text             = LTYText.dob.localized()
        textDob.font              = FontSize.size16
        textDob.textColor         = Asset.Colors.darkGrayColor.color
        textDob.backgroundColor   = Asset.Colors.grayColor.color
        labelDob.makeTextMandatory()
        
        
        // 1
        labelFirstName.font             = FontSize.size16
        labelFirstName.textColor        = Asset.Colors.gray1.color
        labelFirstName.text             = LTYText.textSignUpVCFName.localized()
        textFirstName.font              = FontSize.size16
        textFirstName.textColor         = Asset.Colors.darkGrayColor.color
        textFirstName.backgroundColor   = Asset.Colors.grayColor.color
        labelFirstName.makeTextMandatory()
        
        
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
        
        
        labelEmail.font                 = FontSize.size16
        labelEmail.textColor            = Asset.Colors.gray1.color
        labelEmail.text                 = LTYText.textSignUpVCEmail.localized()
        textEmail.font                  = FontSize.size16
        textEmail.textColor             = Asset.Colors.darkGrayColor.color
        textEmail.backgroundColor       = Asset.Colors.grayColor.color
        labelEmail.makeTextMandatory()
        
        
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
        labelWebSite.makeTextMandatory()
        
        
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
        
        lblTiltleGender.font                 = FontSize.size16
        lblTiltleGender.textColor            = Asset.Colors.gray1.color
        textSelectGender.font                  = FontSize.size16
        textSelectGender.textColor             = Asset.Colors.darkGrayColor.color
        textSelectGender.backgroundColor       = Asset.Colors.grayColor.color
        
        
        //1
        btnPersonalInfoNext.viewCorner(8)
        btnPersonalInfoNext.backgroundColor = Asset.Colors.lightBlue.color
        btnPersonalInfoNext.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
       // btnPersonalInfoNext.titleLabel?.text = LTYText.textSignUpVCNext
        btnPersonalInfoNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        
        //2
        btnBankInfoBack.viewCorner(8)
        btnBankInfoBack.titleLabel?.textColor = Asset.Colors.lightGray.color
        btnBankInfoBack.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        btnBankInfoBack.titleLabel?.text = LTYText.textSignUpVCPrevious
        btnBankInfoBack.setTitle(LTYText.textSignUpVCPrevious.localized(), for: .normal)
        btnBankInfoBack.backgroundColor    = Asset.Colors.grayColor.color
        
        btnBankInfoNext.viewCorner(8)
        btnBankInfoNext.backgroundColor = Asset.Colors.lightBlue.color
        btnBankInfoNext.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        //btnCompInfoNext.titleLabel?.text = LTYText.textSignUpVCNext
        btnBankInfoNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        
        if isCommingFrom == "Edit_agent_detail"
        {
            btnPersonalInfoNext.setTitle(LTYText.textAddNewAgentVCUpdate.localized(), for: .normal)
            btnBankInfoNext.setTitle(LTYText.textAddNewAgentVCUpdate.localized(), for: .normal)
        }
        else
        {
            btnBankInfoNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
            btnPersonalInfoNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        }
        
    }
    //MARK:- Show date picker
    
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
       
    
    //MARK:- Next PersonalInfo Btn Action
    @IBAction func btnPersonalInfoNextAction(_ sender: UIButton) {
   
        checkPersonalInfoValidation()
    }
    
    @IBAction func btnCompPreviousAction(_ sender: UIButton) {
        personalInfoBackView.isHidden = false
        companyInfoBackView.isHidden = true
        bankInfoBackView.isHidden = true
        
        labelSubTitle.font = FontSize.size16
        labelSubTitle.text = LTYText.textSignUpVCSubTitle1
        
        personalInfoSubTitleView.isHidden = false
        companyInfoSubTitleView.isHidden  = true
        passwordInfoSubTitleView.isHidden = true
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    @IBAction func btnCompNextAction(_ sender: UIButton) {
   
        checkCompInfoValidation()
        
    }
    //MARK:- Back/Previous Bank Info Btn Action
    
    @IBAction func btnBankInfoBackAction(_ sender: UIButton){
        
        personalInfoBackView.isHidden   = false
        companyInfoBackView.isHidden    = true
        bankInfoBackView.isHidden = true
        
        
        labelSubTitle.font = FontSize.size16
        
        personalInfoSubTitleView.isHidden = false
        companyInfoSubTitleView.isHidden  = true
        passwordInfoSubTitleView.isHidden = true
        
        labelSubTitle.text = LTYText.textSignUpVCSubTitle1
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        
    }
    

    //MARK:- Back/Previous SetPassword Btn Action
    @IBAction func btnSetPassBackAction(_ sender: UIButton){
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = false
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = false
        passwordInfoSubTitleView.isHidden = true
        
        labelSubTitle.text = LTYText.textSignUpVCSubTitle2
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
 
    //MARK:- Next CompInfo Btn Action
    @IBAction func btnBankInfoNextAction(_ sender: UIButton) {
        // checkSetPassValidation()
       
        if textCompPostCode.text != ""{
            let postCode = textCompPostCode.text!
            guard postCode.isLengthValid(minLength: 4, maxLength: 6) else  {
                self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation.localized(), title: LTY_AlterText.messagePostCodeValidation.localized())
                return
            }
        }
        
        if isCommingFrom == "Edit_agent_detail"
        {
            checkPersonalInfoValidation()
            checkSetPassValidation()
        }
        else
        {
            checkSetPassValidation()
        }
    }
    

    
    //MARK:- check signup all field text validation
    
    func checkPersonalInfoValidation() {
 
        let agentReserveComm = Int(txtAgentReserve.text ?? "")
        let companyReserve = Int(txtCompReserve.text ?? "")
        let  agentCommission = Int(txtAgentCommision.text ?? "")
        
        if txtAgentReserve.text != "" || txtCompReserve.text != "" || txtAgentCommision.text != "" {
            
            if agentReserveComm ?? 0 > 100 {
                self.ShowAlert(message: "agent Reserve should not be greater than 100".localized())
                return
            }
            
            else if companyReserve ?? 0 > 100 {
                self.ShowAlert(message: "company Reserve should not be greater than 100".localized())
                return
                
            }
            else if agentCommission ?? 0 > 100 {
                self.ShowAlert(message: "agent Commission should not be greater than 100".localized())
                return
                
            }
        }
        else{
            guard let agentReserve = txtAgentReserve.text, !agentReserve.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageAgentReserve, title: LTY_AlterText.agentReserve)
                return
            }
            
            guard let commisionReserve = txtCompReserve.text, !commisionReserve.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageCompnyReserve, title: LTY_AlterText.compReserve)
                return
            }
            
            guard let agentCommision = txtAgentCommision.text, !agentCommision.isEmpty else {
                self.ShowAlert(message: LTY_AlterText.messageAgentCommision, title: LTY_AlterText.agentCommision)
                return
            }
        }
        
        
        guard let profile = txtProfile.text, !profile.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageSelectProfile, title: LTY_AlterText.profile)
            return
        }
        
//        guard let dob = textDob.text, !dob.isEmpty else {
//            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)
//            return
//        }
        if agentDob == ""{
            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)
            return
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
            print("Contains only alphanumeric characters!")
        } else {
            self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
            return
        }
        
        guard  let gender = textSelectGender.text, !gender.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messagegender, title: LTY_AlterText.gender)
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
            self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation, title: LTY_AlterText.postCode)
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
    
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = true
        bankInfoBackView.isHidden   = false
        
        labelSubTitle.font = FontSize.size16
        labelSubTitle.text = LTYText.textSignUpVCSubTitle33
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = false
        passwordInfoSubTitleView.isHidden = true
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func checkCompInfoValidation() {
        
        guard let companyName = textCompanyName.text, !companyName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCompanyName, title: LTY_AlterText.companyName)
            return
        }
        guard let website = textWebSite.text, !website.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageWebsite, title: LTY_AlterText.website)
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
        
        if textCompEmail.text  == "" {
            
        }
        else {
            if let emailID = textCompEmail.text  {
                guard emailID.isValidEmail() else {
                    self.ShowAlert(message: LTY_AlterText.messageEmailVarification, title: LTY_AlterText.email)
                    return        }
                
            }
        }
        if textCompMobile.text == "" {
            
        }
        else {
            if let mobile = textCompMobile.text  {
                guard mobile.isLengthValid(minLength: 8, maxLength: 13) else  {
                    self.ShowAlert(message: LTY_AlterText.messageMobileValidation, title: LTY_AlterText.mobile)
                    return
                }
            }
        }

        personalInfoBackView.isHidden = true
        companyInfoBackView.isHidden = true
        bankInfoBackView.isHidden = false
        
        labelSubTitle.font = FontSize.size16
        labelSubTitle.text = LTYText.textSignUpVCSubTitle33
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = true
        passwordInfoSubTitleView.isHidden = false

        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func checkSetPassValidation() {
        /*
                let agentReserve    =  "xyz"
                let companyReserve    =  "yes"
                let agentCommission    = "123"
               let dob              = textDob.text ?? ""

                let  profile        = "IOS"
                let firstName = "Test"//textFirstName.text ?? ""
                let lastName =  "S1"//textLastName.text ?? ""
                let email =  textEmail.text ?? ""
                let mobile =  "1234567890"//textPhone.text ?? ""
                let country = "India"//textCountry.text ?? ""
                let state =  "UP"//textState.text ?? ""
                let city =  "Noida"//textCity.text ?? ""
                let address =  "noida sector 98"//textAddress.text ?? ""
                let postCode =  "201301"//textPostCode.text ?? ""
                let language =  "English"//textLanguage.text ?? ""
                let nationality =  "Indian"//textNationality.text ?? ""
                let companyName =  "Test Partner"//textCompanyName.text ?? ""
                let website =  "www.testpartner.com"//textWebSite.text ?? ""
                let compAddress =  "noida sector 44 Goutam buddhe nagar"//textCompAddress.text ?? ""
                let compPostCode =  "201303"//textCompPostCode.text ?? ""
                let compCountry = "India"//textCompCountry.text ?? ""
                let iban =  "qwerty"//textIBAN.text ?? ""
                let swift =  "asdfghjkl"//textSwiftBIC.text ?? ""
                let bank =  "fedderal bank test "//textBank.text ?? ""
        */
        
        
        let agentReserve    =  txtAgentReserve.text ?? ""
        let companyReserve    = txtCompReserve.text ?? ""
        let agentCommission    = txtAgentCommision.text ?? ""
        let  profile        = txtProfile.text ?? ""
        let dob              = agentDob

        let firstName       = textFirstName.text ?? ""
        let lastName        =  textLastName.text ?? ""
        let email           =  textEmail.text ?? ""
        let mobile          = textPhone.text ?? ""
        let countryCode          = textPersnalInfoCCode.text ?? ""
        let country         = textCountry.text ?? ""
        let state           = textState.text ?? ""
        let gender           = textSelectGender.text ?? ""
        let city            = textCity.text ?? ""
        let address         = textAddress.text ?? ""
        let postCode        = textPostCode.text ?? ""
        let language        = textLanguage.text ?? ""
        let nationality     = textNationality.text ?? ""
        
        //MARK:-  bank params
        
        let bankAddress     = textCompAddress.text ?? ""
        let bankPostCode    = textCompPostCode.text ?? ""
        let bankCountry     = textBankCountry.text ?? ""
        let bankState    =  textBankSate.text ?? ""
        let bankCity1     = textBankCity.text ?? ""
        let iban            = textIBAN.text ?? ""
        let swift           = textSwiftBIC.text ?? ""
        let bank            = textBank.text ?? ""
        
        //MARK:- company params
        let companyName     = textCompanyName.text ?? ""
        let website         = textWebSite.text ?? ""
        let finamNo = textFiemNo.text ?? ""
        let carcioNo = textCireoNo.text ?? ""
        let compPhone = textCompMobile.text ?? ""
        let compEmail = textCompEmail.text ?? ""
        let compCity = textCompCity.text ?? ""
        let compState = textCompState.text ?? ""
        let compAddress     = textCompAdd.text ?? ""
        let compPostCode    = textCompPost.text ?? ""
        let compCountry     = textCCountry.text ?? ""
        

        /*
         let sourceID = kUserDefaults.value(forKey: "partnerID")
         
         checkNetwork(params: AddAgentParams.init(type: "AGENT", subscriptionPlan: LTY_SUBSCIPTIONPLAN, source:sourceID as! String, firstName: firstName, lastName: lastName, mobile: mobile, email: email, country: country, state: state,city: city, address: address, postCode: postCode, language: language, nationality: nationality, dob:dob, profile: profile, companyName: .init(companyName: companyName, website: website, logo: "", finamNo: "", ciceroNo: "", email: "", telephone: "", country: compCountry, state: "", city: "", address: compAddress, postCode: compPostCode, privateCriminalRecord: "", privateOp: "", companyPo: ""), bankDetails:.init(iban: iban, swift: swift, bank: bank, country: compCountry, postCode: compPostCode, address:compAddress, houseOwned: "true"),commissionDetails: .init(agentReserve:agentReserve,companyReserve: companyReserve,agentCommission:agentCommission)))
         */
        
        
        var sourceID = kUserDefaults.value(forKey: "partnerID") as! String
        
        if isCommingFrom == "Edit_agent_detail"
        {
            let partnerId = "\(self.agentId)"
            //EditAgentModel
            //            checkNetworkUpdate(params: EditAgentModel(partnerId: partnerId, profilePic: "", profile: profile, firstName: firstName, lastName: lastName, mobile: mobile, countryCode: countryCode ,email: email, dob: dob, password: "", country: country, state: state, city: city, address: address, postCode: postCode, language: language, nationality: nationality, roleType: "",roleId:roleId, companyDetails: EditCompanyDetails.init(companyName: companyName, website: website, logo: "", finamNo: finamNo, ciceroNo: carcioNo, email: compEmail, telephone: compPhone, country: compCountry, state: compState, city:compCity, address: address, postCode: compPostCode, privateCriminalRecord: "", privateOp: "", companyPo: ""), commissionDetails: EditCommissionDetails.init(agentReserve: agentReserve, companyReserve: companyReserve, agentCommission: agentCommission), bankDetails: EditBankDetails.init(iban: iban, swift: swift, bank: bank, country:bankCountry, postCode:bankPostCode, address:bankAddress), source: sourceID))
            
            checkNetworkUpdate(params: EditAgentModel(partnerId: partnerId, profilePic: "", profile: profile, firstName: firstName, lastName: lastName, mobile: mobile, countryCode: countryCode ,email: email, dob: dob, password: "", country: country, state: state, city: city, address: address, gender: gender, postCode: postCode, language: language, nationality: nationality, roleType: "",roleId:roleId, companyDetails: EditCompanyDetails.init(companyName: companyName, website: website, logo: "", finamNo: finamNo, ciceroNo: carcioNo, email: compEmail, telephone: compPhone, countryCode: "", country: compCountry, state: compState, city:compCity, address: address, postCode: compPostCode, privateCriminalRecord: "", privateOp: "", companyPo: ""), commissionDetails: EditCommissionDetails.init(agentReserve: agentReserve, companyReserve: companyReserve, agentCommission: agentCommission), bankDetails: EditBankDetails.init(iban: iban, swift: swift, bank: bank, country:bankCountry,state: bankState,city: bankCity1, postCode:bankPostCode, address:bankAddress), source: sourceID))
            
        }
        else
        {
            checkNetwork(params: AddAgentParams.init(type: "AGENT", subscriptionPlan: LTY_SUBSCIPTIONPLAN, source:sourceID , firstName: firstName, lastName: lastName, mobile: mobile,gender:gender, countryCode: countryCode ,email: email, roleId:self.roleId, country: country, state: state,city: city, address: address, postCode: postCode, language: language, nationality: nationality, dob:dob, profile: profile, companyDetails: .init(companyName: companyName, website: website, logo: "", finamNo: finamNo, ciceroNo:carcioNo, email: compEmail, telephone: compPhone, country: compCountry, state:compState, city:compCity, address: compAddress, postCode: compPostCode, privateCriminalRecord: "", privateOp: "", companyPo: ""), bankDetails:.init(iban: iban, swift: swift, bank: bank, country: bankCountry,state: bankState,city: bankCity1, postCode: bankPostCode, address:bankAddress, houseOwned: "true"),commissionDetails: .init(agentReserve:agentReserve,companyReserve: companyReserve,agentCommission:agentCommission)))
            
        }
        
        
    }
    @IBAction func btnOnClickCountryCode(_ sender: UIButton) {
        print("open country code picker")
        self.countryPickerView?.showCountriesList(from: self)
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:AddAgentParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            // signUpModelClass.networkServiceCall(param:params)
            addNewAgentViewModel.AddNewAgentApi12(param: params)
        }
        else {
            self.ShowAlert(message: "Please check your internet".localized())
        }
    }
    
    func checkNetworkUpdate(params:EditAgentModel) {
        
        if internetConnection.isConnectedToNetwork() == true {
            // signUpModelClass.networkServiceCall(param:params)
            addNewAgentViewModel.updateAgentApi(param: params, isCommingFrom: "")
        }
        else {
            self.ShowAlert(message: "Please check your internet".localized())
        }
    }
    
    @IBAction func addAgentRoleAction(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in roleListArr {
            
            let action = UIAlertAction(title: cat.name, style: .default) { (action) in
                self.textRole.text = cat.name
                self.roleId = cat.id ?? ""
                
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnUploadFilesAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 501:
            self.selectedTf = self.textPrivateCriminalRecord
            self.chooseWhatToUpload()
        case 502:
            self.selectedTf = self.textPrivateOP
            self.chooseWhatToUpload()
            
        default:
            print("")
        }
    }
    
    //MARK:- open all drop down actions
    
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
            print("Country Drop Down")
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
            
            // for compny selction
        case 301:
            print("Country Drop Down")
            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        case 302:
            print("State Drop Down")
            guard self.textCCountry.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownStateListArray
            self.customCountryDDView.filteredData = newDrpDownStateListArray
        case 303:
            print("City Drop Down")
            guard self.textCompState.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageState, title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownCityListArray
            self.customCountryDDView.filteredData = newDrpDownCityListArray
            
        case 701:
            print("open country code picker")
            self.countryPickerView?.showCountriesList(from: self)
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
            
        case 701:
            self.textPersnalInfoCCode.text = "\("+")\(phoneCode)"
            
        case 201:
            self.textCountry.text = name
            self.textState.text = ""
            self.textCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
//            urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
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
              
            
        case 301:
            self.textCCountry.text = name
            self.textCompState.text = ""
            self.textCompCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
//            urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            addNewAgentViewModel.getStateListApi(url: encodedURLString)
            
        case 302:
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
                urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
                addNewAgentViewModel.getCityListApi(url: urlStr)
            }
        case 303:
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
    
    @IBAction func onClickViewAttachments(_ sender: UIButton) {
        if sender.tag == 201 {
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = self.textPrivateCriminalRecord.text!
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
//            self.pushToVC(vc, animated: true)
        } else {
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = self.textPrivateOP.text!
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
//            self.pushToVC(vc, animated: true)
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
    
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        present(autocompleteController, animated: true, completion: nil)
    }
}


extension AddNewAgentVC: GMSAutocompleteViewControllerDelegate {
    
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



  //      let geocoder = GMSGeocoder()
  //      let latitute = locValue.latitude
  //      let longitude = locValue.longitude
  //      let position = CLLocationCoordinate2DMake(latitute, longitude)
  //      geocoder.reverseGeocodeCoordinate(position) { response , error in
  //          if error != nil {
  //              print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
  //          }else {
  //              let result = response?.results()?.first
  //              let address = result?.lines?.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
  //              self.textFieldSearch.text = address?.localized()
  //              self.marker.title = address?.localized()
  //              self.setUPMapView(lat: latitute, long: longitude, placeName: address ?? "Location not Found".localized())
  //
  //          }
  //      }
        
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

extension AddNewAgentVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.textPersnalInfoCCode.text = country.phoneCode
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

//extension AddNewAgentVC: UITextFieldDelegate {
//
//    rightBarDropDown.anchorView = cell.cellDropDownButton
//    rightBarDropDown.dataSource = titleStr
//    rightBarDropDown.cellConfiguration = { (index, item) in return "\(item)" }
//
//    rightBarDropDown.selectionAction = { (index: Int, item: String) in
//
//        //print("Selected item: \(item) at index: \(index)")
//
//        let txtStr = cell.cellTextFieldd.text ?? ""
//       // cell.cellTextFieldd.text =  txtStr + "," + "\(item)"
//        cell.cellTextFieldd.text =   "\(item)"
//
//        str = cell.cellTextFieldd.text ?? ""
//        self.isUpdatee = true
//        self.isAttributeUpdated = true
//
//      /*  if ques == "Result" {
//            cell.cellTextFieldd.isUserInteractionEnabled = false
//            cell.cellTextFieldd.text = "\(item)"
//            str = cell.cellTextFieldd.text ?? ""
//        }
//        else if ques == "Status" {
//            cell.cellTextFieldd.isUserInteractionEnabled = false
//            cell.cellTextFieldd.text =  "\(item)"
//            str = cell.cellTextFieldd.text ?? ""
//        }
//        else {
//            cell.cellTextFieldd.isUserInteractionEnabled = true
//            let txtStr = cell.cellTextFieldd.text ?? ""
//            cell.cellTextFieldd.text =  txtStr + "," + "\(item)"
//            str = cell.cellTextFieldd.text ?? ""
//
//        }*/
//
//
//
//
//
//
//    /*    if cell.cellTitleLbl.text == "comment" {
//
//            cell.cellTextFieldd.text = cell.cellTitleLbl.text ?? "" + "," + "\(item)"
//            str = cell.cellTitleLbl.text ?? "" + "," + "\(item)"
//
//        }
//        else {
//            cell.cellTextFieldd.text = "\(item)"
//            str = cell.cellTextFieldd.text ?? ""
//
//
//        }*/
//
//        self.questionsArr[buttonTag].answer = str
//        self.questionsArr[buttonTag].isupdate = true
//        self.saveActionData()
//
//        DispatchQueue.main.async {
//            self.mainTableView.reloadData()
//        }
//
//
//      //  self.btnFilter.setTitle("\(item)", for: .normal)
//
//
//
//        if index == 0 {
//
//        }
//        if index == 1 {
//
//        }
//        if index == 2 {
//
//
//        }
//        else {
//
//
//        }
//
//
//    }
//
//
//
//   // rightBarDropDown.width = cell.cellTextFieldd.frame.width//btnFilter.frame.width
//     rightBarDropDown.width = 300
//    rightBarDropDown.bottomOffset = CGPoint(x: 0, y:(rightBarDropDown.anchorView?.plainView.bounds.height)!)
//    rightBarDropDown.show()
//
//}

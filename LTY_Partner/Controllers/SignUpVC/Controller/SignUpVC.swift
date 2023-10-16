//
//  SignUpVC.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 10/05/23.
//

import UIKit
import GooglePlaces
import CountryPickerView


class SignUpVC: UIViewController, SetDrpDownText {
  
    
    @IBOutlet weak var textSelectGender: CustomTextField!
    @IBOutlet weak var lblTiltleGender: UILabel!
    
    @IBOutlet weak var btnViewAttachment1: UIButton!
    @IBOutlet weak var btnViewAttachment2: UIButton!
    @IBOutlet weak var btnViewAttachment3: UIButton!
    //MARK:- Outlets
    @IBOutlet weak var textBankCity: CustomTextField!
    @IBOutlet weak var lblBankCity: UILabel!
    @IBOutlet weak var lblBankState: UILabel!
    @IBOutlet weak var textBankSate: CustomTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var textDob: CustomTextField!
    @IBOutlet weak var personalInfoSubTitleView: UIView!
    @IBOutlet weak var companyInfoSubTitleView: UIView!
    @IBOutlet weak var bankInfoSubTitleView: UIView!
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
    @IBOutlet weak var btnPersonalInfoNext: UIButton!
    
    @IBOutlet weak var textPersnalInfoCCode: UITextField!
    @IBOutlet weak var lblPersnalInfoCCode: UILabel!
    
    
    //MARK:- Company outlets

    @IBOutlet weak var companyInfoBackView: UIView!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var textCompanyName: CustomTextField!
    @IBOutlet weak var labelWebSite: UILabel!
    @IBOutlet weak var textWebSite: CustomTextField!
    
    @IBOutlet weak var labelFinam: UILabel!
    @IBOutlet weak var textFinam: CustomTextField!
    
    @IBOutlet weak var labelCercio: UILabel!
    @IBOutlet weak var textCercio: CustomTextField!
    
    @IBOutlet weak var labelCompPhone: UILabel!
    @IBOutlet weak var textCompPhone: CustomTextField!
    
    @IBOutlet weak var labelCompEmail: UILabel!
    @IBOutlet weak var textCompEmail: CustomTextField!
    
    
    @IBOutlet weak var labelCompAddress: UILabel!
    @IBOutlet weak var textCompAddress: CustomTextField!
    @IBOutlet weak var labelCompPostCode: UILabel!
    @IBOutlet weak var textCompPostCode: CustomTextField!
    
    @IBOutlet weak var labelCompCity: UILabel!
    @IBOutlet weak var textCompCity: CustomTextField!
    @IBOutlet weak var btnDDCompCity: UIButton!
    
    @IBOutlet weak var labelCompState: UILabel!
    @IBOutlet weak var textCompState: CustomTextField!
    @IBOutlet weak var btnDDCompState: UIButton!
    
    @IBOutlet weak var labelCompCountry: UILabel!
    @IBOutlet weak var textCompCountry: CustomTextField!
    @IBOutlet weak var btnDDCompCountry: UIButton!
    @IBOutlet weak var btnCompInfoBack: UIButton!
    @IBOutlet weak var btnCompInfoNext: UIButton!
    
    @IBOutlet weak var textPrivateCRecord: CustomTextField!
    @IBOutlet weak var btnPrivateCriRecord: UIButton!
    @IBOutlet weak var lblPrivateCriminalRecord: UILabel!
    
    @IBOutlet weak var textPrivateOP: CustomTextField!
    @IBOutlet weak var btnPrivateOP: UIButton!
    @IBOutlet weak var lblPrivateOP: UILabel!
    
    @IBOutlet weak var lblCompanyCCode: UILabel!
    @IBOutlet weak var textCompanyCCode: UITextField!
    @IBOutlet weak var textCompanyPO: CustomTextField!
    @IBOutlet weak var btnCompanyPO: UIButton!
    @IBOutlet weak var lblCompanyPO: UILabel!
    
    
    
    //MARK:- Bank outlets
    
    @IBOutlet weak var BankInfoView: UIView!
    
    @IBOutlet weak var labelIBAN: UILabel!
    @IBOutlet weak var textIBAN: CustomTextField!
    @IBOutlet weak var labelSwiftBIC: UILabel!
    @IBOutlet weak var textSwiftBIC: CustomTextField!
    @IBOutlet weak var labelBank: UILabel!
    @IBOutlet weak var textBank: CustomTextField!
    
    @IBOutlet weak var lblBankAdd: UILabel!
    
    @IBOutlet weak var textBankAdd: CustomTextField!
    
    @IBOutlet weak var lblBankCountry: UILabel!
    
    @IBOutlet weak var btnDDBankCountry: UIButton!
    @IBOutlet weak var textBankCountry: CustomTextField!
    
    @IBOutlet weak var lblBankPostCode: UILabel!
    
    @IBOutlet weak var textBankPost: CustomTextField!

    @IBOutlet weak var btnBakPrev: UIButton!
    @IBOutlet weak var btnBankNext: UIButton!
    //MARK:- Password outlets

    @IBOutlet weak var passwordInfoBackView: UIView!
    @IBOutlet weak var labelPass: UILabel!
    @IBOutlet weak var textPass: CustomTextField!
    @IBOutlet weak var labelConfirmPass: UILabel!
    @IBOutlet weak var textConfirmPass: CustomTextField!
    @IBOutlet weak var btnSetPassBack: UIButton!
    @IBOutlet weak var btnSetPass: UIButton!
    
    @IBOutlet weak var nextLoginBtnBackView: UIView!
    @IBOutlet weak var btnLoginNow: UIButton!
    @IBOutlet weak var labelNoAccount: UILabel!
    
 
    //MARK:- Variables
    var datePicker = UIDatePicker()

    var signUpModelClass = SignUpViewModel()
    var customCountryDDView : CustomCountryDDView!
    
    var drpDownCounrtyListArray = [CountryModel]()
    var drpDownStateListArray = [StateModel]()
    var drpDownCityListArray = [CityModel]()
    
    var newDrpDownCounrtyListArray = [DrpDownListStruct]()
    var newDrpDownStateListArray = [DrpDownListStruct]()
    var newDrpDownCityListArray = [DrpDownListStruct]()
    var counrtyCodeListArray = [DrpDownListStruct]()
    var selectedTf: UITextField!
    
    
    var picker = UIImagePickerController()
    var selectedTxtFieldTag = 0
    var pickedImageUrl:URL?
    var agentDob = ""
    var setLocality = ""
    var countryPickerView: CountryPickerView?
    var selectedCountryCodePicker = ""
    
    //MARK:- Didload func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlStr = ""
        textDob.delegate = self
        let autocompleteController = GMSAutocompleteViewController()
         autocompleteController.delegate = self

        setUpView()
        
        textPersnalInfoCCode.delegate = self
        textCompanyCCode.delegate = self
        configCountryCodePicker()
        
        signUpModelClass.delegate = self
        signUpModelClass.getCountryListApi()
        textCountry.text = "Switzerland" //214
        textPersnalInfoCCode.text = "+41"
        textCompanyCCode.text = "+41"
        textCompCountry.text = "Switzerland"
        urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(textCountry.text!)"
        let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        signUpModelClass.getStateListApi(url: encodedURLString)
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
        components.calendar = calendar
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
        
        let doneButton = UIBarButtonItem(title: LTY_AlterText.text_Btn_Done.localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: LTY_AlterText.text_Btn_Cancel.localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
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
    
    
    //MARK:- SetUpView
    
    func setUpView () {
        
        lblTiltleGender.font                 = FontSize.size16
        lblTiltleGender.textColor            = Asset.Colors.gray1.color
        textSelectGender.font                  = FontSize.size16
        textSelectGender.textColor             = Asset.Colors.darkGrayColor.color
        textSelectGender.backgroundColor       = Asset.Colors.grayColor.color
        
        personalInfoSubTitleView.isHidden = false
        companyInfoSubTitleView.isHidden  = true
        bankInfoSubTitleView.isHidden = true
        passwordInfoSubTitleView.isHidden = true
        
        btnViewAttachment1.setTitle("View Attachment ->".localized(), for: .normal)
        btnViewAttachment2.setTitle("View Attachment ->".localized(), for: .normal)
        btnViewAttachment3.setTitle("View Attachment ->".localized(), for: .normal)
        labelTitle.font = FontSize.size20
        labelTitle.text = LTYText.textSignUpVCTitle1.localized()
        
        
        labelSubTitle.font = FontSize.size16
        labelSubTitle.text = LTYText.textSignUpVCSubTitle2.localized()
        
        
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = false
        BankInfoView.isHidden = true
        passwordInfoBackView.isHidden   = true
        
        //=================================================================
        
        lblBankCity.font             = FontSize.size16
        lblBankCity.textColor        = Asset.Colors.gray1.color
        lblBankCity.text        = "City".localized()
        textBankCity.font              = FontSize.size16
        textBankCity.textColor         = Asset.Colors.darkGrayColor.color
        textBankCity.backgroundColor   = Asset.Colors.grayColor.color
        
        lblBankState.font             = FontSize.size16
        lblBankState.textColor        = Asset.Colors.gray1.color
        lblBankState.text        = "State".localized()
        textBankSate.font              = FontSize.size16
        textBankSate.textColor         = Asset.Colors.darkGrayColor.color
        textBankSate.backgroundColor   = Asset.Colors.grayColor.color
        
        lblPersnalInfoCCode.font             = FontSize.size16
        lblPersnalInfoCCode.textColor        = Asset.Colors.gray1.color
        lblPersnalInfoCCode.text       = "Code".localized()
        textPersnalInfoCCode.font              = FontSize.size16
        textPersnalInfoCCode.textColor         = Asset.Colors.darkGrayColor.color
        textPersnalInfoCCode.backgroundColor   = Asset.Colors.grayColor.color
        
        
        lblCompanyCCode.font             = FontSize.size16
        lblCompanyCCode.textColor        = Asset.Colors.gray1.color
        lblCompanyCCode.text       = "Code".localized()
        textCompanyCCode.font              = FontSize.size16
        textCompanyCCode.textColor         = Asset.Colors.darkGrayColor.color
        textCompanyCCode.backgroundColor   = Asset.Colors.grayColor.color

        labelFinam.font             = FontSize.size16
        labelFinam.textColor        = Asset.Colors.gray1.color
        labelFinam.text        = "FINMA Number".localized()
        textFinam.font              = FontSize.size16
        textFinam.textColor         = Asset.Colors.darkGrayColor.color
        textFinam.backgroundColor   = Asset.Colors.grayColor.color
        
        labelCercio.font             = FontSize.size16
        labelCercio.textColor        = Asset.Colors.gray1.color
        labelCercio.text        = "Cicerio no".localized()
        textCercio.font              = FontSize.size16
        textCercio.textColor         = Asset.Colors.darkGrayColor.color
        textCercio.backgroundColor   = Asset.Colors.grayColor.color
        
        labelCompPhone.font             = FontSize.size16
        labelCompPhone.textColor        = Asset.Colors.gray1.color
        labelCompPhone.text      = "Company Phone".localized()
        textCompPhone.font              = FontSize.size16
        textCompPhone.textColor         = Asset.Colors.darkGrayColor.color
        textCompPhone.backgroundColor   = Asset.Colors.grayColor.color
        labelCompPhone.makeTextMandatory()
        
        labelCompEmail.font             = FontSize.size16
        labelCompEmail.textColor        = Asset.Colors.gray1.color
        labelCompEmail.text        = "Company Email".localized()
        textCompEmail.font              = FontSize.size16
        textCompEmail.textColor         = Asset.Colors.darkGrayColor.color
        textCompEmail.backgroundColor   = Asset.Colors.grayColor.color
        labelCompEmail.makeTextMandatory()
        
        labelCompState.font             = FontSize.size16
        labelCompState.textColor        = Asset.Colors.gray1.color
        labelCompState.text       = "State".localized()
        textCompState.font              = FontSize.size16
        textCompState.textColor         = Asset.Colors.darkGrayColor.color
        textCompState.backgroundColor   = Asset.Colors.grayColor.color
        
        labelCompCountry.font             = FontSize.size16
        labelCompCountry.textColor        = Asset.Colors.gray1.color
        labelCompCountry.text        = "Country".localized()
        textCompCountry.font              = FontSize.size16
        textCompCountry.textColor         = Asset.Colors.darkGrayColor.color
        textCompCountry.backgroundColor   = Asset.Colors.grayColor.color
        
        labelCompCity.font             = FontSize.size16
        labelCompCity.textColor        = Asset.Colors.gray1.color
        labelCompCity.text             = "City".localized()
        textCompCity.font              = FontSize.size16
        textCompCity.textColor         = Asset.Colors.darkGrayColor.color
        textCompCity.backgroundColor   = Asset.Colors.grayColor.color
        
        lblBankAdd.font             = FontSize.size16
        lblBankAdd.textColor        = Asset.Colors.gray1.color
        lblBankAdd.text             = LTYText.text_AgentAddress.localized()
        textBankAdd.font              = FontSize.size16
        textBankAdd.textColor         = Asset.Colors.darkGrayColor.color
        textBankAdd.backgroundColor   = Asset.Colors.grayColor.color
 
        lblPrivateCriminalRecord.font             = FontSize.size16
        lblPrivateCriminalRecord.textColor        = Asset.Colors.gray1.color
        lblPrivateCriminalRecord.text        = "Private Criminal Record".localized()
        
        textPrivateCRecord.font              = FontSize.size16
        textPrivateCRecord.textColor         = Asset.Colors.darkGrayColor.color
      
        textPrivateCRecord.backgroundColor   = Asset.Colors.grayColor.color
        
        lblPrivateOP.font             = FontSize.size16
        lblPrivateOP.textColor        = Asset.Colors.gray1.color
        lblPrivateOP.text        = "Private OP".localized()
        textPrivateOP.font              = FontSize.size16
        textPrivateOP.textColor         = Asset.Colors.darkGrayColor.color
        textPrivateOP.backgroundColor   = Asset.Colors.grayColor.color
        
        lblCompanyPO.font             = FontSize.size16
        lblCompanyPO.textColor        = Asset.Colors.gray1.color
        lblCompanyPO.text        = "Company PO".localized()
        textCompanyPO.font              = FontSize.size16
        textCompanyPO.textColor         = Asset.Colors.darkGrayColor.color
        textCompanyPO.backgroundColor   = Asset.Colors.grayColor.color
        
        
        
        lblBankCountry.font             = FontSize.size16
        lblBankCountry.textColor        = Asset.Colors.gray1.color
        lblBankCountry.text             = LTYText.textSignUpVCComCountry.localized()
        textBankCountry.font              = FontSize.size16
        textBankCountry.textColor         = Asset.Colors.darkGrayColor.color
        textBankCountry.backgroundColor   = Asset.Colors.grayColor.color
        
        lblBankPostCode.font             = FontSize.size16
        lblBankPostCode.textColor        = Asset.Colors.gray1.color
        lblBankPostCode.text             = LTYText.textSignUpVCPostCode.localized()
        textBankPost.font              = FontSize.size16
        textBankPost.textColor         = Asset.Colors.darkGrayColor.color
        textBankPost.backgroundColor   = Asset.Colors.grayColor.color
        
  
        
        //=================================================================
        
        
        //dob
        lblDob.font             = FontSize.size16
        lblDob.textColor        = Asset.Colors.gray1.color
        lblDob.text             = LTYText.dob.localized()
        textDob.font              = FontSize.size16
        textDob.textColor         = Asset.Colors.darkGrayColor.color
        textDob.backgroundColor   = Asset.Colors.grayColor.color
        lblDob.makeTextMandatory()
        
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
      //  labelWebSite.makeTextMandatory()

        
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
        textCompCountry.font                = FontSize.size16
        textCompCountry.textColor           = Asset.Colors.darkGrayColor.color
        textCompCountry.backgroundColor     = Asset.Colors.grayColor.color
        textCompCountry.placeholder         = LTYText.textSignUpVCComCountryPlaceHolder
        
        
        // 3
        labelPass.font             = FontSize.size16
        labelPass.textColor        = Asset.Colors.gray1.color
        labelPass.text             = LTYText.textSignUpVCPass.localized()
        textPass.font              = FontSize.size16
        textPass.textColor         = Asset.Colors.darkGrayColor.color
        textPass.backgroundColor   = Asset.Colors.grayColor.color
        textPass.placeholder       = LTYText.textSignUpVCPassPlaceHolder
        labelPass.makeTextMandatory()

        
        
        labelConfirmPass.font              = FontSize.size16
        labelConfirmPass.textColor         = Asset.Colors.gray1.color
        labelConfirmPass.text              = LTYText.textSignUpVCConfPass.localized()
        textConfirmPass.font               = FontSize.size16
        textConfirmPass.textColor          = Asset.Colors.darkGrayColor.color
        textConfirmPass.backgroundColor    = Asset.Colors.grayColor.color
        textConfirmPass.placeholder        = LTYText.textSignUpVCConfPassPlaceHolder
        labelConfirmPass.makeTextMandatory()

        
        //1
        btnPersonalInfoNext.viewCorner(8)
        btnPersonalInfoNext.backgroundColor = Asset.Colors.lightBlue.color
        btnPersonalInfoNext.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
      
        btnPersonalInfoNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        
        //2
        btnCompInfoBack.viewCorner(8)
        btnCompInfoBack.titleLabel?.textColor = Asset.Colors.lightGray.color
        btnCompInfoBack.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        btnCompInfoBack.setTitle(LTYText.textSignUpVCPrevious.localized(), for: .normal)
        btnCompInfoBack.backgroundColor    = Asset.Colors.grayColor.color
        
        btnCompInfoNext.viewCorner(8)
        btnCompInfoNext.backgroundColor = Asset.Colors.lightBlue.color
        btnCompInfoNext.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnCompInfoNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        
        //2
        btnBakPrev.viewCorner(8)
        btnBakPrev.titleLabel?.textColor = Asset.Colors.lightGray.color
        btnBakPrev.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        btnBakPrev.setTitle(LTYText.textSignUpVCPrevious.localized(), for: .normal)
        btnBakPrev.backgroundColor    = Asset.Colors.grayColor.color
        
        btnBankNext.viewCorner(8)
        btnBankNext.backgroundColor = Asset.Colors.lightBlue.color
        btnBankNext.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnBankNext.setTitle(LTYText.textSignUpVCNext.localized(), for: .normal)
        
        //3
        btnSetPassBack.viewCorner(8)
        btnSetPassBack.titleLabel?.textColor = Asset.Colors.lightGray.color
        btnSetPassBack.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        btnSetPassBack.setTitle(LTYText.textSignUpVCPrevious.localized(), for: .normal)
        btnSetPassBack.backgroundColor    = Asset.Colors.grayColor.color
        
        btnSetPass.viewCorner(8)
        btnSetPass.backgroundColor = Asset.Colors.lightBlue.color
        btnSetPass.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnSetPass.setTitle(LTYText.textSignUpVCSetPass.localized(), for: .normal)
        
        
        btnLoginNow.backgroundColor = Asset.Colors.whiteColor.color
        btnLoginNow.setTitleColor(Asset.Colors.lightBlue.color, for: .normal)
        btnLoginNow.setTitle(LTYText.textSignUpVCLogIn.localized(), for: .normal)
        btnLoginNow.setTitle(LTYText.textSignUpVCLogIn.localized(), for: .normal)
        labelNoAccount.font = UIFont(name:"Helvetica",size:16)
        labelNoAccount.textColor = Asset.Colors.darkGrayColor.color
        labelNoAccount.text = LTYText.textSignUpVCAlreadyAcc.localized()
    }
    
    //MARK:- Back/Previous CompanyInfo Btn Action
    
    @IBAction func btnCompInfoBackAction(_ sender: UIButton){
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = false
        BankInfoView.isHidden = true
        passwordInfoBackView.isHidden   = true
        
        personalInfoSubTitleView.isHidden = false
        companyInfoSubTitleView.isHidden  = true
        bankInfoSubTitleView.isHidden = true
        passwordInfoSubTitleView.isHidden = true
        
        labelTitle.text = LTYText.textSignUpVCTitle1.localized()
        labelSubTitle.text = LTYText.textSignUpVCSubTitle2.localized()
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        
    }
    //MARK:- Back/Previous SetPassword Btn Action
    @IBAction func btnSetPassBackAction(_ sender: UIButton){
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = true
        BankInfoView.isHidden = false
        passwordInfoBackView.isHidden   = true
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = true
        bankInfoSubTitleView.isHidden = false
        passwordInfoSubTitleView.isHidden = true
        
        labelTitle.text = LTYText.textSignUpVCSubTitle33.localized()
        labelSubTitle.text = LTYText.textSignUpVCSubTitle33.localized()
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    
    @IBAction func btnBankIfoPrev(_ sender: UIButton) {
        personalInfoBackView.isHidden   = false
        companyInfoBackView.isHidden    = true
        BankInfoView.isHidden = true
        passwordInfoBackView.isHidden   = true
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = false
        bankInfoSubTitleView.isHidden = true
        passwordInfoSubTitleView.isHidden = true
        
        labelTitle.text = LTYText.textSignUpVCSubTitle2.localized()
        labelSubTitle.text = LTYText.textSignUpVCSubTitle1.localized()
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        
    }
    //MARK:- Next PersonalInfo Btn Action
    @IBAction func btnPersonalInfoNextAction(_ sender: UIButton) {
        checkPersonalInfoValidation()
    }
    //MARK:- Next CompInfo Btn Action
    @IBAction func btnCompInfoNextAction(_ sender: UIButton) {
        checkCompInfoValidation()
    }
    @IBAction func btnBankInfoNext(_ sender: UIButton) {
        
          if textBankPost.text != ""{
            let postCode = textCompPostCode.text!
            guard postCode.isLengthValid(minLength: 4, maxLength: 6) else  {
                self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation.localized(), title: LTY_AlterText.messagePostCodeValidation.localized())
                return
            }
        }
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = true
        BankInfoView.isHidden = true
        passwordInfoBackView.isHidden   = false
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = true
        bankInfoSubTitleView.isHidden = true
        passwordInfoSubTitleView.isHidden = false
        
        labelTitle.text = LTYText.textSignUpVCSubTitle3.localized()
        labelSubTitle.text = LTYText.textSignUpVCSubTitle3.localized()
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    //MARK:- Next Setpassword Btn Action
    @IBAction func btnSetPassNextAction(_ sender: UIButton) {
        checkSetPassValidation()
    }
    //MARK:- Login Btn Action
    @IBAction func btnLoginAction(_ sender: UIButton) {
        popVC(animated: true)
    }
    
    //MARK:- check signup all field text validation
    
    func checkPersonalInfoValidation() {
       
        guard let firstName = textFirstName.text, !firstName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageFirstName.localized(), title: LTY_AlterText.firstName.localized())
            return
        }
        if containsNumbers(textField: textFirstName) {
            self.ShowAlert(message: LTY_AlterText.messageFirstNameNumberValidation, title: LTY_AlterText.firstName)
            return
        }
        guard  let lastName = textLastName.text, !lastName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageLastName.localized(), title: LTY_AlterText.lastName.localized())
            return
        }
        if containsNumbers(textField: textLastName) {
            self.ShowAlert(message: LTY_AlterText.messageLastNameNumberValidation, title: LTY_AlterText.lastName)
            return
        }
        guard let mobile = textPhone.text, !mobile.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageMobile.localized(), title: LTY_AlterText.mobile.localized())
            return
        }
        guard mobile.isLengthValid(minLength: 8, maxLength: 13) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation.localized(), title: LTY_AlterText.mobile.localized())
            return
        }
        guard let email = textEmail.text?.trim() , !email.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageEmail.localized(), title: LTY_AlterText.email.localized())
            return
        }
        guard email.isValidEmail() else {
            self.ShowAlert(message: LTY_AlterText.messageEmailVarification.localized(), title: LTY_AlterText.email.localized())
            return
        }
        guard  let address = textAddress.text, !address.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageAddress.localized(), title: LTY_AlterText.address.localized())
            return
        }
        
        if address.containsOnlyAlphanumeric() {
            print("Contains only alphanumeric characters!")
        } else {
            self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
            return
        }

        guard  let country = textCountry.text, !country.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCountry.localized(), title: LTY_AlterText.country.localized())
            return
        }
        
        if agentDob == ""{
            self.ShowAlert(message: LTY_AlterText.messageDob, title: LTY_AlterText.dob)

            return
        }
        
        guard  let gender = textSelectGender.text, !gender.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messagegender, title: LTY_AlterText.gender)
            return
        }
        guard let state = textState.text, !state.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageState.localized(), title: LTY_AlterText.state.localized())
            return
        }
        guard let city = textCity.text, !city.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCity.localized(), title: LTY_AlterText.city.localized())
            return
        }
        guard  let postCode = textPostCode.text, !postCode.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messagePostCode.localized(), title: LTY_AlterText.postCode.localized())
            return
        }
        
        guard postCode.isLengthValid(minLength: 4, maxLength: 6) else  {
            self.ShowAlert(message: LTY_AlterText.messagePostCodeValidation.localized(), title: LTY_AlterText.messagePostCodeValidation.localized())
            return
        }
        
        guard let language = textLanguage.text, !language.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageLanguage.localized(), title: LTY_AlterText.language.localized())
            return
        }
        guard let nationality = textNationality.text, !nationality.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageNationality.localized(), title: LTY_AlterText.nationality.localized())
            
            return
        }
  
        personalInfoBackView.isHidden   = true
        companyInfoBackView.isHidden    = true
        BankInfoView.isHidden = false
        passwordInfoBackView.isHidden   = true
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = true
        passwordInfoSubTitleView.isHidden = true
        bankInfoSubTitleView.isHidden = false
        
        labelTitle.text = LTYText.textSignUpVCSubTitle33.localized()
        labelSubTitle.text = LTYText.textSignUpVCSubTitle33.localized()
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func checkCompInfoValidation() {
      
        guard let companyName = textCompanyName.text, !companyName.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageCompanyName.localized(), title: LTY_AlterText.companyName.localized())
            return
        }
        if textWebSite.text != ""{
            //        guard let website = textWebSite.text, !website.isEmpty else {
            //            self.ShowAlert(message: LTY_AlterText.messageWebsite.localized(), title: LTY_AlterText.website.localized())
            //            return
            //        }
            let website = textWebSite.text!
            guard  website.isValidUrl(url: website)else {
                self.ShowAlert(message: LTY_AlterText.messageValidWebsite.localized(), title: LTY_AlterText.website.localized())
                return
            }
        }
        
        guard let mobile = textCompPhone.text, !mobile.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageMobile.localized(), title: LTY_AlterText.mobile.localized())
            return
        }
        guard mobile.isLengthValid(minLength: 8, maxLength: 13) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation.localized(), title: LTY_AlterText.mobile.localized())
            return
        }
        guard let email = textCompEmail.text?.trim() , !email.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageEmail.localized(), title: LTY_AlterText.email.localized())
            return
        }
        guard email.isValidEmail() else {
            self.ShowAlert(message: LTY_AlterText.messageEmailVarification.localized(), title: LTY_AlterText.email.localized())
            return
        }
        if textCompAddress.text != ""{
            
//            if textCompAddress.text?.containsEmoji == true {
//                self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
//                return
//            }
            if textCompAddress.text!.containsOnlyAlphanumeric() {
                print("Contains only alphanumeric characters!")
            } else {
                self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
                return
            }
        }
    
        /*
         guard let compAddress = textCompAddress.text, !compAddress.isEmpty else {
         self.ShowAlert(message: "Please enter your Company Address", title: "Company Address")
         return
         }
         guard let compPostCode = textCompPostCode.text, !compPostCode.isEmpty else {
         self.ShowAlert(message: "Please enter your company PostCode", title: "Company PostCode")
         return
         }
         guard let compCountry = textCompCountry.text, !compCountry.isEmpty else {
         self.ShowAlert(message: "Please enter your company country", title: "Company Country")
         return
         }
         guard  let iban = textIBAN.text, !iban.isEmpty else {
         self.ShowAlert(message: "Please enter your iban", title: "IBAN")
         return
         }
         guard  let swift = textSwiftBIC.text, !swift.isEmpty else {
         self.ShowAlert(message: "Please enter your swift", title: "Swift")
         return
         }
         guard  let bank = textBank.text, !bank.isEmpty else {
         self.ShowAlert(message: "Please enter your bank", title: "Bank")
         return
         }
         */
        personalInfoBackView.isHidden   = false
        companyInfoBackView.isHidden    = true
        BankInfoView.isHidden = true
        passwordInfoBackView.isHidden   = true
        
        personalInfoSubTitleView.isHidden = true
        companyInfoSubTitleView.isHidden  = false
        bankInfoSubTitleView.isHidden = true
        passwordInfoSubTitleView.isHidden = true
 
        
        labelTitle.text = LTYText.textSignUpVCSubTitle1.localized()
        labelSubTitle.text = LTYText.textSignUpVCSubTitle1.localized()
        
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    
    func checkSetPassValidation() {
        
        if textBankAdd.text != ""{
            
            if textBankAdd.text!.containsOnlyAlphanumeric() {
                print("Contains only alphanumeric characters!")
            } else {
                self.ShowAlert(message: LTY_AlterText.messageAddress, title: LTY_AlterText.address)
                return
            }
        }
        guard let password = textPass.text, !password.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messagePassword.localized(), title: LTY_AlterText.password.localized())
            return
        }
        guard password.isPasswordValidation(password: textPass.text!) else
        {
            self.ShowAlert(message: LTY_AlterText.messagePassValidation.localized(), title: LTY_AlterText.password.localized())
            return
        }
        guard let confirmPassword = textConfirmPass.text ,!confirmPassword.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageconfirmPass.localized(), title: LTY_AlterText.confirmPass.localized())
            return
        }
        guard password == confirmPassword else {
            self.ShowAlert(message: LTY_AlterText.messageConfrimPassValidation.localized(), title: "")
            return
        }
        
//                let firstName = "Test"//textFirstName.text ?? ""
//                let lastName =  "S1"//textLastName.text ?? ""
//                let email =  textEmail.text ?? ""
//                let mobile =  "1234567890"//textPhone.text ?? ""
//                let country = "India"//textCountry.text ?? ""
//                let state =  "UP"//textState.text ?? ""
//                let city =  "Noida"//textCity.text ?? ""
//                let address =  "noida sector 98"//textAddress.text ?? ""
//                let postCode =  "201301"//textPostCode.text ?? ""
//                let language =  "English"//textLanguage.text ?? ""
//                let nationality =  "Indian"//textNationality.text ?? ""
//                let companyName =  "Test Partner"//textCompanyName.text ?? ""
//                let website =  "www.testpartner.com"//textWebSite.text ?? ""
//                let compAddress =  "noida sector 44 Goutam buddhe nagar"//textCompAddress.text ?? ""
//                let compPostCode =  "201303"//textCompPostCode.text ?? ""
//                let compCountry = "India"//textCompCountry.text ?? ""
//                let iban =  "qwerty"//textIBAN.text ?? ""
//                let swift =  "asdfghjkl"//textSwiftBIC.text ?? ""
//                let bank =  "fedderal bank test "//textBank.text ?? ""
 //               let password =  "123456"//textBank.text ?? ""

        
        let userDob             = agentDob
        let gender             = textSelectGender.text ?? ""
        let countryCode           = textPersnalInfoCCode.text ?? ""
        let firstName       = textFirstName.text ?? ""
        let lastName        =  textLastName.text ?? ""
        let email           =  textEmail.text ?? ""
        let mobile          = textPhone.text ?? ""
        let country         = textCountry.text ?? ""
        let state           = textState.text ?? ""
        let city            = textCity.text ?? ""
        let address         = textAddress.text ?? ""
        let postCode        = textPostCode.text ?? ""
        let language        = textLanguage.text ?? ""
        let nationality     = textNationality.text ?? ""
        let companyName     = textCompanyName.text ?? ""
        let website         = textWebSite.text ?? ""
        let compAddress     = textCompAddress.text ?? ""
        let compPostCode    = textCompPostCode.text ?? ""
        let compCountry     = textCompCountry.text ?? ""
        let iban            = textIBAN.text ?? ""
        let swift           = textSwiftBIC.text ?? ""
        let bank            = textBank.text ?? ""
        
        let Finam            = textFinam.text ?? ""
        let Cercio            = textCercio.text ?? ""
        let CompEmail            = textCompEmail.text ?? ""
        let CompPhone            = textCompPhone.text ?? ""
        let CompCountryCode            = textCompanyCCode.text ?? ""
        let CompState            = textCompState.text ?? ""
        let CompCity            = textCompCity.text ?? ""
        let PrivateCRecord            = textPrivateCRecord.text ?? ""
        let PrivateOP            = textPrivateOP.text ?? ""
        let CompanyPO           = textCompanyPO.text ?? ""
        
        let bankCountry            = textBankCountry.text ?? ""
        let bankState            = textBankSate.text ?? ""
        let bankCity           = textBankCity.text ?? ""
        let bankPost            = textBankPost.text ?? ""
        let bankAdd            = textBankAdd.text ?? ""

        
        
        checkNetwork(params: SignUpParams.init(type: LTY_TYPE, subscriptionPlan: LTY_SUBSCIPTIONPLAN, source: LTY_SOURCE, firstName: firstName, lastName: lastName, mobile: CompPhone, gender: gender,countryCode:CompCountryCode,email: CompEmail, country: country, state: state, city: city, address: address, postCode: postCode, language: language, nationality: nationality, companyDetails: .init(companyName: companyName, website: website, logo: "", finamNo:Finam, ciceroNo: Cercio, email: email, telephone: mobile,countryCode:countryCode, country: compCountry, state: CompState, city:CompCity, address: compAddress, postCode: compPostCode, privateCriminalRecord: PrivateCRecord, privateOp: PrivateOP, companyPo:CompanyPO), bankDetails: SignUpBankDetailSubParams.init(iban: iban, swift: swift, bank: bank, country:bankCountry,state: bankState,city: bankCity, postCode: bankPost, address: bankAdd, houseOwned: ""), password: password,dob:userDob))
        
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:SignUpParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            signUpModelClass.networkServiceCall(param:params)
        }
        else {
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert.localized())
        }
    }
    
    //MARK:-
    @IBAction func hideShowPasswordBtnAction(_ sender: UIButton) {
        if sender.tag == 101 {
            sender.isSelected = !sender.isSelected
            textPass.isSecureTextEntry = !textPass.isSecureTextEntry
        }
        else {
            sender.isSelected = !sender.isSelected
            textConfirmPass.isSecureTextEntry = !textConfirmPass.isSecureTextEntry
        }
    }
    
    
    //MARK:- Upload documents
    
    @IBAction func btnUploadDocuments(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 601:
            self.selectedTf = self.textPrivateCRecord
            self.chooseWhatToUpload()
        case 602:
            self.selectedTf = self.textPrivateOP
            self.chooseWhatToUpload()
        case 603:
            self.selectedTf = self.textCompanyPO
            self.chooseWhatToUpload()
            
        default:
            print("")
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
    
    func setLocation () {
        let vc = SearchYourLocationVC.instantiate(fromAppStoryboard: .home)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    //MARK:- viewAttachment
    
    @IBAction func onClickViewAttachments(_ sender: UIButton) {
        if sender.tag == 201 {
            if self.textPrivateCRecord.text?.isEmpty == true {
                self.ShowAlert(message: "No data found !!".localized())
            }else{
                let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
                vc.attachmentStr = self.textPrivateCRecord.text!
                self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            }
            
        } else if sender.tag == 202 {
            if self.textPrivateOP.text?.isEmpty == true {
                self.ShowAlert(message: "No data found !!".localized())
            }else{
                let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
                vc.attachmentStr = self.textPrivateOP.text!
                self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            }
        } else if sender.tag == 203 {
            if self.textPrivateOP.text?.isEmpty == true {
                self.ShowAlert(message: "No data found !!".localized())
            }else{
                let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
                vc.attachmentStr = self.textCompanyPO.text!
                self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            }
        }
    }
    
    
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
                self.ShowAlert(message: LTY_AlterText.messageCountry.localized(), title: "")
                return
            }
            
            self.customCountryDDView.listArray = newDrpDownStateListArray
            self.customCountryDDView.filteredData = newDrpDownStateListArray
        case 203:
            print("City Drop Down")
            guard self.textState.text != "" else {
                self.ShowAlert(message: LTY_AlterText.messageState.localized(), title: "")
                return
            }
            self.customCountryDDView.listArray = newDrpDownCityListArray
            self.customCountryDDView.filteredData = newDrpDownCityListArray
        case 204:
            print("Language Drop Down")
            
          
            let langArr = [LTYText.french.localized(),LTYText.english.localized(),LTYText.italian.localized(),LTYText.portuguese.localized(),LTYText.albanian.localized()]//["French","English","Italian", "Portuguese","Albanian"]
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
        case 401:
            print("Country Drop Down")
            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        case 402:
            print("State Drop Down")
            guard self.textCompCountry.text != "" else {
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
//
//        case 701:
//            print("open country code picker")
//
//            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
//            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
//
//        case 702:
//            print("open country code picker")
//
//            self.customCountryDDView.listArray = newDrpDownCounrtyListArray
//            self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
        default:
            print("Have you done something new?")
        }
        self.view.addSubview(self.customCountryDDView)
    }
    
    
    func setDrpDownText(id:String, name:String, phoneCode:Int) {
        var urlStr = ""
        switch self.selectedTxtFieldTag {
         
//        case 701:
//            self.textPersnalInfoCCode.text = "\("+")\(phoneCode)"
//
//        case 702:
//            self.textCompanyCCode.text = "\("+")\(phoneCode)"
            
        case 201:
            self.textCountry.text = name
            self.textState.text = ""
            self.textCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            signUpModelClass.getStateListApi(url: encodedURLString)
        case 202:
            if self.textCountry.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageCountry.localized(), title: "")
            }
            else
            {
                self.textState.text = name
                self.textCity.text = ""
                self.newDrpDownCityListArray.removeAll()
                urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.CITY_URL)\(name)"
                let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                signUpModelClass.getCityListApi(url: encodedURLString)
            }
        case 203:
            if self.textState.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageState.localized(), title: "")
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
            signUpModelClass.getStateListApi(url: encodedURLString)
            
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
                signUpModelClass.getCityListApi(url: encodedURLString)
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
          //MARK:- for company selection
            
        case 401:
            self.textCompCountry.text = name
            self.textCompState.text = ""
            self.textCompCity.text = ""
            self.newDrpDownStateListArray.removeAll()
            self.newDrpDownCityListArray.removeAll()
            urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.STATES_URL)\(name)"
            let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            signUpModelClass.getStateListApi(url: encodedURLString)

        case 402:
            if self.textCompCountry.text == ""
            {
                self.ShowAlert(message: LTY_AlterText.messageCountry, title: "")
            }
            else
            {
                self.textCompState.text = name
                self.textCompCity.text = ""
                self.newDrpDownCityListArray.removeAll()
                urlStr = "\(LTY_BASE_URL.BASE_URL_COMMON)\(LTY_END_POINT_URL.CITY_URL)\(name)"
                let encodedURLString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                signUpModelClass.getCityListApi(url: encodedURLString)
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
    
    
    @IBAction func btnOnClickCountryCode(_ sender: UIButton) {
        print("open country code picker")
        if sender.tag == 701 {
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

// MarK:
extension SignUpVC : passCurrentLocation {
    
    func passLocationData(lat: Double, lang: Double, address: String) {
        print(address)
//        latitude = lang
//        longititude = lang
//        self.address = address
//        textFieldUserDegination.text = address
    }
    
}

extension SignUpVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
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


extension SignUpVC: GMSAutocompleteViewControllerDelegate {

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
                      self.textCompAddress.text = "\(place.name ?? "")"
                    self.textCompCity.text = city
                  }else{
                      self.textBankAdd.text = "\(place.name ?? "")"
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
                      
                      self.textCompCountry.text = country
                  }else{
                      self.textBankCountry.text = country
                  }
                 
              }
              if let postCode = placemark.postalCode {
                  print("PostCode: \(postCode)")
                  
                  if self.setLocality == "persnalInfo" {
                      self.textPostCode.text = postCode
                  }else if self.setLocality == "compInfo" {
                      
                      self.textCompPostCode.text = postCode
                  }else{
                      self.textBankPost.text = postCode
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

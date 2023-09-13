//
//  UpdatePhoneEmailVC.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 22/05/23.
//

import UIKit
import CountryPickerView

protocol DismissScreenInProfileModule{
    func dismissScreenInProfileModule(setValue:Bool,data:ForgotPassValue, isComming:String)
}

class UpdatePhoneEmailVC: UIViewController, SetDrpDownText, UITextFieldDelegate{
    
    
    func setDrpDownText(id: String, name: String, phoneCode: Int) {
        textCountyCode.text = "\("+")\(phoneCode)"
    }
    
    
    //MARK:- Outlets
    
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var textCountyCode: UITextField!
    @IBOutlet weak var phoneCodeView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textEmail: CustomTextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    //MARK:- Variables
    
    var updatePhoneEmailViewModel = UpdatePhoneEmailViewModel()
    var delegate : DismissScreenInProfileModule?
    var isCommingFrom = ""
    var agentId = ""
    var drpDownCounrtyListArray = [CountryModel]()
    var newDrpDownCounrtyListArray = [DrpDownListStruct]()
    var customCountryDDView : CustomCountryDDView!
    var countryPickerView: CountryPickerView?

    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        textCountyCode.delegate = self
        configCountryCodePicker()
        
        updatePhoneEmailViewModel.delegate = self
        updatePhoneEmailViewModel.getCountryListApi()
        //view.isOpaque = false
    }
    //MARK:- SetUpFunc
    func setUpView() {
        
        lineView.viewCorner(5)
        mainView.viewCorner(15)
        btnUpdate.viewCorner(8)
        
        labelEmail.font =  FontSize.size16
        lblCountryCode.font =  FontSize.size16
        textEmail.font =  FontSize.size16
        textCountyCode.font =  FontSize.size16
        btnCancel.titleLabel?.font = FontSize.size16
        btnUpdate.titleLabel?.font =  FontSize.size16
        
        textEmail.backgroundColor = Asset.Colors.grayColor.color
        textCountyCode.backgroundColor = Asset.Colors.grayColor.color
        
        labelEmail.textColor = Asset.Colors.gray1.color
        lblCountryCode.textColor = Asset.Colors.gray1.color
        textEmail.textColor = Asset.Colors.darkGrayColor.color
        textCountyCode.textColor = Asset.Colors.darkGrayColor.color
        
        if isCommingFrom == "update_email"
        {
            textEmail.keyboardType = .emailAddress
            phoneCodeView.isHidden = true
            labelEmail.text = LTYText.textUpdatePhoneEmailVC_Email
            textEmail.placeholder = LTYText.textUpdatePhoneEmailVC_PlaceHolderEmail
        }
        else
        {
            textEmail.keyboardType = .numberPad
            phoneCodeView.isHidden = false
            textCountyCode.text = "+41"
            kUserDefaults.set(textCountyCode.text, forKey: "UpdatePhoneCode")
            labelEmail.text = LTYText.textUpdatePhoneEmailVC_Phone
            textEmail.placeholder = LTYText.textUpdatePhoneEmailVC_PlaceHolderPhone
            textCountyCode.placeholder = LTYText.textUpdateCountryCode

        }
        
        btnUpdate.setTitle(LTYText.textUpdatePhoneEmailVC_Update, for: .normal)
        btnCancel.setTitle(LTYText.textForgotVC_Cancel, for: .normal)
        btnUpdate.backgroundColor = Asset.Colors.lightBlue.color
        btnUpdate.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
    }
    
    //MARK:- open country Code Picker
    
    @IBAction func btnOpenCountryPicker(_ sender: UIButton) {
        let vc = ChooseCountryVC.instantiate(fromAppStoryboard: .home)
        vc.filteredData = newDrpDownCounrtyListArray
        vc.listArray = newDrpDownCounrtyListArray
        vc.countryCodeDelegate = self
        self.topMostViewController.presentVC(vc, animated: true, presentationStyle: .overCurrentContext)
       // pushToVC(vc, animated: true)
//        self.customCountryDDView = CustomCountryDDView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        self.customCountryDDView.delegate = self
//
//        self.customCountryDDView.listArray = newDrpDownCounrtyListArray
//        self.customCountryDDView.filteredData = newDrpDownCounrtyListArray
    }
    
    //MARK:- Recover Password Btn Action
    
    @IBAction func btnUpdateAction(_ sender: UIButton) {
        if isCommingFrom == "update_email"
        {
            textEmail.keyboardType = .emailAddress
            checkEmailValidation()
        }
        else
        {
            textEmail.keyboardType = .numberPad

            checkPhoneValidation()
        }
    }
    
    //MARK:- check Email and Password text validation
    
    func checkEmailValidation() {
        
        guard let email = textEmail.text?.trim() , !email.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.messageEmail, title: LTY_AlterText.email)
            
            return
        }
        
        guard  email.isValidEmail() else {
            
            self.ShowAlert(message:LTY_AlterText.messageEmailVarification, title: LTY_AlterText.emailVarification)
            
            return
        }
        let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
        checkNetworkForEmail(params:["partnerId": partnerId, "newEmail": email])
    }
    
    func checkPhoneValidation() {
        
        guard let phone = textEmail.text?.trim() , !phone.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.messageMobile, title: LTY_AlterText.mobile)
            return
        }
        
        guard phone.isLengthValid(minLength: 9, maxLength: 13) else  {
            self.ShowAlert(message: LTY_AlterText.messageMobileValidation, title: LTY_AlterText.mobile)
            return
        }
        
        guard let countryCode = textCountyCode.text?.trim() , !countryCode.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.msgCountryCode, title: LTY_AlterText.alertCountryCode)
            return
        }
        
        if agentId != ""{
            checkNetworkForPhone(params:["partnerId": agentId, "newMobile": phone,"countryCode":countryCode])
        }else {
            let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
            
            checkNetworkForPhone(params:["partnerId": partnerId, "newMobile": phone,"countryCode":countryCode])
        }

    }
    
    
    
    //MARK:-  check internet Connection
    
    func checkNetworkForEmail(params:[String:Any]) {
        if internetConnection.isConnectedToNetwork() == true {
            updatePhoneEmailViewModel.updateEmailApi(param: params)
        }
        else {
            self.ShowAlert(message: "Please check your internet")
        }
    }
    func checkNetworkForPhone(params:[String:Any]) {
        if internetConnection.isConnectedToNetwork() == true {
            updatePhoneEmailViewModel.updatePhoneApi(param: params)
        }
        else {
            self.ShowAlert(message: "Please check your internet")
        }
    }
    //MARK:- Cancel Btn Action
    @IBAction func btnCancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func btnOnClickCountryCode(_ sender: UIButton) {
        print("open country code picker")
     
            self.countryPickerView?.showCountriesList(from: self)
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


extension UpdatePhoneEmailVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        
            self.textCountyCode.text = country.phoneCode
        kUserDefaults.set(country.phoneCode, forKey: "UpdatePhoneCode")

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
extension UpdatePhoneEmailVC :SetCountyCode {
    func setCountryCode(countyCode: Int) {
        
        textCountyCode.text = "\("+")\(countyCode)"
        kUserDefaults.set(textCountyCode.text, forKey: "UpdatePhoneCode")

    }
    
    
}

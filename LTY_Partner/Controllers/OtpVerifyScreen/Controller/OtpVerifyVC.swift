//
//  OtpVerifyVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 12/05/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SGCodeTextField


protocol DismissOtpVerifyVCDelegate {
    func dimissOtpVerifyVC(setValue:Bool)
}


class OtpVerifyVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var otpTextField: SGCodeTextField!
    @IBOutlet weak var emailOtpTextField: SGCodeTextField!

    @IBOutlet var backView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelShowMobileNum: UILabel!
    @IBOutlet weak var labelShowEmail: UILabel!
    @IBOutlet weak var btnVerifyPass: UIButton!
    
   
    @IBOutlet weak var labelShowMobileTimer: UILabel!
    @IBOutlet weak var labelShowEmailTimer: UILabel!
 
    @IBOutlet weak var stackPhoneView: UIStackView!
    
    @IBOutlet weak var stackEmailView: UIStackView!
    
    @IBOutlet weak var btnResendEmailOtp: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnResendMobileOtp: UIButton!
    
    //MARK:- Variables
    
    var otpId = ""
    var emailOtpID = ""
    var fcmKeyValue = ""
    var phoneNumber = ""
    var timer: Timer?
    var runCount = 30
    var verifiedEmail = ""
    var checkInternetConnection = 0
    var comingFrom = ""
    var agentID = ""
    var otpVerifyViewModel = OtpVerifyViewModel()
    var delegate : DismissOtpVerifyVCDelegate?
    
    var group = DispatchGroup()
    
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        otpVerifyViewModel.delegate = self
    }
    
    //MARK:- Will appear func
    
    override func viewWillAppear(_ animated: Bool) {
        if comingFrom == "loginVC"{
            stackEmailView.isHidden = true
        }
        else {
//            if comingFrom == "update_email"
//            {
//                self.stackEmailView.isHidden = false
//                self.stackPhoneView.isHidden = true
//            }
//            else if comingFrom == "update_phone"
//            {
////                self.stackEmailView.isHidden = true
////                self.stackPhoneView.isHidden = false
//                self.stackEmailView.isHidden = false
//                self.stackPhoneView.isHidden = true
//            }
            if (comingFrom == "update_email") || (comingFrom == "update_phone")
            {
                self.stackEmailView.isHidden = false
                self.stackPhoneView.isHidden = true
            }
            else
            {
                stackEmailView.isHidden = false
            }
        }
        setTimer()
    }
    
    
    //MARK:- Set Timer
    
    func setTimer(){
        btnResendMobileOtp.isHidden = true
        labelShowMobileTimer.isHidden = false
        
        btnResendEmailOtp.isHidden = true
        labelShowEmailTimer.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func fireTimer() {
        
        runCount -= 1
        btnResendMobileOtp.isHidden = true
        
        labelShowMobileTimer.text = "\(LTYText.textResetVC_ShowTimer.localized()) 00:\(runCount)"
        labelShowEmailTimer.text = "\(LTYText.textResetVC_ShowTimer.localized()) 00:\(runCount)"
        if runCount == 0 {
            btnResendMobileOtp.isHidden = false
            labelShowMobileTimer.isHidden = true
            
            btnResendEmailOtp.isHidden = false
            labelShowEmailTimer.isHidden = true
            runCount = 30
            timer?.invalidate()
        }
    }
    
    //MARK:- SetUpFunc
    
    func setUpView() {
        
        lineView.viewCorner(5)
        mainView.viewCorner(15)
        btnCancel.viewCorner(8)
        btnVerifyPass.viewCorner(8)
        btnVerifyPass.alpha = 1

        labelTitle.font = FontSize.size20
        labelShowMobileNum.font = FontSize.size16
        labelShowMobileTimer.font = FontSize.size16
        labelShowEmailTimer.font = FontSize.size16

        btnResendMobileOtp.titleLabel?.font = FontSize.size16
        btnResendEmailOtp.titleLabel?.font = FontSize.size16
        btnVerifyPass.titleLabel?.font = FontSize.size16
        labelShowMobileTimer.text = LTYText.otpVerify_ShowTimer.localized()
        
        
        
        labelTitle.textColor = Asset.Colors.gray1.color
        labelShowEmail.textColor = Asset.Colors.gray1.color
        labelShowMobileNum.textColor = Asset.Colors.gray1.color
        labelTitle.text = LTYText.otpVerifyVC_Title.localized()
        //labelShowMobileNum.text = "\(LTYText.otpVerify_ShowEmail) 96969624956"
      
        labelShowMobileNum.text = "\(LTYText.otpVerify_ShowEmail.localized()) Mobile"//\(phoneNumber)"
        labelShowEmail.text = "\(LTYText.otpVerify_ShowEmail.localized()) \(verifiedEmail)"

        btnResendMobileOtp.setTitle(LTYText.otpVerifyVC_Resend.localized(), for: .normal)
        btnResendEmailOtp.setTitle(LTYText.otpVerifyVC_Resend.localized(), for: .normal)

        btnVerifyPass.setTitle(LTYText.otpVerifyVC_Verify.localized(), for: .normal)
        btnCancel.setTitle(LTYText.otpVerify_Cancel.localized(), for: .normal)

        
        btnCancel.backgroundColor = Asset.Colors.whiteColor.color
        btnVerifyPass.backgroundColor = Asset.Colors.lightBlue.color
        btnCancel.setTitleColor(Asset.Colors.lightBlue.color, for: .normal)
        btnVerifyPass.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)

        
    }

    //MARK:- Cancel ActionBtn
    
    @IBAction func cancelActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    //MARK:- Recover Password Btn Action
    @IBAction func verifyActionBtn(_ sender: UIButton) {
        
        
        self.setTimer()
        if comingFrom == "signUp"{
            
            if otpTextField.text?.count ?? 0 < 6 {
                self.ShowAlert(message: "Please Enter OTP".localized())
            }
            else if emailOtpTextField.text?.count ?? 0 < 6{
                
                self.ShowAlert(message: "Please Enter OTP".localized())
            }
            else {
                checkInternetConnection = 1
                
                checkNetwork(phoneOtp:otpTextField.text ?? "", emailOtp:emailOtpTextField.text ?? "" ,param: [:] )
            }
        } else if (comingFrom == "update_email") || (comingFrom == "update_phone") {
            
            if emailOtpTextField.text?.count ?? 0 < 6{
                
                self.ShowAlert(message: "Please Enter OTP".localized())
            }else {
                
                checkInternetConnection = 1
                
                checkNetwork(phoneOtp:emailOtpTextField.text ?? "", emailOtp:emailOtpTextField.text ?? "" ,param: [:] )
            }
            
            
        } else{
            
            checkInternetConnection = 1
            if otpTextField.text?.count ?? 0 < 6 {
                self.ShowAlert(message: "Please Enter OTP".localized())
            }else {
                
                
                checkNetwork(phoneOtp:otpTextField.text ?? "", emailOtp:"",param: [:] )
            }
        }
        
    }
    
    //MARK:- resend password btn
    
    @IBAction func resendPassActionBtn(_ sender: UIButton) {
        
        self.setTimer()
        otpTextField.text = ""
        emailOtpTextField.text = ""
        checkInternetConnection = 2
        let param : [String:Any] = ["otpId":otpId]
        checkNetwork(phoneOtp: "",emailOtp: "", param: param)
        
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (phoneOtp:String,emailOtp:String,param:[String:Any]) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            if checkInternetConnection == 1 {
                
                if comingFrom == "loginVC" {
                    
                    otpVerifyViewModel.networkServiceCall(param: OTPVerifyParams.init(email: verifiedEmail, action: "VERIFY_OTP", actionParams: ActionParams.init(otpID: otpId, otp: phoneOtp)))
                }
                else if (comingFrom == "update_email")
                {
                    let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
                    if partnerId != ""
                    {
                        otpVerifyViewModel.networkServiceCallForVerifyEmail(param: OTPVerifyEmailParams.init(partnerId: partnerId, newEmail: verifiedEmail, newEmailOtpDetails: NewEmailOtpDetails.init(otpId: otpId, otp: emailOtp)), isComming: comingFrom)
                    }
                }
                else if (comingFrom == "update_phone")
                {
                    if agentID != ""{
                        let updatePhone = kUserDefaults.value(forKey: "UpdatePhoneCode")
                        
                        otpVerifyViewModel.networkServiceCallForVerifyPhone(param: OTPVerifyPhoneParams.init(partnerId: agentID, newMobile: verifiedEmail, countryCode: updatePhone as! String, newMobileOtpDetails: .init(otpId: otpId, otp: emailOtp)), isComming: comingFrom)
                        
                    }else{
                        let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
                        
                        let updatePhone = kUserDefaults.value(forKey: "UpdatePhoneCode")
                        
                        otpVerifyViewModel.networkServiceCallForVerifyPhone(param: OTPVerifyPhoneParams.init(partnerId: partnerId, newMobile: verifiedEmail, countryCode: updatePhone as! String, newMobileOtpDetails: .init(otpId: otpId, otp: emailOtp)), isComming: comingFrom)
                        
                    }
//                    {
//                        otpVerifyViewModel.networkServiceCallForVerifyPhone(param: OTPVerifyPhoneParams.init(partnerId: partnerId, newMobile: verifiedEmail, countryCode: "+91", newMobileOtpDetails: .init(otpId: otpId, otp: emailOtp)), isComming: comingFrom)
//
//                    }
                }
                else {
                    otpVerifyViewModel.networkServiceCall(param: OTPVerifyParams.init(email: verifiedEmail, action: "VERIFY_OTP", actionParams: ActionParams.init(otpID: otpId, otp: phoneOtp),emailActionParams: EmailParams.init(otpID: emailOtpID, otp: emailOtp)))
                    
                }
            }
            else {
                
                otpVerifyViewModel.resendPasswordApi(param: param)

            }
        }
        else {
            
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert.localized())
        }
    }
    
    //MARK:- Change root
    
    func switchToTab() {
        
        let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        let email = kUserDefaults.value(forKey: AppKeys.email) as! String
        let name = kUserDefaults.value(forKey: AppKeys.agentName) as! String
        let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
        let password = kUserDefaults.value(forKey: AppKeys.password) as! String
        let profile = kUserDefaults.value(forKey: AppKeys.profile) as? String
        let fcmKey = kUserDefaults.value(forKey: AppKeys.fcmKey) as? String
        if fcmKey == nil {
            self.fcmKeyValue = "dummmy_App_fcm"
        }else{
            self.fcmKeyValue = fcmKey ?? ""
        }
        
        

            let userDict = [
                "email": email,
                "name" : name,
                "pic" :profile,
                "type" : userType,
                "fcmKey" : self.fcmKeyValue
            ]

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if userType == "AGENT" {
                
               // AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])
                AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])

                
            }else {
                
                AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])
            }
            
        }
        
        
        let vc = TabBarController.instantiate(fromAppStoryboard: .home)
    
       // vc.selectedIndex = selectedIndex ?? 0
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            LTY_AppDelegate.window?.rootViewController = vc
        }
    }
    
    //MARK: - Show alert with title and alert message and basic two actions
    
    func showSimpleAlert(title:String) {
        let alert = UIAlertController(title: "", message:title, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: LTY_AlterText.Ok.localized(),
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            
            let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
            let email = kUserDefaults.value(forKey: AppKeys.email) as! String
            let name = kUserDefaults.value(forKey: AppKeys.agentName) as! String
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            let password = kUserDefaults.value(forKey: AppKeys.password) as! String
            let profile = kUserDefaults.value(forKey: AppKeys.profile) as? String
            let fcmKey = kUserDefaults.value(forKey: AppKeys.fcmKey) as? String
            if fcmKey == nil {
                self.fcmKeyValue = "dummmy_App_fcm"
            }else{
                self.fcmKeyValue = fcmKey ?? ""
            }
            
            
  
                let userDict = [
                    "email": email,
                    "name" : name,
                    "pic" :profile,
                    "type" : userType,
                    "fcmKey" : self.fcmKeyValue
                ]

            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if userType == "AGENT" {
                    
                   // AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])
                    AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])

                    
                }else {
                    
                    AppKeys.refFbdb.child("Users").child("\(partnerId ?? "")").updateChildValues(userDict as [AnyHashable : Any])
                }
                
            }
            
            self.switchToTab()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}



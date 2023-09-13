//
//  ResetPassVC.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 09/05/23.
//

import UIKit
import SGCodeTextField

class ResetPassVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var otpTextField: SGCodeTextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSetPass: UIButton!
    @IBOutlet weak var labelNewPass: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelShowEmail: UILabel!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var textfield5: UITextField!
    @IBOutlet weak var textfield6: UITextField!
    @IBOutlet weak var labelConfirmPass: UILabel!
    @IBOutlet weak var eyeBtnNewPass: UIButton!
    @IBOutlet weak var labelDidNotGetCode: UILabel!
    @IBOutlet weak var eyeBtnConfirmBtn: UIButton!
    @IBOutlet weak var labelShowTimer: UILabel!
    @IBOutlet weak var btnResendOtp: UIButton!
    @IBOutlet weak var textNewPass: CustomTextField!
    @IBOutlet weak var textConfirmPass: CustomTextField!
    
    //MARK:- Variables
    var userEmail = ""
    var otpValue = ""
    var timer: Timer?
    var runCount = 30
    var CheckInternetConnection = 0
    var forgotPassData = [ForgotPassData]()
    var resetPassViewModel = ResetPassViewModel()
    
    /*
     if mpin.text?.count ?? 0 < 4 {
         showMessageAlert(message: "Please Enter OTP".localized())
     }else {
         EnterMPIN()
     }
     */
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        resetPassViewModel.delegate = self
    }
    
    //MARK:- Will appear func
    
    override func viewWillAppear(_ animated: Bool) {
        setTimer()
    }
    
    
    //MARK:- Set Timer
    
    func setTimer(){
        btnResendOtp.isHidden = true
        labelDidNotGetCode.isHidden = true
        labelShowTimer.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func fireTimer() {
        
        runCount -= 1
        btnResendOtp.isHidden = true
        labelDidNotGetCode.isHidden = true
        
        labelShowTimer.text = "\(LTYText.textResetVC_ShowTimer.localized()) 00:\(runCount)"
        
        if runCount == 0 {
            btnResendOtp.isHidden = false
            labelDidNotGetCode.isHidden = false
            labelShowTimer.isHidden = true
            runCount = 30
            timer?.invalidate()
        }
    }
    
    //MARK:- SetUpFunc
    
    func setUpView() {
        
        lineView.viewCorner(5)
        mainView.viewCorner(15)
        btnSetPass.viewCorner(8)
        btnSetPass.isEnabled = true
        btnSetPass.alpha = 1
        /*
        textfield1.delegate = self
        textfield2.delegate = self
        textfield3.delegate = self
        textfield4.delegate = self
        textfield5.delegate = self
        textfield6.delegate = self
        
        textfield1.viewCorner(8)
        textfield2.viewCorner(8)
        textfield3.viewCorner(8)
        textfield4.viewCorner(8)
        textfield5.viewCorner(8)
        textfield6.viewCorner(8)
        
        textfield1.viewBorder(color: Asset.Colors.skyBlue.color)
        textfield2.viewBorder(color: Asset.Colors.skyBlue.color)
        textfield3.viewBorder(color: Asset.Colors.skyBlue.color)
        textfield4.viewBorder(color: Asset.Colors.skyBlue.color)
        textfield5.viewBorder(color: Asset.Colors.skyBlue.color)
        textfield6.viewBorder(color: Asset.Colors.skyBlue.color)
        */
        labelTitle.font = FontSize.size20
        textNewPass.font = FontSize.size16
        labelNewPass.font =  FontSize.size16
        labelSubTitle.font = FontSize.size16
        textConfirmPass.font = FontSize.size16
        labelConfirmPass.font = FontSize.size16
        
        btnCancel.titleLabel?.font = FontSize.size16
        btnSetPass.titleLabel?.font = FontSize.size16
        
        labelTitle.textColor = Asset.Colors.gray1.color
        labelNewPass.textColor = Asset.Colors.gray1.color
        labelConfirmPass.textColor = Asset.Colors.gray1.color
        labelSubTitle.textColor = Asset.Colors.gray1.color
        labelShowTimer.textColor = Asset.Colors.gray1.color
        labelShowEmail.textColor = Asset.Colors.gray1.color
        labelDidNotGetCode.textColor = Asset.Colors.gray1.color
        textNewPass.textColor = Asset.Colors.darkGrayColor.color
        textConfirmPass.textColor = Asset.Colors.darkGrayColor.color
        textNewPass.backgroundColor = Asset.Colors.grayColor.color
        textConfirmPass.backgroundColor = Asset.Colors.grayColor.color
        
        labelTitle.text = LTYText.textResetVC_Title.localized()
        labelNewPass.text = LTYText.textResetVC_NewPass.localized()
        labelConfirmPass.text = LTYText.textResetVC_ConfirmPass.localized()
        labelShowEmail.text = "\(LTYText.textResetVC_ShowEmail.localized())  \(userEmail)"
        labelDidNotGetCode.text = LTYText.textResetVc_DontGetCode.localized()
        
        
        labelSubTitle.text = LTYText.textResetVC_SubTitle.localized()
        textNewPass.placeholder = LTYText.textResetVC_PlaceHolderNewPass.localized()
        textConfirmPass.placeholder = LTYText.textResetVC_PlaceHolderConfirmPass.localized()
        
     
        btnCancel.setTitle(LTYText.textResetVC_Cancel.localized(), for: .normal)
        btnSetPass.setTitle( LTYText.textResetVC_Recover.localized(), for: .normal)

        btnResendOtp.setTitle(LTYText.textResetVC_ResendBtn.localized(), for: .normal)
        btnSetPass.backgroundColor = Asset.Colors.lightBlue.color
        btnResendOtp.setTitleColor(Asset.Colors.lightBlue.color, for: .normal)
        btnSetPass.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        
        
    }
    
    //MARK:- to show hide pass
    @IBAction func hideShowPasswordBtnAction(_ sender: UIButton) {
        
        if sender.tag == 101 {
            sender.isSelected = !sender.isSelected
            textNewPass.isSecureTextEntry = !textNewPass.isSecureTextEntry
        }
        else {
            sender.isSelected = !sender.isSelected
            textConfirmPass.isSecureTextEntry = !textConfirmPass.isSecureTextEntry
        }
    }
    
    //MARK:- Set Password Btn Action
    
    @IBAction func btnSetPassAction(_ sender: UIButton) {
        checkValidation()
    }
    
    //MARK:- Cancel Btn Action
    @IBAction func btnCancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK:- Resend OTP Btn Action
    @IBAction func btnResendOTPAction(_ sender: UIButton) {
        /*
        textfield1.text = ""
        textfield2.text = ""
        textfield3.text = ""
        textfield4.text = ""
        textfield5.text = ""
        textfield6.text = ""
        */
        otpTextField.text = ""
        self.setTimer()
        CheckInternetConnection = 1
        let param : [String:Any] = ["otpId":String(forgotPassData.first?.otpID ?? "")]
        checkNetwork(otp: "", param: param)
        
    }
    
    //MARK:- Check Validation
    
    func checkValidation() {
        
       
        guard let password = textNewPass.text?.trim() , !password.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.messagePassword.localized(), title: LTY_AlterText.password.localized())
            
            return
        }
        
        guard let Confirmpass = textConfirmPass.text?.trim() , !Confirmpass.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.messageconfirmPass.localized(), title: LTY_AlterText.confirmPass.localized())
            
            return
        }
        
        if textNewPass.text == textConfirmPass.text {
     
            if otpTextField.text?.count ?? 0 < 6 {
                self.ShowAlert(message: "Please Enter OTP".localized())
            }else {
                checkNetwork(otp: otpTextField.text ?? "",param: [:])
            }
           
        }
        else {
            self.ShowAlert(message: LTY_AlterText.validPass.localized(), title: LTY_AlterText.passwordNotMatch.localized())
        }
        
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (otp:String, param:[String:Any]) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            if CheckInternetConnection == 1 {
                
                resetPassViewModel.resendPasswordApi(param: param)
                
            }
            
            else
            {
                resetPassViewModel.networkServiceCall(param: ResetPassParam.init(email: userEmail, password: textConfirmPass.text, forgotPasswordOtpDetails:ResetPassOtpDetails.init(otpID:forgotPassData.first?.otpID, otp:otp)))
            }
            
        }
        else {
            
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert.localized())
        }
    }
    
    //MARK: - Show alert with title and alert message and basic two actions
    
    func showSimpleAlert(title:String) {
        let alert = UIAlertController(title: "", message:title, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: LTY_AlterText.Ok.localized(),
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    
}


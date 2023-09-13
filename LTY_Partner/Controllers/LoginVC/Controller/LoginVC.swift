//
//  LoginVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/05/23.
//

import UIKit
import LocalAuthentication


class LoginVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var labelPass: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var labelRemeber: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelNoAccount: UILabel!
    @IBOutlet weak var btnEnablePass: UIButton!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var btnRegisterNow: UIButton!
    @IBOutlet weak var textEmail: CustomTextField!
    @IBOutlet weak var textPassword: CustomTextField!
    
    //MARK:- Variables
    var iconClick = true
    var loginModelClass = LoginViewModel()
    

    
    //MARK:- Did load func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loginModelClass.delegate = self
                
    }
    
    //MARK:- SetUp View
    
    func setUpView () {
        btnLogin.isUserInteractionEnabled = true
        btnLogin.viewCorner(8)
        labelPass.font = FontSize.size16
        labelTitle.font = FontSize.size28
        labelEmail.font = FontSize.size16
        //labelEmail.makeTextMandatory()
        textEmail.font =  FontSize.size16
        textPassword.font = FontSize.size16
        labelRemeber.font = FontSize.size16
        labelSubTitle.font = FontSize.size16
        labelNoAccount.font = FontSize.size16
        btnLogin.titleLabel?.font =  FontSize.size16
        btnForgotPass.titleLabel?.font =  FontSize.size16
        btnRegisterNow.titleLabel?.font = FontSize.size16
        
        labelPass.textColor = Asset.Colors.gray1.color
        //labelPass.makeTextMandatory()
        labelTitle.textColor = Asset.Colors.darkGrayColor.color
        labelEmail.textColor = Asset.Colors.gray1.color
        labelRemeber.textColor = Asset.Colors.darkGrayColor.color
        labelSubTitle.textColor = Asset.Colors.gray2.color
        labelNoAccount.textColor = Asset.Colors.darkGrayColor.color
        
        textEmail.textColor = Asset.Colors.darkGrayColor.color
        textPassword.textColor = Asset.Colors.darkGrayColor.color
        textEmail.backgroundColor = Asset.Colors.grayColor.color
        textPassword.backgroundColor = Asset.Colors.grayColor.color
        
        btnLogin.backgroundColor = Asset.Colors.lightBlue.color
        btnLogin.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        
        btnForgotPass.titleLabel?.textColor = Asset.Colors.darkGrayColor.color
        btnForgotPass.setTitleColor(Asset.Colors.darkGrayColor.color, for: .normal)
        
        btnRegisterNow.backgroundColor = Asset.Colors.whiteColor.color
        btnRegisterNow.setTitleColor(Asset.Colors.lightBlue.color, for: .normal)
        
        labelPass.text = LTYText.textLoginVCPass.localized()
        labelEmail.text = LTYText.textLoginVCEmail.localized()
        labelTitle.text = LTYText.textLoginVCTitle.localized()
        labelRemeber.text = LTYText.textLoginVCRemember.localized()
        labelSubTitle.text = LTYText.textLoginVCSubTitle.localized()
        labelNoAccount.text = LTYText.textLoginVCNoAccount.localized()
        
       // textEmail.placeholder = LTYText.textLoginVCEmailPlaceHolder
      //  textPassword.placeholder = LTYText.textLoginVCPassPlaceHolder
        btnLogin.setTitle(LTYText.textLoginVCLogin.localized(), for: .normal)
        btnRegisterNow.setTitle(LTYText.textLoginVCRegister.localized(), for: .normal)
        btnForgotPass.setTitle(LTYText.textLoginVCForgotPass.localized(), for: .normal)
 
        
    }
    
 
    //MARK:- forgot password Btn Action
    
    @IBAction func btnForgotPassAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    //MARK:- password secure
    
    @IBAction func btnEnablePassAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        textPassword.isSecureTextEntry = !textPassword.isSecureTextEntry
    }
    //MARK:- Register Now Btn Action
    
    @IBAction func btnRegisterNowAction(_ sender: UIButton) {
        let vc = SignUpVC.instantiate(fromAppStoryboard: .main)
        //self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.modalPresentationStyle = .overCurrentContext
        pushToVC(vc, animated: true)
    }
    
    //MARK:- Login Action Btn
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        checkValidation()

    }
    
    
    
    //MARK:- check Email and Password text validation
    
    func checkValidation() {
        
        guard let email = textEmail.text?.trim() , !email.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.messageEmail.localized(), title: LTY_AlterText.email.localized())
            
            return
        }
        
        guard  email.isValidEmail() else {
            
            self.ShowAlert(message:LTY_AlterText.messageEmailVarification, title: LTY_AlterText.emailVarification.localized())
            
            return
        }
        
        
        guard let password = textPassword.text ,!password.isEmpty else {
            
            self.ShowAlert(message:LTY_AlterText.messagePassword, title: LTY_AlterText.password.localized())
            return
        }
        kUserDefaults.set(email, forKey: AppKeys.email)
        kUserDefaults.set(password, forKey: AppKeys.password)
        
       checkNetwork(params:LoginParams.init(email: email, password: password))
        //checkNetwork(params:LoginParams.init(email: "shashi123@yopmail.com", password: "Pass@123"))

    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:LoginParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            loginModelClass.networkServiceCall(param:params)
            btnLogin.isUserInteractionEnabled = false
        }
        else {
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert.localized())
        }
    }
    
    
}

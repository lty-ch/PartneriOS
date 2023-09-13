//
//  ForgotPassVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/05/23.
//

import UIKit

//MARK:- this is used to save data after forgaot pass api

struct ForgotPassValue {
    let otpID : String?
    let userEmail : String?
    let duration : String?
    let remainingAttempts : Int?
    let resendOtpTime : Int?

}
protocol DismissScreen{
    func dismissScreen(setValue:Bool,data:ForgotPassValue)
}

class ForgotPassVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var textEmail: CustomTextField!
    @IBOutlet weak var btnRecoverPass: UIButton!
    
    //MARK:- Variables
    
    var forgotPassViewModel = ForgotVCViewModel()
    var delegate : DismissScreen?
    //MARK:- Did load func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        forgotPassViewModel.delegate = self
        
        //view.isOpaque = false
    }
    
    //MARK:- SetUpFunc
    
    func setUpView() {
        
        lineView.viewCorner(5)
        mainView.viewCorner(15)
        btnRecoverPass.viewCorner(8)
        
        labelTitle.font = FontSize.size20
        labelEmail.font =  FontSize.size16
        textEmail.font =  FontSize.size16
        labelSubTitle.font =  FontSize.size16
        btnCancel.titleLabel?.font = FontSize.size16
        btnRecoverPass.titleLabel?.font =  FontSize.size16
        
        textEmail.backgroundColor = Asset.Colors.grayColor.color
        
        labelTitle.textColor = Asset.Colors.gray1.color
        //        labelEmail.textColor = Asset.Colors.darkGrayColor.color
        labelEmail.textColor = Asset.Colors.gray1.color
        
        labelSubTitle.textColor = Asset.Colors.gray1.color
        textEmail.textColor = Asset.Colors.darkGrayColor.color
        
        labelTitle.text = LTYText.textForgotVC_Title.localized()
        labelEmail.text = LTYText.textForgotVC_Email.localized()
        labelSubTitle.text = LTYText.textForgotVC_SubTitle.localized()
        btnCancel.titleLabel?.text = LTYText.textForgotVC_Cancel.localized()
        textEmail.placeholder = LTYText.textForgotVC_PlaceHolderEmail.localized()
      
        
        btnRecoverPass.backgroundColor = Asset.Colors.lightBlue.color
        btnRecoverPass.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnCancel.setTitle(LTYText.textForgotVC_Cancel.localized(), for: .normal)
        btnRecoverPass.setTitle(LTYText.textForgotVC_Recover.localized().localized(), for: .normal)

        
    }
    
    //MARK:- Recover Password Btn Action
    
    @IBAction func btnRecoverPassAction(_ sender: UIButton) {
        
        checkValidation()
    }
    
    //MARK:- check Email and Password text validation
    
    func checkValidation() {
        
        guard let email = textEmail.text?.trim() , !email.isEmpty else {
            
            self.ShowAlert(message: LTY_AlterText.messageEmail.localized(), title: LTY_AlterText.email.localized())
            
            return
        }
        
        guard  email.isValidEmail() else {
            
            self.ShowAlert(message:LTY_AlterText.messageEmailVarification.localized(), title: LTY_AlterText.emailVarification.localized())
            
            return
        }
        
        
        checkNetwork(params:ForgotParams.init(email: email))
    }
    
    //MARK:-  check internet Connection
    
    func checkNetwork (params:ForgotParams) {
        
        if internetConnection.isConnectedToNetwork() == true {
            
            forgotPassViewModel.networkServiceCall(param: params)
            
        }
        else {
            
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert.localized())
        }
    }
    
    
    
    //MARK:- Cancel Btn Action
    @IBAction func btnCancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

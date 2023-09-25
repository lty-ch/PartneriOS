//
//  ChangePasswordVC.swift
//  LTY_Partner
//
//  Created by CTS on 14/07/23.
//

import UIKit

class ChangePasswordVC: UIViewController, ProfileProtocolDelegate {
    func setProfile(data: ProfileModel) {
        print("")
    }
    
    func updateProfile(data: ProfileModel) {
        print("")
    }
    
    func changePass(data: ChangePassModel) {
        if data.data?.isPasswordChanged == true {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
                kUserDefaults.setValue(false, forKey: AppKeys.isDefaultPasswordSet)

            }
        }
        else{
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
    }
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.showOkAlert(msg)
        }
    }
    

    @IBOutlet weak var newPasswordTxt: CustomTextField!
    @IBOutlet weak var oldPasswordTxt: CustomTextField!
    
    var profileModelClass = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileModelClass.delegate = self
    }
    
    @IBAction func onClickChangePassword(_ sender: UIButton) {
        guard let oldPassword = oldPasswordTxt.text, !oldPassword.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageOldPassword, title: LTY_AlterText.oldPassword)
            return
        }
        guard let newPassword = newPasswordTxt.text, !newPassword.isEmpty else {
            self.ShowAlert(message: LTY_AlterText.messageNewPassword, title: LTY_AlterText.newPassword)
            return
        }
        
        guard newPassword.isPasswordValidation(password: newPasswordTxt.text!) else
        {
            self.ShowAlert(message: LTY_AlterText.messagePassValidation, title: LTY_AlterText.newPassword)
            return
        }
        
        let partnerId = kUserDefaults.value(forKey: "partnerID")
        
        let param:[String:Any] = ["partnerId":partnerId ?? "","oldPassword":self.oldPasswordTxt.text!,"newPassword":self.newPasswordTxt.text!]
        checkNetwork(params: param)
    }
    
    @IBAction func onClickNotNow(_ sender: UIButton) {
        self.dismiss(animated: true)
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

}

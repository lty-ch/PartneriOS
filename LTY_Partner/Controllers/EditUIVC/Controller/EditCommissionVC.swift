//
//  EditCommissionVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 26/05/23.
//

import UIKit

protocol ProductCommissionProtocolDelegate : AnyObject {
    func setProductCommissiondata()
    func popupMsg(msg : String)
}

class EditCommissionVC: UIViewController {
    

    @IBOutlet weak var commissionTxt: UITextField!
    @IBOutlet weak var productNameTxt: UITextField!
    
    var productObj : ProductListt?
    var delegate: ProductCommissionProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            self.productNameTxt.text = self.productObj?.productNameInFrench ?? ""
            let commission = self.productObj?.commission ?? 0
            self.commissionTxt.text = "\(commission)"
            
        }else{
            self.productNameTxt.text = self.productObj?.productName ?? ""
            let commission = self.productObj?.commission ?? 0
            self.commissionTxt.text = "\(commission)"
        }
    }
    
    
    
    @IBAction func onClickUpdate(_ sender: UIButton) {
        let  textCommission = Int(commissionTxt.text ?? "")
        if commissionTxt.text != "" {
            
            if textCommission ?? 0 > 100 {
                self.ShowAlert(message: "commission should not be greater than 100".localized())
                return
            }else{
           
                    let param:[String:Any] = ["id": self.productObj?.id ?? "", "commission": self.commissionTxt.text!]
                    self.updateCommissionApi(param: param)
             
            }
            
        }else{
            self.ShowAlert(message: "Please enter commission".localized())
        }
       
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    func updateCommissionApi (param:[String:Any]) {
        
        Services.shareInstance.putRequestApi(url: LTY_BASE_URL.BASE_URL_FEE + LTY_END_POINT_URL.updateProductCommission, method: "put", isPassToken: true, expecting:SuccessModel.self, dataDict: param) { response
            in
            switch response {
            case .success(let result):
                
//                self.delegatee?.setBlockCustomerdata(data: result)
                if result.status == "SUCCESS" {
                    DispatchQueue.main.async {
                        self.showOkAlertWithHandler("Commission updated successfully.".localized()) {
                                self.delegate?.setProductCommissiondata()

                            self.dismiss(animated: true)
                        }
                    }
                    
                    
                }

                
            case .failure(let error):
                self.delegate?.popupMsg(msg:error.localizedDescription)

            }
        
        }
    }
  

}

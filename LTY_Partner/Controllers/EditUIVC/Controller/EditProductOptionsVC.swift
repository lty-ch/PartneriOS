//
//  EditProductVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 24/05/23.
//

import UIKit

protocol DeleteProductProtocolDelegate : AnyObject {
    func deleteProductProtocolWithIndex(data : Int, subCatID: String)}

protocol CommissionEditTappedProtocolDelegate : AnyObject {
    func productActionsTappedIndex(editActionTappedIndex : Int, listIndex : Int)
}

class EditProductOptionsVC: UIViewController, EditProductOptionsProtocolDelegate {
    
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet var mainview: UIView!
    var editProductVM = EditProductOptionsViewModel()
    var productIdArr = [String]()
    var productId = ""
    var type = ""
    var subCatID = ""
    
    func popupMsg(msg: String) {
        print("")
    }
    
    
    weak var delegate:DeleteProductProtocolDelegate?
    weak var commissionDelegate:CommissionEditTappedProtocolDelegate?
    var index = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editProductVM.delegate = self
        self.productIdArr.append(self.productId)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainview.addGestureRecognizer(tap)
        mainview.isUserInteractionEnabled = true
        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }

    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete, 104 - edit
        
        if sender.tag == 104 {
            self.dismiss(animated: true) {
                self.commissionDelegate?.productActionsTappedIndex(editActionTappedIndex: 104, listIndex: self.index)
            }
        }
        
        if sender.tag == 103 {
            self.optionsView.isHidden = true
            self.deleteView.isHidden = false
            
            
        }
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        //101 - n0, 102 - yes
        if sender.tag == 102 {
            let param : [String : Any] = ["entityIds": self.productIdArr, "entityType" : "PRODUCT_ID"]
            editProductVM.deleteCatProducts(param: param)
            
        } else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
    
    func deleteProductProtocol(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            self.showOkAlertWithHandler("Product deleted Successfully.".localized()) {
                DispatchQueue.main.async {
                    self.delegate?.deleteProductProtocolWithIndex(data: self.index, subCatID: self.subCatID)

                }
                self.dismiss(animated: true)
            }
            
        }
    }

}

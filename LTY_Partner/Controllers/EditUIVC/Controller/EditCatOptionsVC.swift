//
//  EditCatOptionsVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 24/05/23.
//

import UIKit

//protocol DeleteCatProtocolDelegate : AnyObject {
//    func deleteMainCatProtocol(data : Int)
//}

protocol DeleteCatProtocolDelegate : AnyObject {
    func deleteProductProtocolWithIndex(data : Int, subCatID: String)}

class EditCatOptionsVC: UIViewController, EditCatOptionsProtocolDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var deleteView: UIView!
    
    var editCatVM = EditCatOptionsViewModel()
    var catIdArr = [String]()
    var subCatId = ""
    var catId = ""
    weak var delegate : DeleteCatProtocolDelegate?
    var index = 0
    var type = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editCatVM.delegate = self
        self.catIdArr.append(self.subCatId)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }

    @IBAction func deleteActions(_ sender: UIButton) {
        //101 - n0, 102 - yes
        if sender.tag == 102 {
            
            if type == "cat" {

                let param : [String : Any] = ["entityIds": self.catIdArr, "entityType": "CATEGORY_ID"]
                editCatVM.deleteMainCat(param, url: LTY_END_POINT_URL.deleteProductCommission)
            } else {
                let param : [String : Any] = ["entityIds": self.catIdArr, "entityType": "SUB_CATEGORY_ID"]
                editCatVM.deleteMainCat(param, url: LTY_END_POINT_URL.deleteProductCommission)
            }
            
        } else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
    
    

    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete
        if sender.tag == 103 {
            self.optionsView.isHidden = true
            self.deleteView.isHidden = false
            
            
        }
    }
    
    func deleteMainCatProtocol(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            self.showOkAlertWithHandler("Category deleted Successfully.".localized()) {
                DispatchQueue.main.async {
                    self.delegate?.deleteProductProtocolWithIndex(data: self.index, subCatID: self.catId)

                }
                self.dismiss(animated: true)
            }
            
        }
    }
    
    func popupMsg(msg: String) {
        print(msg)
    }
        

}

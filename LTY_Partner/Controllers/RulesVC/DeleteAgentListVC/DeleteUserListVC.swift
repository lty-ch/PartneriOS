//
//  DeleteUserListVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import UIKit

protocol DeleteUserRoleProtocolDelegate{
    func passData(sendValue:String, index : Int)
}
class DeleteUserListVC: UIViewController {
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var confirmationLbl: UILabel!
    
    var delegateUserRole:DeleteUserRoleProtocolDelegate?
    var deleteMsg = "Do you want to delete this User ?".localized()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        self.deleteView.isHidden = false
        self.optionsView.isHidden = true
        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete, 104 - edit
        
        if sender.tag == 101 {
            self.dismiss(animated: true,completion: {
                self.delegateUserRole?.passData(sendValue: "Edit", index: self.index)
            })
            
        } else if sender.tag == 102 {
            
            self.dismiss(animated: true,completion: {
                
                self.delegateUserRole?.passData(sendValue: "View", index: self.index)
            })
        }
        
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        
        if sender.tag == 102 {
            
            self.dismiss(animated: true,completion: {
                
                self.delegateUserRole?.passData(sendValue: "Delete", index: self.index)
                
            })
        }
        
        else {
            self.dismiss(animated: true)
        }
    }
    
}

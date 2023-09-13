//
//  EditProposalVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/06/23.
//

import UIKit

protocol EditProposalProtocolDelegate{
    func passData(sendValue:String, index : Int)
}
class EditProposalVC: UIViewController {
    
    
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblModify: UILabel!
    @IBOutlet weak var modifyView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var confirmationLbl: UILabel!
    
    var delegateEditProposal:EditProposalProtocolDelegate?
    var deleteMsg = "Do you want to delete this User ?".localized()
    var index = 0
    var allowModification = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        self.deleteView.isHidden = true
        if allowModification {
            self.modifyView.isHidden = false
        } else {
            self.modifyView.isHidden = true
        }
        lblView.text = "View".localized()
        lblModify.text = "Modify".localized()
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete, 104 - edit
        
        if sender.tag == 101 {
            self.dismiss(animated: true,completion: {
                self.delegateEditProposal?.passData(sendValue: "Edit", index: self.index)
            })
            
        } else if sender.tag == 102 {
     
            self.dismiss(animated: true,completion: {
                
                self.delegateEditProposal?.passData(sendValue: "View", index: self.index)
            })
        }
        
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        
        if sender.tag == 102 {
            
            self.dismiss(animated: true,completion: {
                
                self.delegateEditProposal?.passData(sendValue: "Delete", index: self.index)
                
            })
        }
        
        else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
    
}

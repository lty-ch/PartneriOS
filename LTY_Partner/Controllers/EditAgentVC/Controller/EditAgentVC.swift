//
//  EditAgentVC.swift
//  LTY_Partner
//
//  Created by CTS on 30/05/23.
//

import UIKit

protocol SendEditAgentData {
    
    func sendEditData(sendValue:String ,checkBlockStatus:String)
}

class EditAgentVC: UIViewController {
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var labelBlock: UILabel!
    @IBOutlet weak var confirmationLbl: UILabel!

    var blockConfirmationMsg = ""
    var delegateSendEditAgent:SendEditAgentData?
    var confirmationMsg = "Do you want to block this user ?".localized()
    var confirmationUnblockMsg = "Do you want to Unblock this user ?".localized()
    var deleteMsg = "Do you want to delete this User ?".localized()

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        self.deleteView.isHidden = true
        
        if blockConfirmationMsg == "BLOCKED" {
            labelBlock.text = "Unblock"
        }
        else{
            labelBlock.text = "Block"

        }

        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    

    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete, 104 - edit
        
        if sender.tag == 101 {
            self.dismiss(animated: true,completion: {
                self.delegateSendEditAgent?.sendEditData(sendValue: "Profile",checkBlockStatus: "")
            })

        } else if sender.tag == 102 {
            self.dismiss(animated: true,completion: {
                self.delegateSendEditAgent?.sendEditData(sendValue: "Edit",checkBlockStatus: "")
            })
            
        } else if sender.tag == 103 {
                self.optionsView.isHidden = true
                self.deleteView.isHidden = false
            confirmationLbl.text = deleteMsg

            
        } else if sender.tag == 104 {
            self.dismiss(animated: true,completion: {
                self.delegateSendEditAgent?.sendEditData(sendValue: "Commisssion",checkBlockStatus: "")
            })
            
        }
        else if sender.tag == 105 {
            
            self.optionsView.isHidden = true
            self.deleteView.isHidden = false
            
            if blockConfirmationMsg == "BLOCKED" {
                confirmationLbl.text = confirmationUnblockMsg
            }
            else{
                confirmationLbl.text = confirmationMsg

            }
           
       }
        
        else if sender.tag == 106 {
           self.dismiss(animated: true,completion: {
               self.delegateSendEditAgent?.sendEditData(sendValue: "UnBlock",checkBlockStatus: "")
           })
           
       }
 
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        //101 - n0, 102 - yes
        if sender.tag == 102 {
            
            if confirmationLbl.text == deleteMsg  {
                self.dismiss(animated: true,completion: {
                    
                    self.delegateSendEditAgent?.sendEditData(sendValue: "Delete",checkBlockStatus: "")
                })
            }
            else {
                self.dismiss(animated: true,completion: {
                    self.delegateSendEditAgent?.sendEditData(sendValue: "Block",checkBlockStatus:self.blockConfirmationMsg)
                })

            }
            
        }
        
        else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
 
    
}


//
//  LeadProposalOptionVC.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 13/06/23.
//

import UIKit

class LeadProposalOptionVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var confirmationLbl: UILabel!
    
    var index = 0
    var deleteMsg = "Do you want to delete this User ?".localized()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        self.deleteView.isHidden = true
        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func editActions(_ sender: UIButton) {
        // 101 - excel, 102 - csv, 103 - delete, 104 - edit
        
        if sender.tag == 101 {
            self.dismiss(animated: true,completion: {
               // self.checkInsuranceDelegate?.checkInsuranceType(index: self.index, insuranceType: self.insuranceType)
            })
            
        } else if sender.tag == 102 {
            
            self.dismiss(animated: true,completion: {
                
              //  self.checkProposalDelegate?.checkInsuranceType(index: self.index, insuranceType: "Proposal")
            })
        }else if sender.tag == 103 {
            
            self.dismiss(animated: true,completion: {
                
//                self.checkProposalDelegate?.checkInsuranceType(index: self.index, insuranceType: "Proposal")
            })
        }
        
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        
        if sender.tag == 103 {
            
            self.dismiss(animated: true,completion: {
                
            })
        }
        
        else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
    
}

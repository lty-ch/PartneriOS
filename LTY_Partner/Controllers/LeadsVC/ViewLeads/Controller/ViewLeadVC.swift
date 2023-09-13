//
//  ViewLeadVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 09/06/23.
//

import UIKit

protocol checkInsuranceTypeDelegate{
    func checkInsuranceType(index:Int,insuranceType:String)
}

protocol checkProposalDelegate{
    func checkInsuranceType(index:Int,insuranceType:String)
}

class ViewLeadVC: UIViewController {
    
    @IBOutlet weak var lblAssignAgent: UILabel!
    @IBOutlet weak var lblViewLead: UILabel!
    @IBOutlet weak var lblViewProposal: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var confirmationLbl: UILabel!
    
    var index = 0
    var insuranceType = ""
    var checkInsuranceDelegate : checkInsuranceTypeDelegate?
    var checkProposalDelegate : checkProposalDelegate?
    var deleteMsg = "Do you want to delete this User ?".localized()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblViewLead.text = "View Lead".localized()
        lblAssignAgent.text = "Assign Agent".localized()
        lblViewProposal.text = "View Proposal".localized()
        
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
                self.checkInsuranceDelegate?.checkInsuranceType(index: self.index, insuranceType: self.insuranceType)
            })
            
        } else if sender.tag == 102 {
            
            self.dismiss(animated: true,completion: {
                
                self.checkProposalDelegate?.checkInsuranceType(index: self.index, insuranceType: "Proposal")
            })
        }else {
            
            self.dismiss(animated: true,completion: {
                
                self.checkProposalDelegate?.checkInsuranceType(index: self.index, insuranceType: "SelectAgent")
            })
        }
        
    }
    
    
    @IBAction func deleteActions(_ sender: UIButton) {
        
        if sender.tag == 102 {
            
            self.dismiss(animated: true,completion: {
                
            })
        }
        
        else {
            self.optionsView.isHidden = false
            self.deleteView.isHidden = true
        }
    }
    
}

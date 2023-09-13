//
//  ProposalAddSuccessVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 07/06/23.
//

import UIKit

protocol SuccessProtocol : AnyObject {
    func updateSuccess()
}


class ProposalAddSuccessVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var confirmationLbl: UILabel!
    @IBOutlet weak var doneBtnView: UIView!
    
    @IBOutlet weak var addProposalView: UIStackView!
    var addProposal = "Proposal added successfully".localized()
    var sentProposal = "Proposal sent successfully".localized()
    var delegate : SuccessProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addProposalView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
        confirmationLbl.text = sentProposal
        self.doneBtnView.isHidden = false
        
    }
    
    //MARK:- Dismiss PopUP
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func okActionBtn(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.updateSuccess()
        }
    }
    
    @IBAction func editActions(_ sender: UIButton) {
        
        if sender.tag == 101 {
            self.dismiss(animated: true,completion: {
                
                self.confirmationLbl.text = self.sentProposal
                self.addProposalView.isHidden = true
                self.doneBtnView.isHidden = false
             
                
               // self.delegateEditProposal?.passData(sendValue: "Edit")
            })
            
        } else if sender.tag == 102 {
     
            self.dismiss(animated: true,completion: {
                
              //  self.delegateEditProposal?.passData(sendValue: "View")
            })
        }
        
    }
    

}

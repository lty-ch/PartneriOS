//
//  FourthViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/05/23.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var nextBtnStackView: UIStackView!
    @IBOutlet weak var doneStackView: UIStackView!
    @IBOutlet weak var benefitsTextView: UITextView!
    
    var isComingFrom = ""
    var placeholderLabel : UILabel!
    var delegate : updateProposalData?
    var updateDelegate : updateProposalEditDataFromMainListing?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocalizationText()
    }
    
    func setLocalizationText() {
        self.btnDone.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.setTitle("Next".localized(), for: .normal)
        
        self.lblTitle.text = "Product Benefits".localized()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isComingFrom == "EditVC" || isComingFrom == "ProposalVC" || isComingFrom == "LeadProposalVC" || isComingFrom == "ForEditProposal" || isComingFrom == "ContractVC" {
            setData()
            doneStackView.isHidden = false
            nextBtnStackView.isHidden = true
        }else {
            doneStackView.isHidden = true
            nextBtnStackView.isHidden = false
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    func setData() {
     let productBenefits =  addProposalDic["productBenefits"] as? String
        
        self.benefitsTextView.text = productBenefits?.html2String
     }
    
    //MARK: set label using placeholder inside textview
    
    func setUpTextViewPlaceHolder () {
        
        // for set placeholder inside textview
        placeholderLabel = UILabel()
        placeholderLabel.text = "Please enter Product benefits".localized()
        placeholderLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight(rawValue: 0.2))
        
        placeholderLabel.sizeToFit()
        placeholderLabel.numberOfLines = 1
        benefitsTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (benefitsTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !benefitsTextView.text.isEmpty
    }

    @IBAction func onClickNext(_ sender: Any) {
        
        if benefitsTextView.text!.isEmpty {
            self.ShowAlert(message: "Please enter Product benefits.".localized())
            return
        }
        
        addProposalDic.setValue(self.benefitsTextView.text!, forKey: "productBenefits")
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "FifthViewController") as! FifthViewController
        self.navigationController?.pushViewController(next , animated: true)

    }
    
    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        
        if benefitsTextView.text!.isEmpty {
            self.ShowAlert(message: "Please enter Product benefits.".localized())
            return
        }
        
        addProposalDic.setValue(self.benefitsTextView.text!, forKey: "productBenefits")
        
        navigationController?.popViewControllerWithHandler(animated: true, completion: {
            if self.isComingFrom == "EditVC" {
                self.delegate?.updateData()
            } else {
                self.updateDelegate?.updateEditedDataFromMainListing()
            }
        })
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)
    }
    
  

}


extension FourthViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
         placeholderLabel?.isHidden = !textView.text.isEmpty
     }
     func textViewDidEndEditing(_ textView: UITextView) {
         placeholderLabel?.isHidden = !textView.text.isEmpty
     }
     func textViewDidBeginEditing(_ textView: UITextView) {
         placeholderLabel?.isHidden = true
     }
}


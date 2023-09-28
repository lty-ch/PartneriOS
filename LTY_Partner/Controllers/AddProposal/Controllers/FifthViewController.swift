//
//  FifthViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/05/23.
//

import UIKit

class FifthViewController: UIViewController {
    
    @IBOutlet weak var lblProductData: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var nextbtnStackView: UIStackView!
    @IBOutlet weak var doneStackView: UIStackView!
    @IBOutlet weak var featuresTextView: UITextView!
    
    var isComingFrom = ""
    var delegate : updateProposalData?
    var updateDelegate : updateProposalEditDataFromMainListing?
    var placeholderLabel : UILabel!
    
    var productsToSendInAPIArr = NSMutableArray()
    var selectedProductsArr = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLocalizationText()

        
    }
    
    func setLocalizationText() {
        self.btnDone.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.setTitle("Next".localized(), for: .normal)
        
        self.lblTitle.text = "Key Features".localized()
   
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isComingFrom == "EditVC" || isComingFrom == "ProposalVC" || isComingFrom == "LeadProposalVC" || isComingFrom == "ForEditProposal" || isComingFrom == "ContractVC" {
            setData()
           // SetProductNameData()
            doneStackView.isHidden = false
            nextbtnStackView.isHidden = true
        }else {
            doneStackView.isHidden = true
            nextbtnStackView.isHidden = false
            SetProductNameData()
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func SetProductNameData(){
        
        let productDetails = addProposalDic["productDetails"] as! NSMutableDictionary
        let prodList = productDetails["productList"] as! NSMutableArray
        self.selectedProductsArr = prodList
        self.productsToSendInAPIArr = prodList
        var arr = NSMutableArray()
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        let catDetails = addProposalDic["categoryDetails"] as! NSMutableDictionary
        //arr.add("\("Insurance Product".localized()) \("-") \(String(describing: catDetails["subCategoryName"] ?? "" ))\n")
        arr.add(" \(String(describing: catDetails["subCategoryName"] ?? "" ))\n")
        
        for items in prodList {
            let item = items as! NSMutableDictionary
            
            if result[0] as! String == "fr" {
                arr.add("\(item["productNameInFrench"] ?? "") - \(item["amount"] ?? 0)\n")
            }else{
              //  arr.add(item["productName"] ?? "")
                arr.add("\(item["productName"] ?? "") - \(item["amount"] ?? 0)\n")
            }
          
        }
        
//        let catDetails = addProposalDic["categoryDetails"] as! NSMutableDictionary
//        catLcbl.text = catDetails["categoryName"] as? String
        //subcatLcbl.text = catDetails["subCategoryName"] as? String
    
       // self.lblProductData.text = arr.componentsJoined(by: ",")
        self.featuresTextView.text = arr.componentsJoined(by: ",")
    }
    
    
    func setData() {
        let keyFeatures = addProposalDic["keyFeatures"] as? String
        //if
        let newString = keyFeatures?.replacingOccurrences(of: ",", with: "\("\n")")
        
        self.featuresTextView.text = newString?.html2String//keyFeatures?.html2String
     }
    

    //MARK: set label using placeholder inside textview
    
    func setUpTextViewPlaceHolder () {
        
        // for set placeholder inside textview
        placeholderLabel = UILabel()
        placeholderLabel.text = "Please enter Product features".localized()
        placeholderLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight(rawValue: 0.2))
        
        placeholderLabel.sizeToFit()
        placeholderLabel.numberOfLines = 1
        featuresTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (featuresTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !featuresTextView.text.isEmpty
    }

    @IBAction func onClickNext(_ sender: Any) {
        
        if featuresTextView.text!.isEmpty {
            self.ShowAlert(message: "Please enter Product features.".localized())
            return
        }
        
        addProposalDic.setValue(self.featuresTextView.text!, forKey: "keyFeatures")
        addProposalDic.setValue("SEND", forKey: "proposalAction")
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        self.navigationController?.pushViewController(next , animated: true)

    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        
        if featuresTextView.text!.isEmpty {
            self.ShowAlert(message: "Please enter Product features.".localized())
            return
        }
        
        addProposalDic.setValue(self.featuresTextView.text!, forKey: "keyFeatures")
        addProposalDic.setValue("SEND", forKey: "proposalAction")
        
        navigationController?.popViewControllerWithHandler(animated: true, completion: {
            if self.isComingFrom == "EditVC" {
                self.delegate?.updateData()
            } else {
                self.updateDelegate?.updateEditedDataFromMainListing()
            }
            
        })
        
    }
    
}

extension FifthViewController : UITextViewDelegate , UITextFieldDelegate{
    
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

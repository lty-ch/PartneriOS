//
//  SecondViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 30/05/23.
//
import UIKit
import DropDown

protocol updateProposalData{
    func updateData()
}

protocol updateProposalEditDataFromMainListing{
    func updateEditedDataFromMainListing()
}

struct AddPolicyModel :Codable{
    let status: String?
    let data: AddPolicyData?
    let error: SignUpError?
}

struct AddPolicyData:Codable{
    let isValid: Bool?
}

class SecondViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var CollectionViewLayout: UICollectionViewFlowLayout!{
        didSet {
            CollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPolicyType: UILabel!
    @IBOutlet weak var nextBtnStackView: UIStackView!
    @IBOutlet weak var doneStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typeOfInsuranceLbl: UILabel!
    @IBOutlet weak var offerNumberLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var keyTagLbl: UILabel!
    @IBOutlet weak var typeOfInsuranceTxt: UITextField!
    @IBOutlet weak var offerNumberTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var keyTagTxt: UITextField!
    @IBOutlet weak var btnSelectPolicy: UIButton!
    @IBOutlet weak var textPolicyType: UITextField!
    
    @IBOutlet weak var insuranceBtn: UIButton!
    let typeOfInsurancedDropDown = DropDown()
//    var dropDownElememnt  = [["Health".localized(), "HEALTH"],["Term Life".localized(), "TERM_LIFE"],["General".localized(), "GENERAL"],["Travel".localized(), "TRAVEL"],["Building".localized(), "BUILDING"],["RC - Household ".localized(), "RC_HOUSEHOLD"],["Car".localized(), "CAR"],["Family".localized(), "FAMILY"],["Child ".localized(), "CHILD"], ["Legal Protection".localized(), "LEGAL_PROTECTION"],["BVG Contract".localized(), "BVG_CONTRACT"],["LAA & AA".localized(), "LAA_AND_AA"] , ["Loss Of Earniing".localized(), "LOSS_OF_EARNING"],[" 3rd Pillar".localized(), "THIRD_PILLAR"]]
    var dropDownElememnt = [String]()
    var staticVM = StaticDataViewModel()
    var datePicker = UIDatePicker()
    var isComingFrom = ""
    var keyTagArray  = [String]()
    var insurnceType = ""
    var startDate = ""
    var endDate = ""
    var delegate : updateProposalData?
    var updateDelegate : updateProposalEditDataFromMainListing?
    var insuranceTypeArr  = ["Modification of the offer".localized(),"New contract signed".localized(),"Change in coverage".localized(),"Company modification".localized(),"Existing policy".localized()]
    var shouldAddLead = false
    var leadId = ""
    var agentName = ""
    var agentId = ""
    
    func setLocalizationText() {
        self.btnDone.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.setTitle("Next".localized(), for: .normal)
        
        self.lblTitle.text = "Proposal Basic Info".localized()
        self.lblPolicyType.text = "Policy Type".localized()
        self.typeOfInsuranceLbl.text = "Type Of Insurance".localized()
        self.offerNumberLbl.text = "Offer Number".localized()
        self.startDateLbl.text = "Start Date".localized()
        self.endDateLbl.text = "End Date".localized()
        self.keyTagLbl.text = "Key Tag".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizationText()
        startDateTxt.delegate = self
        endDateTxt.delegate = self
        keyTagTxt.delegate = self
        startDateTxt.setRightView(imageName: "Vector")
        endDateTxt.setRightView(imageName: "Vector")
   
        setUpCollectionView()
        typeOfInsurancedDropDown.anchorView = typeOfInsuranceTxt
        //    typeOfInsurancedDropDown.dataSource = dropDownElememnt
        //    typeOfInsurancedDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
        //        self.typeOfInsuranceTxt.text = dropDownElememnt[Index]
        //
        ////            collectionView.semanticContentAttribute = .forceRightToLeft
        //
        //
        //    }
        
        staticVM.delegate = self
        let param : [String:Any] = ["type": "INSURANCE_TYPE"]
        staticVM.insuranceTypeApiCall(param: param)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectPolicyType()
        if shouldAddLead {
            insuranceBtn.isUserInteractionEnabled = false
            typeOfInsuranceTxt.text = self.insurnceType
        }else{
            insuranceBtn.isUserInteractionEnabled = true
        }
        if isComingFrom == "EditVC" || isComingFrom == "ProposalVC" || isComingFrom == "LeadProposalVC" || isComingFrom == "ForEditProposal" || isComingFrom == "ContractVC" {
            setData()
            self.offerNumberTxt.isUserInteractionEnabled = false
            collectionView.isHidden = false
            doneStackView.isHidden = false
            nextBtnStackView.isHidden = true
        }else{
            self.offerNumberTxt.isUserInteractionEnabled = true
            doneStackView.isHidden = true
            nextBtnStackView.isHidden = false
        }
        self.collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.collectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func setData() {
       // textPolicyType.text = addProposalDic["policyType"] as? String
        self.insurnceType = addProposalDic["insuranceType"] as! String
        self.typeOfInsuranceTxt.text = addProposalDic["insuranceType"] as? String
        self.offerNumberTxt.text = addProposalDic["offerId"] as? String
        
        var startDateStr = addProposalDic["startDate"] as? String
        self.startDate =  startDateStr ?? ""
        let startDateText = startDateStr?.components(separatedBy: "T")[0] ?? ""
        self.startDateTxt.text = returnDOB(date: startDateText)
      
        
        var endDateStr = addProposalDic["endDate"] as? String
        self.endDate = endDateStr ?? ""
        let endDateText = endDateStr?.components(separatedBy: "T")[0]  ?? ""
        self.endDateTxt.text = returnDOB(date: endDateText)
        
     //   self.startDateTxt.text = self.startDate//addProposalDic["startDate"] as? String
     //   self.endDateTxt.text = self.endDate//addProposalDic["endDate"] as? String
        self.keyTagArray = addProposalDic["keyTags"] as! [String]
    }
    
    func selectPolicyType() {
        if isComingFrom == "ProposalVC"  || isComingFrom == "ForEditProposal"{
            textPolicyType.text = "Modification of the offer".localized()
            btnSelectPolicy.isUserInteractionEnabled = true
            
        }else if isComingFrom == "ContractVC" {
            textPolicyType.text = "Existing policy".localized()
        }
        
        else {
            textPolicyType.text = "New Offer".localized()
            btnSelectPolicy.isUserInteractionEnabled = false
            textPolicyType.isUserInteractionEnabled = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.collectionViewHeight.constant = newsize.height
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update placeholder constraint
        self.collectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.reloadData()
        
    }
    
    //MARK:- SetUp CollectionView
    
    func setUpCollectionView() {
        keyTagArray.removeAll()
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "keyTagCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "keyTagCollectionCell")
    }
    
    
    //MARK:- Show DatePicker

    func showDatePicker(){
        
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        
       // let currentDate = Date()
        var components = DateComponents()
        var comps = DateComponents()
       // components.calendar = calendar
  
 
            components.year = 0//110
            comps.year = 110
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: comps, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate//Date()
    
//        components.year = -150
//        let minDate = calendar.date(byAdding: components, to: Date())
//        datePicker.minimumDate = minDate
//        datePicker.maximumDate = Date()
        
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //  use this case for set date in multiple textfiled using same picker
        
    
        startDateTxt.inputView = datePicker
        startDateTxt.inputAccessoryView = toolbar
        
        endDateTxt.inputView = datePicker
        endDateTxt.inputAccessoryView = toolbar
  
    }
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if startDateTxt.isEditing == true {
            
            startDate = "\(formatter.string(from: datePicker.date))"
            
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            
            startDateTxt.text = formatter1.string(from: datePicker.date)
        }
        else {
            endDate =  "\(formatter.string(from: datePicker.date))"//"\(datePicker.date)"

            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
         
            endDateTxt.text = formatter1.string(from: datePicker.date)

        }
        self.view.endEditing(true)
        
    }
    
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        startDateTxt.text = formatter.string(from: sender.date)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    
    @IBAction func btnselcectPolicyType(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for cat in insuranceTypeArr {
            
            
            let action = UIAlertAction(title: cat, style: .default) { (action) in
   
                self.textPolicyType.text = cat
                addProposalDic.setValue(cat, forKey: "policyType")
                
          }

              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            }

            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    @IBAction func onClickTypeOfInsurance(_ sender: Any) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in dropDownElememnt {
            
            
            let action = UIAlertAction(title: cat, style: .default) { (action) in
                
                self.typeOfInsuranceTxt.text = cat
                self.insurnceType = cat
                
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickOfferNumber(_ sender: Any) {
    }
    
    @IBAction func onClickStartDate(_ sender: Any) {
    }
    
    @IBAction func onClickEndDate(_ sender: Any) {
    }
    
    @IBAction func onClickKeyTag(_ sender: Any) {
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == keyTagTxt {
            if keyTagTxt.text != "" {
                if keyTagTxt.text?.trim() == ""{
                    
                }else{
                    
                    keyTagArray.append(keyTagTxt.text!)
                }
                collectionView.isHidden = false
                collectionView.reloadData()
                
            }
            
            
        }
        scrollView.scrollToBottom(animated: true)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == keyTagTxt {
            keyTagTxt.text = ""
            return true
        }
        if textField == startDateTxt {
            showDatePicker()
                return true
            }
            if textField == endDateTxt {

                showDatePicker()
                return true
            }
            return true

        collectionView.reloadData()
        
        
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
        if self.typeOfInsuranceTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select insurance type.".localized())
            return
        } else if self.offerNumberTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter offer number.".localized())
            return
        } else if self.startDateTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter start date.".localized())
            return
        } else if self.endDateTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter end date.".localized())
            return
        }else if self.keyTagArray.count == 0 {
            self.ShowAlert(message: "Please enter key tags".localized())
            return
        }
        
        let param : [String:Any] = ["offerId":offerNumberTxt.text!]
            
        self.validateOfferId(param: param)
        

    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)
    }
    

    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        
        if self.typeOfInsuranceTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select insurance type.".localized())
            return
        } else if self.offerNumberTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter offer number.".localized())
            return
        } else if self.startDateTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter start date.".localized())
            return
        } else if self.endDateTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter end date.".localized())
            return
        }else if self.keyTagArray.count == 0 {
            self.ShowAlert(message: "Please enter key tags".localized())
            return
        }

        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        
        if userType as! String == "AGENT"{
            addProposalDic.setValue(sourceId, forKey: "partnerId")
        }else{
            addProposalDic.setValue(partnerId, forKey: "partnerId")
        }
        
        
        
        
       
        addProposalDic.setValue(self.insurnceType, forKey: "insuranceType")
        addProposalDic.setValue(self.offerNumberTxt.text!, forKey: "offerId")
        addProposalDic.setValue(self.textPolicyType.text, forKey: "policyType")
//        addProposalDic.setValue("2023-06-08T09:07:10.182Z", forKey: "startDate")
//        addProposalDic.setValue("2023-06-08T09:07:10.182Z", forKey: "endDate")
        addProposalDic.setValue(self.startDate, forKey: "startDate")
        addProposalDic.setValue(self.endDate, forKey: "endDate")
        addProposalDic.setValue(keyTagArray, forKey: "keyTags")
        addProposalDic.setValue(addProposalDic["leadId"] as? String, forKey: "leadId")
        
        navigationController?.popViewControllerWithHandler(animated: true, completion: {
            
            if self.isComingFrom == "EditVC" {
                self.delegate?.updateData()
            } else {
                self.updateDelegate?.updateEditedDataFromMainListing()
            }
            
            
        })
    }
    
    
    func validateOfferId (param:[String:Any]) {
        SwiftLoader.show(animated: true)

        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.validateOfferId, method: "POST", passToken: true, expecting:AddPolicyModel.self, dataDict: param) { response
            
            in

            print(response)
            switch response {
            
            case .success(let result):
                SwiftLoader.hide()

                DispatchQueue.main.async {
                    
                    if result.status == "SUCCESS" {
                        if result.data?.isValid == true {

                            let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                            
                            let userType = kUserDefaults.value(forKey: AppKeys.userType)
                            let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                            
                            if userType as! String == "AGENT"{
                                addProposalDic.setValue(sourceId, forKey: "partnerId")
                            }else{
                                addProposalDic.setValue(partnerId, forKey: "partnerId")
                            }
                            
                            addProposalDic.setValue(self.insurnceType, forKey: "insuranceType")
                            addProposalDic.setValue(self.offerNumberTxt.text!, forKey: "offerId")
                            addProposalDic.setValue("New Offer", forKey: "policyType")
//                            addProposalDic.setValue("2023-06-08T09:07:10.182Z", forKey: "startDate")
//                            addProposalDic.setValue("2023-06-08T09:07:10.182Z", forKey: "endDate")

                            addProposalDic.setValue(self.endDate, forKey: "endDate")
                            addProposalDic.setValue(self.startDate, forKey: "startDate")
                            addProposalDic.setValue(self.keyTagArray, forKey: "keyTags")
//                            addProposalDic.setValue("", forKey: "leadId")
                            
                            if self.shouldAddLead {
                                addProposalDic.setValue(self.leadId, forKey: "leadId")
                            } else {
                                addProposalDic.setValue("", forKey: "leadId")
                            }
                            
            
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
                            next.shouldAddLead = self.shouldAddLead
                            next.agentId = self.agentId
                            next.agentName = self.agentName
                            self.navigationController?.pushViewController(next , animated: true)
                        } else {
                            self.ShowAlert(message:"duplicate offer/policy id already exists".localized())                        }
                    }
                    
                    

                }

            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    
                    self.ShowAlert(message: error.localizedDescription)
                    
                }
            }

        
        }

    }
    
}

//MARK:- Extension for collectionView

extension SecondViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyTagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "keyTagCollectionCell", for: indexPath) as! keyTagCollectionCell
        
        cell.lblKeyName.text = keyTagArray[indexPath.item]
        cell.btnDismiss.tag = indexPath.item
        
        cell.btnDismiss.addTarget(self, action:#selector(self.btnDismissAction), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func btnDismissAction(_ Sender: UIButton){
        
        keyTagArray.remove(at: Sender.tag)
        if keyTagArray.isEmpty == true{
            collectionViewHeight.constant = 0
            collectionView.isHidden = true
        }
        
        collectionView.reloadData()
        
    }
    
    
}

extension SecondViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView.numberOfItems(inSection: section) == 1 {
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)
            
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let collectionViewWidth = collectionView.bounds.width
    //        return CGSize(width: collectionViewWidth, height:50)
    ////        let collectionWidth = collectionView.bounds.width
    ////        return CGSize(width: collectionWidth / 3 - 2, height: collectionWidth / 3 - 2)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 2
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 2
    //    }
}

extension SecondViewController: SetInsuranceTypeData {
    
    func setData(data: InsuranceTypeModel) {
        let privateData = data.data?.data ?? []
        let businessData = data.data?.businessData ?? []
        dropDownElememnt = privateData + businessData
        
    }
    
    func showMessage(msg: String) {
        self.showOkAlert(msg)
    }
    
    
}


extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height )//+ 50)
        self.setContentOffset(bottomOffset, animated: false)
    }
}


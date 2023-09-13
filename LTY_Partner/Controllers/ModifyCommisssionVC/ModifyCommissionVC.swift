//
//  ModifyCommissionVC.swift
//  LTY_Partner
//
//  Created by CTS on 05/08/23.
//

import UIKit

protocol ModifyProtolDelegate {
    func modifyProtocol(setValue:String)
}

class ModifyCommissionVC: UIViewController, ModifyCommissionProtocolDelegate ,UITextFieldDelegate{
    
    var contractDic : SubmissionProposalsList?
    var modifyProtocolDelegate : ModifyProtolDelegate?
    var datePicker = UIDatePicker()
    
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var agentGrossTxt: UITextField!
    @IBOutlet weak var agentReserveTxt: UITextField!
    @IBOutlet weak var agentCommissionTxt: UITextField!
    @IBOutlet weak var partnerGrossTxt: UITextField!
    @IBOutlet weak var partnerReserveTxt: UITextField!
    @IBOutlet weak var frequencyLbl: UILabel!
    @IBOutlet weak var agentNameTxt: UITextField!
    
    @IBOutlet weak var partnerCommissionTxt: UITextField!
    @IBOutlet weak var commissionDateTxt: UITextField!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var customerVM = CustomerViewModel()
    var startDatee = ""
    var endDatee = ""
    var commissionDate = ""
    let frquencyArr = [["Month".localized(), "12"],["Quarter".localized(), "4"],["Semester".localized(), "2"],["Year".localized(), "1"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        startDateTxt.delegate = self
        endDateTxt.delegate = self
        commissionDateTxt.delegate = self
        setDrowerHeight()
        
        customNavDrower.titleLabel.text = "Modify Commission".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        self.setData()
    }
    
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
        }
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setData() {
        
        self.agentNameTxt.text = self.contractDic?.agentDetails?.agentName ?? "Unassigned".localized()
        self.agentCommissionTxt.text = "\(self.contractDic?.commissionDetails?.agentCommission ?? 0.0)"
        self.partnerCommissionTxt.text = "\(self.contractDic?.commissionDetails?.partnerCommission ?? 0.0)"
        self.partnerReserveTxt.text = "\(self.contractDic?.commissionDetails?.partnerReserve ?? 0.0)"
        self.partnerGrossTxt.text = "\(self.contractDic?.commissionDetails?.partnerGrossCommission ?? 0.0)"
        self.agentReserveTxt.text = "\(self.contractDic?.commissionDetails?.agentReserve ?? 0.0)"
        self.agentGrossTxt.text = "\(self.contractDic?.commissionDetails?.agentGrossCommission ?? 0.0)"

        var startDate = self.contractDic?.policyDetails?.startDate ?? ""
        startDate = startDate.components(separatedBy: "T")[0]
        self.startDateTxt.text = returnDOB(date: startDate)
        
        startDatee = self.contractDic?.policyDetails?.startDate ?? ""
        endDatee =  self.contractDic?.policyDetails?.endDate ?? ""
        commissionDate = self.contractDic?.commissionDetails?.commissionDate ?? ""
        
        var commissionDatee = self.contractDic?.commissionDetails?.commissionDate ?? ""
        commissionDatee = commissionDatee.components(separatedBy: "T")[0]
        self.commissionDateTxt.text = returnDOB(date: commissionDatee)

        
        var endDate = self.contractDic?.policyDetails?.endDate ?? ""
        endDate = endDate.components(separatedBy: "T")[0]
        self.endDateTxt.text = returnDOB(date: endDate)
        
        self.frequencyLbl.text = self.contractDic?.commissionDetails?.frequency ?? ""
    }
    
    
    
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
        
        commissionDateTxt.inputView = datePicker
        commissionDateTxt.inputAccessoryView = toolbar
        
        
    }
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if startDateTxt.isEditing == true {
            
            startDatee = "\(formatter.string(from: datePicker.date))"
            
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            
            startDateTxt.text = formatter1.string(from: datePicker.date)
        }
        else if endDateTxt.isEditing == true {
            endDatee =  "\(formatter.string(from: datePicker.date))"//"\(datePicker.date)"

            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
         
            endDateTxt.text = formatter1.string(from: datePicker.date)

        }else {
            commissionDate =  "\(formatter.string(from: datePicker.date))"//"\(datePicker.date)"

            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
         
            commissionDateTxt.text = formatter1.string(from: datePicker.date)
        }
        self.view.endEditing(true)
        
    }
    
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == startDateTxt {
            showDatePicker()
            return true
        }
        if textField == endDateTxt {
            
            showDatePicker()
            return true
        }
        if textField == commissionDateTxt {
            
            showDatePicker()
            return true
        }
        return true

        
    }
    @IBAction func onClickAddFrequency(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for cat in frquencyArr {
            
            
            let action = UIAlertAction(title: cat[0], style: .default) { (action) in
                
                self.frequencyLbl.text = cat[0]

                }
  

              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            
    }
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        customerVM.modifyCommissiondelegate = self
      
        var commissionDic = NSMutableDictionary()
        commissionDic.setValue(self.partnerCommissionTxt.text!, forKey: "partnerCommission")
        commissionDic.setValue(self.partnerReserveTxt.text!, forKey: "partnerReserve")
        commissionDic.setValue(self.partnerGrossTxt.text!, forKey: "partnerGrossCommission")
        commissionDic.setValue(self.agentCommissionTxt.text!, forKey: "agentCommission")
        commissionDic.setValue(self.agentReserveTxt.text!, forKey: "agentReserve")
        commissionDic.setValue(self.agentGrossTxt.text!, forKey: "agentGrossCommission")
        commissionDic.setValue(commissionDate, forKey: "commissionDate")
        commissionDic.setValue(self.frequencyLbl.text!, forKey: "frequency")
        
        let param:[String:Any] = ["proposalId": self.contractDic?.proposalId ?? "", "startDate":startDatee, "endDate":endDatee, "commissionDetails": commissionDic]
        customerVM.modifyCommissionApi(param: param, url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.modifyCommission)
    }
    
    @IBAction func onClickCancel(_ sender: UIButton) {
        self.popVC(animated: true)
    }
    

    func setModifyCommissionData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
            DispatchQueue.main.async {
                self.navigationController?.popViewControllerWithHandler(animated: true, completion: {
                    self.modifyProtocolDelegate?.modifyProtocol(setValue: "true")
                })
            }
        }
        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
        
    }
    
}

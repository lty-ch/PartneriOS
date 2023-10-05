//
//  SubmissionDetailVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 19/06/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class SubmissionDetailVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var titleRelation: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var titleMemberName: UILabel!
    @IBOutlet weak var cellCompanyLbl: UILabel!
    @IBOutlet weak var btnPeriodicity: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var policyDocTableView: UITableView!
    @IBOutlet weak var policyTableHeigt: NSLayoutConstraint!
    @IBOutlet weak var signDocTableHeight: NSLayoutConstraint!
    @IBOutlet weak var submitBtnView: UIStackView!
    @IBOutlet weak var uploadDocTable: UITableView!
    
    @IBOutlet weak var policyNumberLbl: UILabel!
    @IBOutlet weak var catLbl: UILabel!
    @IBOutlet weak var customerFullNameLbl: UILabel!
    @IBOutlet weak var customerAddressLbl: UILabel!
    
    @IBOutlet weak var customerDobLbl: UILabel!
    @IBOutlet weak var customerMailLbl: UILabel!
    @IBOutlet weak var customerMobileLbl: UILabel!
    @IBOutlet weak var customerCountryLbl: UILabel!
    @IBOutlet weak var customerStateLbl: UILabel!
    @IBOutlet weak var customerCityLbl: UILabel!
    @IBOutlet weak var agentFullNameLbl: UILabel!
    @IBOutlet weak var agentContactLbl: UILabel!
    @IBOutlet weak var agentMailLbl: UILabel!
    @IBOutlet weak var personCoveredLbl: UILabel!
    @IBOutlet weak var amountAssuredLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    
    @IBOutlet weak var partnerGrossCommLbl: UILabel!
    @IBOutlet weak var agentNetCommiLbl: UILabel!
    @IBOutlet weak var agentGrossCommLbl: UILabel!
    @IBOutlet weak var agentCommissionLbl: UILabel!
    @IBOutlet weak var agentReserveLbl: UILabel!
    @IBOutlet weak var partnerReserveLbl: UILabel!
    
    @IBOutlet weak var textPolicyId: UITextField!
    @IBOutlet weak var textPeriodicity: UITextField!
    @IBOutlet weak var textCommissionStartDate: UITextField!

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
       @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var policyDocArr = [String]()
    var isPending = false
    var proposalId = ""
    var proposaldetailVM = ProposalDetailViewModel()
    var docArr = [String]()
    var picker = UIImagePickerController()
    var pickedImageUrl:URL?
    var commissionStartDate = ""
    var datePicker = UIDatePicker()
    let periodicityArr = [["Month".localized(), "12"],["Quarter".localized(), "4"],["Semester".localized(), "2"],["Year".localized(), "1"]]
    var memberId = ""
    var userId = ""
    var shouldOverride = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var commisionDate = commissionStartDate
        if commisionDate == ""{
            textCommissionStartDate.text = ""
        }else {
            commisionDate = commisionDate.components(separatedBy: "T")[0]
            textCommissionStartDate.text = returnDOB(date: commisionDate) == "" ? "" : returnDOB(date: commisionDate)
        }
        uploadDocTable.register(UINib(nibName: "ProposalDetailPolicyTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ProposalDetailPolicyTableCell")
        textCommissionStartDate.delegate = self
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Submission Details".localized()
        titleRelation.text = "Relation".localized()
        titleMemberName.text = "Member Name".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        if self.isPending {
            self.submitBtnView.isHidden = false
            textPolicyId.isUserInteractionEnabled = true
            textPeriodicity.isUserInteractionEnabled = true
            btnPeriodicity.isUserInteractionEnabled = true
            textCommissionStartDate.isUserInteractionEnabled = true
            btnUpload.setTitle("Upload ->".localized(), for: .normal)

        } else {
            self.submitBtnView.isHidden = true
            textPolicyId.isUserInteractionEnabled = false
            textPeriodicity.isUserInteractionEnabled = false
            btnPeriodicity.isUserInteractionEnabled = false
            textCommissionStartDate.isUserInteractionEnabled = false
            btnUpload.setTitle("", for: .normal)

        }
        policyDocTableView.register(UINib(nibName: "ProposalDetailPolicyTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ProposalDetailPolicyTableCell")
        
        setUPTable()
    }
    
    func setUPTable(){
        
        policyDocTableView.estimatedRowHeight = 40
        self.policyDocTableView.rowHeight = UITableView.automaticDimension
        self.policyDocTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        uploadDocTable.estimatedRowHeight = 40
        self.uploadDocTable.rowHeight = UITableView.automaticDimension
        self.uploadDocTable.addObserver(self, forKeyPath: "contentSize1", options: .new, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        policyTableHeigt.constant = policyDocTableView.contentSize.height
        signDocTableHeight.constant = uploadDocTable.contentSize.height
        //policyDocTableView.reloadData()
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
            if(keyPath == "contentSize"){
                if let newvalue = change?[.newKey]
                {
                    let newsize = newvalue as! CGSize
                    policyTableHeigt.constant = newsize.height
                    //docViewHeight.constant = 125 + newsize.height
                }
            }
        
            if(keyPath == "contentSize1"){
                if let newvalue = change?[.newKey]
                {
                    let newsize = newvalue as! CGSize
                    signDocTableHeight.constant = newsize.height
                    
                }
            }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        let param: [String:Any] = ["proposalId": self.proposalId]
        self.viewProposalApi(param: param)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:  GET Submission detail API
    
    func viewProposalApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.viewProposal, method: "POST", passToken: true, expecting:ViewProposalModel.self, dataDict: param) { response
            
            in
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                
                DispatchQueue.main.async {
                    
                    let info = result.data
                
                    self.lblRelation.text = info?.leadDetails?.relation ?? ""
                    self.lblMemberName.text = info?.leadDetails?.memberName ?? ""
                    let offerNo = info?.policyDetails?.offerId ?? ""
                    let policyNo = info?.policyDetails?.policyId ?? ""
                    self.policyNumberLbl.text = policyNo + "/" + offerNo
                    self.catLbl.text = info?.insuranceType ?? ""
                    self.cellCompanyLbl.text = info?.policyDetails?.categoryDetails?.categoryName ?? ""
                    let fName = info?.memberDetails?.firstName?.capitalized   ?? ""
                    let lName = info?.memberDetails?.lastName?.capitalized   ?? ""
                    self.customerFullNameLbl.text = "\(fName) \(lName)"
                    self.customerAddressLbl.text = info?.memberDetails?.address ?? ""
                    self.customerMailLbl.text = info?.memberDetails?.email ?? ""
                    let countryCode = info?.memberDetails?.countryCode ?? ""
                    
                    self.customerMobileLbl.text = "\(countryCode) \(info?.memberDetails?.mobile ?? "")"
                    self.customerCountryLbl.text = info?.memberDetails?.country ?? ""
                    self.customerStateLbl.text = info?.memberDetails?.state ?? ""
                    self.customerCityLbl.text = info?.memberDetails?.city ?? ""
                    
                    self.agentFullNameLbl.text = info?.agentDetails?.agentName ?? "Unassigned".localized()
                    let countryCode1 = info?.agentDetails?.countryCode ?? ""
                    
                    self.agentContactLbl.text = "\(countryCode1) \(info?.agentDetails?.mobile ?? "")"
                   // self.agentContactLbl.text = info?.agentDetails?.mobile ?? ""
                    self.agentMailLbl.text = info?.agentDetails?.email ?? ""
                    self.customerDobLbl.text =  returnDOB(date: info?.memberDetails?.dob ?? "")//info?.memberDetails?.dob ?? ""
                        
                    var startDate = info?.policyDetails?.startDate ?? ""
                    startDate = startDate.components(separatedBy: "T")[0]
                    
                    var endDate = info?.policyDetails?.endDate ?? ""
                    endDate = endDate.components(separatedBy: "T")[0]
                    
                    
                    self.startDateLbl.text = returnDOB(date: startDate)
                    self.endDateLbl.text = returnDOB(date: endDate)
                    
                    self.partnerGrossCommLbl.text = "\(String(describing: info?.commissionDetails?.partnerGrossCommission ?? 0.0))"
                    self.agentNetCommiLbl.text = "\(String(describing: info?.commissionDetails?.agentGrossCommission ?? 0.0))"
                    self.agentGrossCommLbl.text = "\(String(describing: info?.commissionDetails?.agentGrossCommission ?? 0.0))"
                    self.agentCommissionLbl.text = "\(String(describing: info?.commissionDetails?.agentCommission ?? 0.0))"
                    self.agentReserveLbl.text = "\(String(describing: info?.commissionDetails?.agentReserve ?? 0.0))"
                    self.partnerReserveLbl.text = "\(String(describing: info?.commissionDetails?.partnerReserve ?? 0.0))"
                    
                    self.memberId = info?.leadDetails?.memberId ?? ""
                    self.userId = info?.memberDetails?.memberId ?? ""
                    
                    let signedDocs = info?.signedDoc ?? []
                    for item in signedDocs {
                        self.docArr.append(item)
                    }
//                    self.docArr.append(signedDocs)
                    self.uploadDocTable.reloadData()
                    
                    self.amountAssuredLbl.text = "\(info?.policyDetails?.premiumAmount ?? 0)"

                    if !self.isPending {
                        
                       
                            var commissionDate = info?.commissionDetails?.commissionDate ?? ""
                        if commissionDate == ""{
                            self.textCommissionStartDate.text = ""
                        }else{
                            commissionDate = commissionDate.components(separatedBy: "T")[0]
                            
                            self.textCommissionStartDate.text = returnDOB(date: commissionDate)
                        }
                        self.textPeriodicity.text = info?.policyDetails?.periodicity ?? ""
                        self.textPolicyId.text = info?.policyDetails?.policyId ?? ""
//                        self.textCommissionStartDate = info?.commissionDetails
//                        let policdocs = info?.policyDetails?.policyDocs ?? []
                        let policdocs = info?.contractDoc ?? []
                        for item in policdocs {
                            self.policyDocArr.append(item)
                        }
                        self.policyDocTableView.reloadData()
                    }
                    
                }
                
            case .failure(let error):
                SwiftLoader.hide()
                DispatchQueue.main.async {
                    
                    self.ShowAlert(message: error.localizedDescription)
                    
                }
            }
        }
        
    }  // END Api Call Func
    
    
       func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           
           if textField == textCommissionStartDate {
               showDatePicker()
               return true
           }
           
           return true
           
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
           
           var components = DateComponents()
           var comps = DateComponents()
           
           components.year = 110
           let minDate = calendar.date(byAdding: components, to: Date())
           datePicker.minimumDate = Date()
           datePicker.maximumDate = minDate
           
           /*
           components.year = -150
           let minDate = calendar.date(byAdding: components, to: Date())
           datePicker.minimumDate = minDate
           datePicker.maximumDate = Date()
           */
           
           //ToolBar
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
           
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           let cancelButton = UIBarButtonItem(title: "Cancel".localized().localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
           
           
           toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
           
           //  use this case for set date in multiple textfiled using same picker
           
           
           textCommissionStartDate.inputView = datePicker
           textCommissionStartDate.inputAccessoryView = toolbar
           
           
       }
       //MARK: Function to handle done in datepicker
       
       @objc func donedatePicker(){
           
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
               
           commissionStartDate = "\(formatter.string(from: datePicker.date))"
               
           let formatter1 = DateFormatter()
           formatter1.dateFormat = "dd.MM.yyyy"
               textCommissionStartDate.text = formatter1.string(from: datePicker.date)

           self.view.endEditing(true)
           
       }
       
       //MARK: Function to handle cancel in datepicker
       
       @objc func cancelDatePicker(){
           
           self.view.endEditing(true)
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
       
    //MARK: -> ADD Policy id API
    
    func submitSubmissionProposalApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.addPolicyId, method: "POST", passToken: true, expecting:ViewProposalModel.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                if result.status == "SUCCESS" {
                    DispatchQueue.main.async {
                        self.showOkAlertWithHandler("Proposal Sent successfully".localized()) {
                            self.popVC(animated: true)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.ShowAlert(message: result.error?.serverErrorMessage ?? "")
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
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
            if textPolicyId.text!.isEmpty {
                self.ShowAlert(message: "Please enter your Policy Id.".localized())
                return
            } else if textPeriodicity.text!.isEmpty {
                self.ShowAlert(message: "Please enter frequency.".localized())
                return
            } else if textCommissionStartDate.text!.isEmpty {
                self.ShowAlert(message: "Please enter Commission start date.".localized())
                return
            } else if self.policyDocArr.count == 0 {
                self.ShowAlert(message: "Please upload Policy Document.".localized())
                return
            }
            
            let param : [String:Any] = ["policyId": self.textPolicyId.text!, "userId":self.memberId]
            self.validatePolicyIdApi(param: param)
            
//            let param : [String:Any] = ["proposalId": self.proposalId, "policyId": self.textPolicyId.text!, "commissionDate": self.commissionStartDate, "frequency": self.textPeriodicity.text!, "contractDoc": self.policyDocArr]
//            self.submitSubmissionProposalApi(param: param)
            return
        }

        let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

        let checkAccess = self.checkAccess(id: 10, useCaseArr: userRole?.useCasesList)
        if checkAccess.1 {
            
            if textPolicyId.text!.isEmpty {
                self.ShowAlert(message: "Please enter your Policy Id.".localized())
                return
            } else if textPeriodicity.text!.isEmpty {
                self.ShowAlert(message: "Please enter frequency.".localized())
                return
            } else if textCommissionStartDate.text!.isEmpty {
                self.ShowAlert(message: "Please enter Commission start date.".localized())
                return
            }
            
            let param : [String:Any] = ["policyId": self.textPolicyId.text!, "userId":self.memberId]
            self.validatePolicyIdApi(param: param)
            
//            let param : [String:Any] = ["proposalId": self.proposalId, "policyId": self.textPolicyId.text!, "commissionDate": self.commissionStartDate, "frequency": self.textPeriodicity.text!, "contractDoc": self.docArr]
//            self.submitSubmissionProposalApi(param: param)
        }
        else{
            self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
            
        }
        
    }

    
    func validatePolicyIdApi (param:[String:Any]) {
        
        SwiftLoader.show(animated: true)
        
        Services.shareInstance.postRequestApi(url: LTY_BASE_URL.BASE_URL_INSURANCE + LTY_END_POINT_URL.validatePolicyId, method: "POST", passToken: true, expecting:ValidatePolicyId.self, dataDict: param) { response
            
            in
            print(response)
            switch response {
                
            case .success(let result):
                SwiftLoader.hide()
                
                if result.status == "SUCCESS" {
                    DispatchQueue.main.async {
                        if result.data?.isValid == true {
                            let param : [String:Any] = ["proposalId": self.proposalId, "policyId": self.textPolicyId.text!, "commissionDate": self.commissionStartDate, "frequency": self.textPeriodicity.text!, "contractDoc": self.docArr,"needToOverride":self.shouldOverride]
                            self.submitSubmissionProposalApi(param: param)
                        }else{
                            if result.data?.linkedWithSameUser == true {
                                self.showAlertWithActions(msg: "Do you want to replace Policy Id ?".localized(), titles: ["Yes".localized(), "No".localized()]) { (value) in
                                    if value == 1{
                                        self.shouldOverride = true
                                        
                                        let param : [String:Any] = ["proposalId": self.proposalId, "policyId": self.textPolicyId.text!, "commissionDate": self.commissionStartDate, "frequency": self.textPeriodicity.text!, "contractDoc": self.docArr,"needToOverride":self.shouldOverride]
                                        
                                        self.submitSubmissionProposalApi(param: param)
                                    }
                                }
                            }else{
                                self.ShowAlert(message: "Ploicy Id Already Exist.".localized())
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.ShowAlert(message: result.error?.serverErrorMessage ?? "")
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
    

    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.popVC(animated: true)
    }
    
    @IBAction func onClickUploadDocs(_ sender: UIButton) {
        self.chooseWhatToUpload()
    }
    
    @IBAction func onClickPeriodicity(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for cat in periodicityArr {
            
            
            let action = UIAlertAction(title: cat[0], style: .default) { (action) in
                
                self.textPeriodicity.text = cat[0]

                }
  

              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            
    }
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    
    
}

extension SubmissionDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableView == self.uploadDocTable {
                return self.docArr.count
            } else {
                return self.policyDocArr.count
            }
            
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.uploadDocTable {
            let cell = uploadDocTable.dequeueReusableCell(withIdentifier: "ProposalDetailPolicyTableCell", for: indexPath) as! ProposalDetailPolicyTableCell
            
           cell.cellLbl.text = (self.docArr[indexPath.row])
//            let data = (self.docArr[indexPath.row] as! String)
//            if let lastSlashIndex = data.lastIndex(of: "/") {
//                let fileName = String(data[data.index(after: lastSlashIndex)...])
//                cell.cellLbl.text = fileName
//                //            print("File Name: \(fileName)")
//            } else {
//                print("Invalid URL format")
//            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = uploadDocTable.dequeueReusableCell(withIdentifier: "ProposalDetailPolicyTableCell", for: indexPath) as! ProposalDetailPolicyTableCell
            
            cell.cellLbl.text = (self.policyDocArr[indexPath.row])
//            let data = (self.policyDocArr[indexPath.row] as! String)
//            if let lastSlashIndex = data.lastIndex(of: "/") {
//                let fileName = String(data[data.index(after: lastSlashIndex)...])
//                cell.cellLbl.text = fileName
//                //            print("File Name: \(fileName)")
//            } else {
//                print("Invalid URL format")
//            }
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var filename = NSString()
         if tableView == self.uploadDocTable {
             filename = docArr[indexPath.row] as NSString
         } else {
             filename = policyDocArr[indexPath.row] as NSString
         }
         
         let pathExtention = filename.pathExtension
         
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
           
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = filename as String
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
//             if let url = URL(string:filename as String) {
//                 UIApplication.shared.open(url)
//             }
         }else{
             let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
             vc.image = filename as String
             vc.modalTransitionStyle = .crossDissolve
             vc.modalPresentationStyle = .overFullScreen
             self.present(vc, animated: true)

         }
         
  
     }
    
}




extension SubmissionDetailVC : UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIImagePickerControllerDelegate {
    
    func chooseWhatToUpload() {
            
            let alertController = UIAlertController(title: "Please select what would you like to upload?".localized(), message: "", preferredStyle: .actionSheet)
            let cancelButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            alertController.addAction(UIAlertAction(title: "Image".localized(), style: .default , handler:{ (UIAlertAction)in
                self.chooseType()
            }))
            alertController.addAction(UIAlertAction(title: "Document".localized(), style: .default , handler:{ (UIAlertAction)in
                self.clickFunction()
            }))
            
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true)
    //        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)

        }
        
        func noCamera(){
            let alertVC = UIAlertController(
                title: "No Camera".localized(),
                message: "Sorry, this device has no camera".localized(),
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK".localized(),
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true)
    //        UIApplication.topViewController()?.present(
    //            alertVC,
    //            animated: true,
    //            completion: nil)
        }
        
        func chooseType() {
            let alert = UIAlertController(title: "", message: "Select Mode".localized(), preferredStyle: UIAlertController.Style.actionSheet)
            
            
            let deletbutton =  UIAlertAction(title: "Delete".localized(), style: UIAlertAction.Style.destructive, handler: {(action) in
                // self.Profileimage.image = #imageLiteral(resourceName: "customer.png")
                
            })
            // add the actions (buttons)
            let takephoto =  UIAlertAction(title: "Take Photo".localized(), style: UIAlertAction.Style.default, handler: {(action) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.picker.delegate = self
                    self.picker.allowsEditing = false
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.modalPresentationStyle = .fullScreen
                    self.present(self.picker, animated: true)
    //                UIApplication.topViewController()?.present(self.picker,animated: true,completion: nil)
                } else {
                    self.noCamera()
                }
                
                
            })
            
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil))
            
            let uploadphoto = UIAlertAction(title: "Upload Photo".localized(), style: UIAlertAction.Style.default, handler: {(action) in
                self.picker.delegate = self
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true)
    //            UIApplication.topViewController()?.present(self.picker, animated: true, completion: nil)
                
                
            })
            
//            alert.addAction(takephoto)
            alert.addAction(uploadphoto)
            //  alert.addAction(deletbutton)
            // show the alert
            self.present(alert, animated: true)
    //        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
        
        func clickFunction() {
            
            
            
            let types: [String] = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
            let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            documentPicker.modalPresentationStyle = .formSheet
            present(documentPicker, animated: true, completion: nil)
            
            /*
            let importMenu = UIDocumentMenuViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
            
            // UIApplication.topViewController()?.present(importMenu, animated: true, completion: nil)
            */
        }
        
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let myURL = urls.first else {
                return
            }
            print("import result : \(myURL)")
            let filename = URL(fileURLWithPath: String(describing:urls)).lastPathComponent
            let fileUrlkk = Foundation.URL(string: myURL.absoluteString)
            do {
                let data = try Data(contentsOf: fileUrlkk!)
                let imageSize: Int = data.count
                if Double(imageSize) / 1000000.0 < 25.0 {
    //                self.uploadFileAPI(data, fileNamee: myURL.lastPathComponent)
                    self.pickedImageUrl = myURL
                    self.requestNativeImageUpload("Contract Doc")
                }
            } catch {
                
            }
            
        }
        
        func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
            documentPicker.delegate = self
            documentPicker.modalPresentationStyle = .fullScreen
            self.present(documentPicker, animated: true, completion: nil)
            // UIApplication.topViewController()?.present(documentPicker, animated: true, completion: nil)
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("view was cancelled")
            //UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    //        let imageData = chosenImage.jpegData(compressionQuality: 0.5)
    //        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
            if let pickedImage = info[.originalImage] as? UIImage {
                saveImageDocumentDirectory(usedImage: pickedImage)
            }
            if let imgUrl = getImageUrl()
            {
                pickedImageUrl = imgUrl
            }
            
            self.dismiss(animated: true, completion: nil)
            
            self.requestNativeImageUpload("Contract Doc")
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    //        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }


        
    func requestNativeImageUpload(_ docName: String){
        SwiftLoader.show(animated: true)
        let fullUrl = LTY_BASE_URL.DOCUMENT_UPLOAD_URL
        let partnerIdd = kUserDefaults.string(forKey: "partnerID") ?? ""
        //            let param = ["userId": partnerIdd, "docName": "Abc"]
        let param = ["userId": self.userId, "docName": docName, "uploadedBy": partnerIdd, "memberId": self.memberId]
        print(param)
        
        ServerClass.sharedInstance.sendMultipartRequestToServer(urlString: fullUrl, fileName: "doc", sendJson: param, imageUrl: pickedImageUrl, successBlock: { (json) in
            print(json)
            SwiftLoader.hide()
            //hideAllProgressOnView(appDelegateInstance.window!)
            let success = json["status"].stringValue
            if success  == "SUCCESS"
            {
                self.policyDocArr.removeAll()
                let url = json["data"]["key"].stringValue
                
                self.policyDocArr.append(url)
                DispatchQueue.main.async {
                    self.showToast(message: "File uploaded successfully.".localized(), font: FontSize.size14!)
                    self.policyDocTableView.reloadData()
                }
                
                
            }else{
                self.ShowAlert(message: json["error"]["serverErrorMessage"].stringValue)
            }
            DispatchQueue.main.async {
                //self.tbleView.reloadData()
            }
        }, errorBlock: { (NSError) in
            SwiftLoader.hide()
            //                UIAlertController.showInfoAlertWithTitle("Alert", message: kUnexpectedErrorAlertString, buttonTitle: "Okay")
            //                hideAllProgressOnView(appDelegateInstance.window!)
        })
        
    }
        
        
        
        
        func generateBoundary() -> String {
            return "Boundary-\(NSUUID().uuidString)"
        }
        
        func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {
            
            let lineBreak = "\r\n"
            var body = Data()
            
            if let parameters = params {
                for (key, value) in parameters {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                    body.append("\(value + lineBreak)")
                }
            }
            
            if let media = media {
                for photo in media {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                    body.append(photo.data)
                    body.append(lineBreak)
                }
            }
            
            body.append("--\(boundary)--\(lineBreak)")
            
            return body
        }
        
        
        struct Media {
            let key: String
            let fileName: String
            let data: Data
            let mimeType: String
            
            init?(withImage image: UIImage, forKey key: String) {
                self.key = key
                self.mimeType = "image/jpg"
                self.fileName = "\(arc4random()).jpeg"
                
                guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
                self.data = data
            }
        }
    
}

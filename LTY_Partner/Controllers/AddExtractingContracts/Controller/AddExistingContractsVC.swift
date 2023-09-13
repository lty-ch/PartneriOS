//
//  AddExistingContractsVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/08/23.
//

import UIKit

protocol UpdadetContractListDelegate {
    func updateContract(value:String)
}

class AddExistingContractsVC: UIViewController, ExistingContractProtocol {
    func setExistingContractData(data: SuccessModel) {
        
        if data.status == "SUCCESS" {
          //  self.popVC(animated: true)
            DispatchQueue.main.async {
                self.navigationController?.popViewControllerWithHandler(animated: true, completion: {
                    self.updadetContractDelegate?.updateContract(value: "true")
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
    
    @IBOutlet weak var lblTitlePolicy: UILabel!
    @IBOutlet weak var lblTitleCategory: UILabel!
    @IBOutlet weak var lblTitleSubCategory: UILabel!
    @IBOutlet weak var lblTitleInsuranceProduct: UILabel!
    @IBOutlet weak var lblTitleInsuranceType: UILabel!
    @IBOutlet weak var lblTitleAgentName: UILabel!
    @IBOutlet weak var lblTitleTotalAmount: UILabel!
    @IBOutlet weak var lblTitlePeridicity: UILabel!
    @IBOutlet weak var lblTitlePremiumAmt: UILabel!
    @IBOutlet weak var lblTitleStartDate: UILabel!
    @IBOutlet weak var lblTitleEndDate: UILabel!
    @IBOutlet weak var lblTitleUploadDoc: UILabel!
    
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var docTableHeight: NSLayoutConstraint!
    @IBOutlet weak var docTableView: UITableView!
    @IBOutlet weak var textEndDate: UITextField!
    @IBOutlet weak var textStartDate: UITextField!
    @IBOutlet weak var lblPeriodicity: UITextField!
    @IBOutlet weak var lblPremiumAmoutn: UITextField!
    @IBOutlet weak var lblTotalamount: UITextField!
    @IBOutlet weak var lblAgentName: UITextField!
    @IBOutlet weak var lblTypeOfInsurance: UITextField!
    @IBOutlet weak var lblInsuredProduct: UITextField!
    @IBOutlet weak var lblsubCategory: UITextField!
    @IBOutlet weak var lblCategory: UITextField!
    @IBOutlet weak var textPolicyNo: UITextField!
    
    @IBOutlet weak var agentBtn: UIButton!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var updadetContractDelegate : UpdadetContractListDelegate?
    var startDate = ""
    var endDate = ""
    var userId = ""
    var memberId = ""
    
    var catId = ""
    var subcatId = ""
    var productId = ""
    var agentId = ""
    var uploadDocArr = [String]()
    var uploadDocNameArr = [String]()
    var pickedImageUrl:URL?
    var picker = UIImagePickerController()
    var datePicker = UIDatePicker()
    var existingContractDic = [String:Any]()
    let periodicityArr = [["Month".localized(), "12"],["Quarter".localized(), "4"],["Semester".localized(), "2"],["Year".localized(), "1"]]
    
    //
    var periodictyFactor = 0.0
    var categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    var subcategoryList = [SubCategoryDataList]()
    var categoryListNewData = [MainCategoryNewList]()
    var subCategoryViewModel = SubCatagoryViewModel()
    var addProposalViewModel = AddProposalViewModel()
    var existingContractViewModel = ExistingContractViewModel()
    var agentList = [AddProposalAgentAgentList]()
    var selectedProductsArr = NSMutableArray()
    var dropDownElememnt = [String]()
    var staticVM = StaticDataViewModel()
    var productsToSendInAPIArr = NSMutableArray()
    var insurnceType = ""
    var subCategoryName = ""
    var subCategoryNameInFrench = ""
    var categoryName = ""
    var categoryNameInFrench = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        setUPTableView()
     
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.titleLabel.text = "Add Existing Contract".localized()
        
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        
        categoryViewModel.delegate = self
        categoryViewModel.categoryListByAgentDelegate = self
        subCategoryViewModel.delegate = self
        subCategoryViewModel.subCategoryListByAgentDelegate = self
        self.addProposalViewModel.delegate = self
        existingContractViewModel.delegate = self
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        if userType as! String == "AGENT"{
            
            self.lblAgentName.text = kUserDefaults.value(forKey: AppKeys.agentName) as? String
            self.agentId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
            addProposalDic.setValue(self.lblAgentName.text!, forKey: "agentName")
            self.agentBtn.isUserInteractionEnabled = false
            
            let param :[String:Any]  = ["agentId":PartnerId]
            categoryViewModel.getCatByAgent(param: param, url: LTY_END_POINT_URL.getCategoryByAgent)
            
            if self.catId != ""{
                //                        let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
                //                        self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                self.subCategoryViewModel.subCatListApi(param: subCatParam)
            }
            //                    let param :[String:Any]  = ["searchBy":"","agentId":sourceId]
            //                    categoryViewModel.productCommissionListApi(param: param, url: LTY_END_POINT_URL.getCategory)
        }else{
            self.agentBtn.isUserInteractionEnabled = true
            
            let param :[String:Any]  = ["partnerId":PartnerId]
            categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)
            if self.catId != "" {
                let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                self.subCategoryViewModel.subCatListApi(param: subCatParam)
                
            }
        }
        
        staticVM.delegate = self
        let param : [String:Any] = ["type": "INSURANCE_TYPE"]
        staticVM.insuranceTypeApiCall(param: param)
       
        setLocalization()
        
    }
    
    func setLocalization(){
        self.lblTitlePolicy.text = "Policy No".localized()
        self.lblTitleCategory.text = "Insurance Company".localized()
        self.lblTitleSubCategory.text = "Insurance Product".localized()
        self.lblTitleInsuranceProduct.text = "Insurance Coverage".localized()
        self.lblTitleInsuranceType.text = "Type Of Insurance".localized()
        self.lblTitleAgentName.text = "Agent Name".localized()
        self.lblTitleTotalAmount.text = "Total Amount".localized()
        self.lblTitlePeridicity.text = "Periodicity".localized()
        self.lblTitlePremiumAmt.text = "Premium Amount".localized()
        self.lblTitleStartDate.text = "Start Date".localized()
        self.lblTitleEndDate.text = "End Date".localized()
        self.lblTitleUploadDoc.text = "Upload Policy Document".localized()
        btnAdd.setTitle("Add".localized(), for: .normal)
        btnCancel.setTitle("Cancel".localized(), for: .normal)
        
    }
    
    func setUPTableView() {
        textEndDate.delegate = self
        textStartDate.delegate = self
        docTableView.delegate = self
        docTableView.dataSource = self
        docTableView.estimatedRowHeight = 40
        self.docTableView.rowHeight = UITableView.automaticDimension
        
        // self.docTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //  docTableHeight.constant = docTableView.contentSize.height
        // docTableView.reloadData()
        //        docViewHeight.constant = 125 + docTableView.contentSize.height
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize = newvalue as! CGSize
                docTableHeight.constant = newsize.height
                //docViewHeight.constant = 125 + newsize.height
            }
        }
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
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Show DatePicker
    
    func showDatePicker(name:String){
        
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
        
        let currentDate = Date()
        var components = DateComponents()
        var comps = DateComponents()
        
//        components.year = -150
//       // comps.year = -16
//        let minDate = calendar.date(byAdding: components, to: Date())
//        let maxDate = calendar.date(byAdding: comps, to: Date())
//        datePicker.minimumDate = minDate
//        datePicker.maximumDate = Date()
//
        
        if name == "start"{
            components.year = -110
            comps.year = 0
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: comps, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
        }else{
            components.year = 110
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: components, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = Date()
        }
    
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //  use this case for set date in multiple textfiled using same picker
        
        
        textEndDate.inputView = datePicker
        textEndDate.inputAccessoryView = toolbar
        
        textStartDate.inputView = datePicker
        textStartDate.inputAccessoryView = toolbar
        
    }
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if textStartDate.isEditing == true {
            
            startDate = "\(formatter.string(from: datePicker.date))"
            
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            
            textStartDate.text = formatter1.string(from: datePicker.date)
        }
        else {
            endDate =  "\(formatter.string(from: datePicker.date))"//"\(datePicker.date)"

            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
         
            textEndDate.text = formatter1.string(from: datePicker.date)

        }
        self.view.endEditing(true)
        
    }
    
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    


    
    func checkValidation() {
        
        guard let policyNo = textPolicyNo.text, !policyNo.isEmpty else {
            self.ShowAlert(message:"Please enter policy number")
            return
        }
        guard let catName = lblCategory.text, !catName.isEmpty else {
             self.ShowAlert(message:"Please select Category")
            return
        }
        guard let subCat = lblsubCategory.text, !subCat.isEmpty else {
             self.ShowAlert(message:"Please select Sub Category")
            return
        }
        guard let insuranceProduct = lblInsuredProduct.text, !insuranceProduct.isEmpty else {
             self.ShowAlert(message:"Please select Insurance product")
            return
        }
        guard let insuranceType = lblTypeOfInsurance.text, !insuranceType.isEmpty else {
             self.ShowAlert(message:"Please select insurance Type")
            return
        }
        guard let agentName = lblAgentName.text, !agentName.isEmpty else {
             self.ShowAlert(message:"Please select agent")
            return
        }
        guard let perodicity = lblPeriodicity.text, !perodicity.isEmpty else {
             self.ShowAlert(message:"Please select perodicity ")
            return
        }
   
        
        if startDate == ""{
            self.ShowAlert(message:"Please enter start date")
        }
        if endDate == ""{
            self.ShowAlert(message:"Please enter end date")
        }
   
        if uploadDocArr.count == 0 {
            self.ShowAlert(message:"Please upload document")
        }
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        
        if userType as! String == "AGENT" {
            existingContractDic["partnerId"] = sourceId
        } else {
            existingContractDic["partnerId"] = PartnerId
        }
        existingContractDic["policyId"] = policyNo
        existingContractDic["offerType"] = "EXISTING"
        existingContractDic["insuranceType"] = insuranceType
        existingContractDic["startDate"] = startDate
        existingContractDic["endDate"] = endDate
        
        
        existingContractDic["periodicity"] = perodicity
        existingContractDic["contractDoc"] = uploadDocArr
        existingContractDic["premiumAmount"] = lblPremiumAmoutn.text
        existingContractDic["memberId"] = userId
        


        var catDetailsDic = NSMutableDictionary()
        catDetailsDic.setValue(catId, forKey: "categoryId")
        catDetailsDic.setValue(self.categoryName, forKey: "categoryName")
        catDetailsDic.setValue(self.categoryNameInFrench, forKey: "categoryNameInFrench")
        catDetailsDic.setValue("", forKey: "categoryLogo")
        catDetailsDic.setValue(subcatId, forKey: "subCategoryId")
        catDetailsDic.setValue(self.subCategoryName, forKey: "subCategoryName")
        catDetailsDic.setValue(self.subCategoryNameInFrench, forKey: "subCategoryNameInFrench")
        
        let dic = NSMutableDictionary()
        dic.setValue(self.productsToSendInAPIArr, forKey: "productList")
//        existingContractDic.setValue(dic, forKey: "productDetails")
        existingContractDic["productDetails"] = dic
        existingContractDic["categoryDetails"] = catDetailsDic
        existingContractDic["agentId"] = agentId
        existingContractDic["totalAmount"] = lblTotalamount.text

        print(existingContractDic)
        existingContractViewModel.insuranceTypeApiCall(param: existingContractDic)
        
    }
    
    
    
    @IBAction func btnOpenCat(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            for cat in categoryListNewData {
        
                let action = UIAlertAction(title: cat.categoryNameInFrench, style: .default) { (action) in
                    self.lblsubCategory.text = ""
                    self.subcatId = ""
                    self.lblInsuredProduct.text = ""
                    self.selectedProductsArr.removeAllObjects()
                    self.productsToSendInAPIArr.removeAllObjects()
                    
                    
                    self.lblCategory.text = cat.categoryNameInFrench ?? ""
                    self.categoryName =  cat.categoryName ?? ""
                    self.categoryNameInFrench =  cat.categoryNameInFrench ?? ""
                    self.catId = cat.categoryId ?? ""
                    
                    let userType = kUserDefaults.value(forKey: AppKeys.userType)
                    let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                    let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                    if userType as! String == "AGENT"{
                        
                        //                        let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
                        //                        self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": sourceId]
                        self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    }else{
                        //                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "searchBy": ""]
                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                        self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    }

                }
     
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                
                actionSheetAlertController.addAction(action)
            }
        }else {
            
            for cat in categoryListNewData {
                
                
                let action = UIAlertAction(title: cat.categoryName, style: .default) { (action) in
                    self.lblsubCategory.text = ""
                    self.subcatId = ""
                    self.lblInsuredProduct.text = ""
                    self.selectedProductsArr.removeAllObjects()
                    self.productsToSendInAPIArr.removeAllObjects()
                    
                    
                    self.lblCategory.text = cat.categoryName ?? ""
                    self.categoryName =  cat.categoryName ?? ""
                    self.categoryNameInFrench =  cat.categoryNameInFrench ?? ""
                    
                    self.catId = cat.categoryId ?? ""
                    
                    let userType = kUserDefaults.value(forKey: AppKeys.userType)
                    let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                    let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                    if userType as! String == "AGENT"{
                        
                        //                        let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
                        //                        self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": sourceId]
                        self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    }else{
                        //                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "searchBy": ""]
                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                        self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    }
                    
                }
                
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                
                actionSheetAlertController.addAction(action)
            }
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnOpenSubCat(_ sender: UIButton) {
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            for cat in subcategoryList {
                let action = UIAlertAction(title: cat.subCategoryNameInFrench, style: .default) { (action) in
                    self.lblsubCategory.text = cat.subCategoryNameInFrench ?? ""
                    self.subCategoryName =  cat.subCategoryName ?? ""
                    self.subCategoryNameInFrench =  cat.subCategoryNameInFrench ?? ""
                    self.subcatId = cat.subCategoryId ?? ""
                    
                    let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                    let agentParam :[String:Any]  = ["partnerId":partnerId, "categoryId":self.catId, "subCategoryId":self.subcatId]
                    print(agentParam)
                    self.addProposalViewModel.addProposalAgentListApi(param: agentParam)
                }

                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }else{
            
            for cat in subcategoryList {
                let action = UIAlertAction(title: cat.subCategoryName, style: .default) { (action) in
                    
                    self.subCategoryName =  cat.subCategoryName ?? ""
                    self.subCategoryNameInFrench =  cat.subCategoryNameInFrench ?? ""
                    
                    self.lblsubCategory.text = cat.subCategoryName ?? ""
                    self.subcatId = cat.subCategoryId ?? ""
                    
                    let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                    let agentParam :[String:Any]  = ["partnerId":partnerId, "categoryId":self.catId, "subCategoryId":self.subcatId]
                    print(agentParam)
                    self.addProposalViewModel.addProposalAgentListApi(param: agentParam)
                }
                
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    @IBAction func btnOpenIsurenaceProduct(_ sender: UIButton) {
        
        if self.lblCategory.text!.isEmpty {
            self.ShowAlert(message: "Please select Category first.".localized())
            return
        } else if self.lblsubCategory.text!.isEmpty {
            self.ShowAlert(message: "Please select Sub category first.".localized())
            return
        }
        
        let vc = AgentSelectVC.instantiate(fromAppStoryboard: .proposalStoryboard)
        vc.subCatId = self.subcatId
        vc.delegate = self
        vc.selectedProductsArr = self.selectedProductsArr
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func btnTypeOfInsuranceAction(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in dropDownElememnt {
            
            
            let action = UIAlertAction(title: cat, style: .default) { (action) in
                
                self.lblTypeOfInsurance.text = cat
                self.insurnceType = cat
                
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnAgentListAction(_ sender: UIButton) {
        
        if self.lblCategory.text!.isEmpty {
            self.ShowAlert(message: "Please select Category first.".localized())
            return
        } else if self.lblsubCategory.text!.isEmpty {
            self.ShowAlert(message: "Please select Sub category first.".localized())
            return
        }
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in agentList {
            
            
            let action = UIAlertAction(title: cat.agentName, style: .default) { (action) in
                
                self.lblAgentName.text = cat.agentName ?? ""
                self.agentId = cat.agentId ?? ""
                addProposalDic.setValue(cat.agentName ?? "", forKey: "agentName")
                
                
            }

            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnOpenPeriodictyAction(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
        for cat in periodicityArr {
            
            
            let action = UIAlertAction(title: cat[0], style: .default) { (action) in
                
                self.lblPeriodicity.text = cat[0]
                self.periodictyFactor = Double(Int(cat[1]) ?? Int(1.0))
                
                if !self.lblTotalamount.text!.isEmpty {
                    let total = Double(self.lblTotalamount.text!) ?? 0.0
                    let prmAmt = total/self.periodictyFactor
                    let y = Double(round(100 * prmAmt) / 100)
                    self.lblPremiumAmoutn.text = "\(y)"
                }

            }

            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnUploadDoc(_ sender: UIButton) {
        chooseWhatToUpload()
    }
    
    
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        
        checkValidation()
        
        
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.popVC(animated: true)
    }
}


extension AddExistingContractsVC : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {
    
    func setCategoryListByAgent(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            
            self.categoryListNewData.removeAll()

                self.categoryListNewData = data.data?.categoryList ?? []

            
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
    
    func setCategoryList(data: CategoryModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()
 
                self.categoryListData = data.data?.categoryList ?? []
            
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
    
    
    func setCategoryNewList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()

                self.categoryListNewData = data.data?.categoryList ?? []
 
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
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
        
    }
    
    
}


extension AddExistingContractsVC : AddPropsalAgentListProtocolDelegate, AgentProductAmountDelegate {
    
    func setProductAmountData(arr: NSMutableArray, nameArr: NSMutableArray) {
        
        //        let dic = NSMutableDictionary()
        //        dic.setValue(arr, forKey: "productList")
        //        addProposalDic.setValue(dic, forKey: "productDetails")
        self.getSelectedProductNames(arr: arr)
        
        let total = self.calculateTotalAmount(arr: arr)
        self.lblTotalamount.text = "\(total)"
        self.lblPeriodicity.text = ""
        self.periodictyFactor = 0.0
        self.lblPremiumAmoutn.text = ""
        
    }
    
    func getSelectedProductNames(arr: NSMutableArray) {
        
        
        print(arr)
        self.selectedProductsArr.removeAllObjects()
        //        self.selectedProductsArr = arr
        var productNamesArr = NSMutableArray()
        productsToSendInAPIArr.removeAllObjects()
        for items in arr {
            let item = items as! NSMutableDictionary
            print(item)
            print(productsToSendInAPIArr)
            if item["isSelected"] as! String == "yes" {
                productNamesArr.add(item["productName"] as! String)
                productsToSendInAPIArr.add(item)
                self.selectedProductsArr.add(item)
            }
            
        }
        print(productsToSendInAPIArr)
        
        
        // Set selected products data in Tf
        let stringRepresentation = productNamesArr.componentsJoined(by: ",")
        self.lblInsuredProduct.text = stringRepresentation
    }
    
    func setMembersList(data: AddProposalMembersModel) {
        if data.status == "SUCCESS" {
            
            print("")
            
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
    
    
    func setAgentList(data: AddProposalAgentModel) {
        if data.status == "SUCCESS" {
            
            self.agentList.removeAll()
            
            self.agentList = data.data?.agentList ?? []
            
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
    
    func calculateTotalAmount(arr: NSMutableArray) -> Double {
        print(arr)
        var totalAmount = 0.0
        for items in arr {
            let item = items as! NSDictionary
            if item.value(forKey: "isSelected") as! String == "yes" {
                let amt = item.value(forKey: "amount") as! Double
                totalAmount += amt
            }
            
        }
        return totalAmount
    }
    
}

extension AddExistingContractsVC: SetInsuranceTypeData {
    
    func setData(data: InsuranceTypeModel) {
        let privateData = data.data?.data ?? []
        let businessData = data.data?.businessData ?? []
        dropDownElememnt = privateData + businessData
        
    }
    
    func showMessage(msg: String) {
        self.showOkAlert(msg)
    }
    
    
}

extension AddExistingContractsVC : subCategoryListProtocolDelegate , subCategoryListByAgentProtocolDelegate , AllCatProtocolDelegate{
    
    func setAllCategoryList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListNewData.removeAll()
        
                self.categoryListNewData = data.data?.categoryList ?? []

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
    
    func setSubCategoryListByAgent(data: SubCategoryModel) {
        if data.status == "SUCCESS" {
            
            self.subcategoryList.removeAll()
 
                self.subcategoryList = data.data?.subCategoryList ?? []
   
            
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
    
    func setSubCategoryList(data: SubCategoryModel) {
        if data.status == "SUCCESS" {
            
            self.subcategoryList.removeAll()
            
            self.subcategoryList = data.data?.subCategoryList ?? []
            
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

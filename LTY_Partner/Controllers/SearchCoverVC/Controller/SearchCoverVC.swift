//
//  SearchCoverVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 17/07/23.
//

import UIKit

class SearchCoverVC: UIViewController,UITextFieldDelegate, CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate {

    @IBOutlet weak var textEndDate: UITextField!
    @IBOutlet weak var textStartDate: UITextField!
    
    @IBOutlet weak var proposalSharedView: UIView!
    @IBOutlet weak var contractSharedView: UIView!
    @IBOutlet weak var totalAmountSharedView: UIView!
    @IBOutlet weak var totalIncomeSharedView: UIView!
    
    @IBOutlet weak var lblTotalProposal: UILabel!
    @IBOutlet weak var lblTotalSignedContract: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalIncome: UILabel!
    
    @IBOutlet weak var lblProposalShared: UILabel!
    @IBOutlet weak var lblContractSigned: UILabel!
    @IBOutlet weak var lblTotalamount: UILabel!
    @IBOutlet weak var lblTotalincome: UILabel!
    
    @IBOutlet weak var btnAnalysis: UIButton!
    @IBOutlet weak var btnAgents: UIButton!
    @IBOutlet weak var btnCustomers: UIButton!
    @IBOutlet weak var btnOverAll: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var datePicker = UIDatePicker()
    var searchCoverVM = SearchCoverViewModel()
    var customerListArr = [CustomersStatisticsList]()
    var agentListArr = [AgentsStatisticsList]()
    var analysisList = [SC_AnalysisData]()
    var selectAgentType = "overAll"
    var startDate = ""
    
    var endDate = ""
    var catId = ""
    var subCatId = ""
    var catName = ""
    var subCatName = ""
    
    let categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    var categoryListNewData = [MainCategoryNewList]()
    var subCategoryViewModel = SubCatagoryViewModel()
    var subcategoryList = [SubCategoryDataList]()
    
    var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        setUpUI()
        
        searchCoverVM.delegate = self
        textEndDate.delegate = self
        textStartDate.delegate = self
        categoryViewModel.delegate = self
        categoryViewModel.categoryListByAgentDelegate = self
        subCategoryViewModel.delegate = self
        subCategoryViewModel.subCategoryListByAgentDelegate = self
        
        customNavDrower.titleLabel.text = "Data Analysis & Extraction".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        overAllView.isHidden = false
        tableView.isHidden = true
        
        let userType = kUserDefaults.value(forKey: AppKeys.userType)
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        
        if userType as! String == "AGENT"{
            
            let param :[String:Any]  = ["agentId":PartnerId]
            categoryViewModel.getCatByAgent(param: param, url: LTY_END_POINT_URL.getCategoryByAgent)

        }else{
            let param :[String:Any]  = ["partnerId":PartnerId]
            categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)

        }
    }
    
    func setUpUI() {
        
        btnAnalysis.viewCorner(8)
        btnAnalysis.setTitleColor(Asset.Colors.blackColor.color, for: .normal)
        btnAnalysis.setTitle("Analysis".localized(), for: .normal)
        btnAnalysis.viewCorner(8)
        
        btnAgents.setTitleColor(Asset.Colors.blackColor.color, for: .normal)
        btnAgents.setTitle("Agent Analytics".localized(), for: .normal)
        btnAgents.titleLabel?.numberOfLines = 2
        btnAgents.viewCorner(8)
        
        btnCustomers.setTitleColor(Asset.Colors.blackColor.color, for: .normal)
        btnCustomers.setTitle("Customer Analytics".localized(), for: .normal)
        btnCustomers.viewCorner(8)
        
        btnOverAll.backgroundColor = Asset.Colors.lightBlue.color
        btnOverAll.setTitleColor(Asset.Colors.whiteColor.color, for: .normal)
        btnOverAll.setTitle("Over All".localized(), for: .normal)
        btnOverAll.viewCorner(8)
        
        
        proposalSharedView.viewCorner(8)
        contractSharedView.viewCorner(8)
        totalAmountSharedView.viewCorner(8)
        totalIncomeSharedView.viewCorner(8)
        
        self.lblProposalShared.text = "Proposal Shared".localized()
        self.lblContractSigned.text = "Contract Signed".localized()
        self.lblTotalamount.text = "Total Amount".localized()
        self.lblTotalincome.text = "Total Income".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        setUpStartDateEndDate()
      
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
      
  
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        
        let param :[String:Any] = [  "entityType": entityType,
                                     "entityId": partnerID,
                                     "startDate": startDate,
                                     "endDate": endDate
        ]
        searchCoverVM.searchCoverListApi(param: param)
        
    }
    
    func setUpStartDateEndDate(){
        
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
  
 
            components.month = -1
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: components, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = Date()
       // print(datePicker.minimumDate)
        //print(datePicker.maximumDate)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        startDate = "\(formatter.string(from: datePicker.minimumDate!))"
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd.MM.yyyy"
        textStartDate.text = formatter1.string(from: datePicker.minimumDate!)
        

        let formatter12 = DateFormatter()
        formatter12.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        endDate = "\(formatter.string(from: datePicker.date))"
        
        let formatter123 = DateFormatter()
        formatter123.dateFormat = "dd.MM.yyyy"
        textEndDate.text = formatter123.string(from: datePicker.date)
        
//        print(endDate,startDate)
//        self.ApiCallingFunc(state: "POLICY_CREATED")

    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    
    func setOverAllBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnOverAll.viewCorner(8)
        btnOverAll.backgroundColor = backgroundColor
        btnOverAll.setTitleColor(titleColor, for: .normal)
    }
    func setCustomerBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnCustomers.viewCorner(8)
        btnCustomers.backgroundColor = backgroundColor
        btnCustomers.setTitleColor(titleColor, for: .normal)
    }
    func setAgentBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnAgents.viewCorner(8)
        btnAgents.backgroundColor = backgroundColor
        btnAgents.setTitleColor(titleColor, for: .normal)
    }
    func setAnalysisBtnUI(backgroundColor: UIColor, titleColor:UIColor)
    {
        btnAnalysis.viewCorner(8)
        btnAnalysis.backgroundColor = backgroundColor
        btnAnalysis.setTitleColor(titleColor, for: .normal)
    }
    
    
    @IBAction func btnOverAllAction(_ sender: UIButton) {
        overAllView.isHidden = false
        tableView.isHidden = true
        selectAgentType = "overAll"

//        textEndDate.text = ""
//        textStartDate.text = ""
//        startDate = ""
//        endDate = ""
        catName = ""
        subCatName = ""
        
        setOverAllBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
        setAgentBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setCustomerBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setAnalysisBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        
        
        let param :[String:Any] = [  "entityType": entityType,
                                     "entityId": partnerID,
                                     "startDate": startDate,
                                     "endDate": endDate
        ]
        searchCoverVM.searchCoverListApi(param: param)
    }
    
    @IBAction func btnCustomersAction(_ sender: UIButton) {
        
        overAllView.isHidden = true
        tableView.isHidden = false
        selectAgentType = "customer"
//        textEndDate.text = ""
//        textStartDate.text = ""
//        startDate = ""
//        endDate = ""
        catName = ""
        subCatName = ""
        
        agentListArr.removeAll()
        analysisList.removeAll()
        customerListArr.removeAll()

        
        setCustomerBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
        setAgentBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setOverAllBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setAnalysisBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
        
        let param :[String:Any] = [  "entityType": entityType,
                                     "entityId": partnerID,
                                     "startDate": startDate,
                                     "endDate": endDate
        ]
        searchCoverVM.searchCoverCustomers(param: param)
    }
    
    
    @IBAction func btnAgentsAction(_ sender: UIButton) {
        overAllView.isHidden = true
        tableView.isHidden = false
        selectAgentType = "agent"
//        textEndDate.text = ""
//        textStartDate.text = ""
//        startDate = ""
//        endDate = ""
        catName = ""
        subCatName = ""
        
        agentListArr.removeAll()
        analysisList.removeAll()
        customerListArr.removeAll()
        
        setAgentBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
        setCustomerBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setOverAllBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setAnalysisBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
        
    
        let param :[String:Any] = [  "entityType": entityType,
                                     "entityId": partnerID,
                                     "startDate": startDate,
                                     "endDate": endDate
        ]
        searchCoverVM.searchCoverAgents(param: param)
    }
    
    
    @IBAction func btnAnalysisAction(_ sender: UIButton) {
      
        agentListArr.removeAll()
        analysisList.removeAll()
        customerListArr.removeAll()
        catName = ""
        subCatName = ""
        
        overAllView.isHidden = true
        tableView.isHidden = false
        selectAgentType = "analysis"
//        textEndDate.text = ""
//        textStartDate.text = ""
//        startDate = ""
//        endDate = ""
        
        setAnalysisBtnUI(backgroundColor: Asset.Colors.lightBlue.color, titleColor: Asset.Colors.whiteColor.color)
        setCustomerBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setOverAllBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
        setAgentBtnUI(backgroundColor: Asset.Colors.grayColor.color, titleColor: Asset.Colors.blackColor.color)
   
 
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String
        
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
    
        let param :[String:Any] = [  "entityType": entityType,
                                     "entityId": partnerID,
                                     "categoryId": "",
                                     "subCategoryId": "",
                                     "startDate": startDate,
                                     "endDate": endDate
        ]
        searchCoverVM.searchCoverAnalysisList(param: param)
     
    }
    
    
    
    
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended writing")
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
        
        // let currentDate = Date()
        var components = DateComponents()
        var comps = DateComponents()
        // components.calendar = calendar
        
        
        if name == "end"{
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
        
        
        textStartDate.inputView = datePicker
        textStartDate.inputAccessoryView = toolbar
        
        textEndDate.inputView = datePicker
        textEndDate.inputAccessoryView = toolbar
        
        
    }
    
    
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if textStartDate.isEditing == true {
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            textStartDate.text = formatter1.string(from: datePicker.date)
            
            
            if !textEndDate.text!.isEmpty {
                startDate = "\(formatter.string(from: datePicker.date))"
                callingApiOnClickDone ()
            }
            
            
        }
        else {
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            textEndDate.text = formatter1.string(from: datePicker.date)
        
            if !textStartDate.text!.isEmpty {
                endDate =  "\(formatter.string(from: datePicker.date))"
                callingApiOnClickDone ()
            }
            
        }
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func onClickSubCat(_ sender: UIButton) {
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            for cat in subcategoryList {
                let action = UIAlertAction(title: cat.subCategoryName, style: .default) { (action) in

                    self.subCatId = cat.subCategoryId ?? ""
                    self.subCatName = cat.subCategoryName ?? ""
                    
                    let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String

                    let param :[String:Any] = [  "entityType": "PARTNER_ID",
                                                 "entityId": partnerID,
                                                 "categoryId": self.catId,
                                                 "subCategoryId": self.subCatId,
                                                 "startDate": self.startDate,
                                                 "endDate": self.endDate
                    ]
                    self.searchCoverVM.searchCoverAnalysisList(param: param)
                    

              }

//              let icon = UIImage.init(named: cat.icon)

//              action.setValue(icon, forKey: "image")
              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            }

            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickCat(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for cat in categoryListNewData {
            
            
            let action = UIAlertAction(title: cat.categoryName, style: .default) { (action) in
                
                self.catId = cat.categoryId ?? ""
                self.catName = cat.categoryName ?? ""
                let dispatchGroup = DispatchGroup()
                
                dispatchGroup.enter()
                let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String

                let param :[String:Any] = [  "entityType": "PARTNER_ID",
                                             "entityId": partnerID,
                                             "categoryId": self.catId,
                                             "subCategoryId": "",
                                             "startDate": self.startDate,
                                             "endDate": self.endDate
                ]
                self.searchCoverVM.searchCoverAnalysisList(param: param)
                dispatchGroup.leave()
                
                dispatchGroup.enter()
                let userType = kUserDefaults.value(forKey: AppKeys.userType)
                let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                if userType as! String == "AGENT"{
                    
                    let param :[String:Any]  = ["agentId":PartnerId, "categoryId": self.catId]
                    self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)

                }else{
                    //                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "searchBy": ""]
                    let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                    self.subCategoryViewModel.subCatListApi(param: subCatParam)
                }
                dispatchGroup.leave()
            }
     

//              let icon = UIImage.init(named: cat.icon)

//              action.setValue(icon, forKey: "image")
              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            }

            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    
    
    func callingApiOnClickDone () {
        
        let partnerID = kUserDefaults.value(forKey:AppKeys.partnerID) as! String

        let param :[String:Any] = [  "entityType": "PARTNER_ID",
                                     "entityId": partnerID,
                                     "startDate": startDate,
                                     "endDate": endDate
        ]
        if selectAgentType == "agent" {
            searchCoverVM.searchCoverAgents(param: param)
        } else if selectAgentType == "customer" {
            searchCoverVM.searchCoverCustomers(param: param)
        }else if selectAgentType == "overAll" {
            searchCoverVM.searchCoverListApi(param: param)
        }
    }
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == textStartDate {
            showDatePicker(name:"start")
            return true
        }
        if textField == textEndDate {
            
            showDatePicker(name:"end")
            return true
        }
        return true
        
    }
   
    
    
    
    func setCategoryListByAgent(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListNewData.removeAll()

            self.categoryListNewData = data.data?.categoryList ?? []
            
        }
        else {
            DispatchQueue.main.async {
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
    
  
    
    
}

extension SearchCoverVC : subCategoryListProtocolDelegate , subCategoryListByAgentProtocolDelegate{
    
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

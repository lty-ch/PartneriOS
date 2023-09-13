//
//  ThirdViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/05/23.
//

import UIKit
import DropDown

class ThirdViewController: UIViewController {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var agentBtn: UIButton!
    @IBOutlet weak var nextBtnStackView: UIStackView!
    @IBOutlet weak var doneStackView: UIStackView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet weak var insuranceProductLbl: UILabel!
    @IBOutlet weak var chooseAgentLbl: UILabel!
    @IBOutlet weak var periodictyLbl: UILabel!
    @IBOutlet weak var premiumAmountLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var subCategoryTxt: UITextField!
    @IBOutlet weak var insuranceProductTxt: UITextField!
    @IBOutlet weak var chooseAgentTxt: UITextField!
    @IBOutlet weak var periodicityTxt: UITextField!
    @IBOutlet weak var PremiumAmountTxt: UITextField!
    @IBOutlet weak var totalAmountTxt: UITextField!
    
    var isComingFrom = ""
    var selectedProductsArr = NSMutableArray()
    let categoryDropDown = DropDown()
    let categoryDropDownItem = ["Not Selected".localized()]
    
    let subCategoryDropDown = DropDown()
    let subCategoryDropDownItem = ["Not Selected".localized()]
    
    let insuranceProductDropDown = DropDown()
    let insuranceProductDropDownItem = ["Not Selected".localized()]
     
    let chooseAgentDropDown = DropDown()
    let chooseAgentDropDownItem = ["Not Selected".localized()]
    
    let periodicityDropDown = DropDown()
    let periodicityDropDownItem = ["Month".localized(),"Quarter".localized(),"Semester".localized(),"Year".localized()]
    
    var categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    var categoryListNewData = [MainCategoryNewList]()
    var subCategoryViewModel = SubCatagoryViewModel()
    var subcategoryList = [SubCategoryDataList]()
    
    var addProposalViewModel = AddProposalViewModel()
    var agentList = [AddProposalAgentAgentList]()
    
//    var selectCatVM = SelectCatViewModel()
//    var maincatArr = [CategoryList]()
//    var subcatArr = [SubCategoryAndProductList]()
//    var productListArr = [ProductList]()
    var catId = ""
    var subcatId = ""
    var productId = ""
    var agentId = ""
    var categoryName = ""
    var categoryNameInFrench = ""
    var subCategoryName = ""
    var subCategoryNameInFrench = ""
    let periodicityArr = [["Month".localized(), "12"],["Quarter".localized(), "4"],["Semester".localized(), "2"],["Year".localized(), "1"]]
   var catDic = NSMutableDictionary()
    var periodictyFactor = 0.0
    var delegate : updateProposalData?
    var updateDelegate : updateProposalEditDataFromMainListing?
    var shouldAddLead = false
    var agentName = ""
    var productsToSendInAPIArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizationText()
        categoryDropDown.anchorView = categoryTxt
        categoryDropDown.dataSource = categoryDropDownItem
        categoryDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.categoryTxt.text = categoryDropDownItem[Index]
        }
        
        subCategoryDropDown.anchorView = subCategoryTxt
        subCategoryDropDown.dataSource = subCategoryDropDownItem
        subCategoryDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.subCategoryTxt.text = subCategoryDropDownItem[Index]
        }
        
        insuranceProductDropDown.anchorView = insuranceProductTxt
        insuranceProductDropDown.dataSource = insuranceProductDropDownItem
        insuranceProductDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.insuranceProductTxt.text = insuranceProductDropDownItem[Index]
        }
        
        chooseAgentDropDown.anchorView = chooseAgentTxt
        chooseAgentDropDown.dataSource = chooseAgentDropDownItem
        chooseAgentDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.chooseAgentTxt.text = chooseAgentDropDownItem[Index]
        }
        
        periodicityDropDown.anchorView = periodicityTxt
        periodicityDropDown.dataSource = periodicityDropDownItem
        periodicityDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.periodicityTxt.text = periodicityDropDownItem[Index]
        }
        
        categoryViewModel.delegate = self
        categoryViewModel.categoryListByAgentDelegate = self
        
        let comingFromLead = UserDefaults.standard.value(forKey: "fromLead")
        if comingFromLead as! String == "yes"{
            if self.agentId == "" {
                let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                let param :[String:Any]  = ["partnerId":PartnerId]
                categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)
            } else {
                let param :[String:Any]  = ["agentId":self.agentId]
                categoryViewModel.getCatByAgent(param: param, url: LTY_END_POINT_URL.getCategoryByAgent)
            }
            
            
            if self.catId != ""{
                //                    let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
                //                    self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                self.subCategoryViewModel.subCatListApi(param: subCatParam)
            }
            
        } else {
            let userType = kUserDefaults.value(forKey: AppKeys.userType)
            let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
            let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
            if userType as! String == "AGENT"{
                
                self.chooseAgentTxt.text = kUserDefaults.value(forKey: AppKeys.agentName) as? String
                self.agentId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
                addProposalDic.setValue(self.chooseAgentTxt.text, forKey: "agentName")
                
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
                let param :[String:Any]  = ["partnerId":PartnerId]
                categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)
                if self.catId != "" {
                    let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                    self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    
                }
            }
        }
        
        
        
        
        
        
        subCategoryViewModel.delegate = self
        subCategoryViewModel.subCategoryListByAgentDelegate = self
        //        let param :[String:Any]  = ["partnerId":partnerId,"categoryId":self.catId]
        
        
        addProposalViewModel.delegate = self
        addProposalViewModel.activeUsersDelegate = self
        
    }
    func setLocalizationText() {
        self.btnDone.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.setTitle("Next".localized(), for: .normal)
        self.lblTitle.text = "Type of product".localized()
        self.categoryLbl.text = "Insurance Company".localized()
        self.subCategoryLbl.text = "Insurance Branch".localized()
        self.insuranceProductLbl.text = "Insurance Coverage".localized()
        self.chooseAgentLbl.text = "Choose Agent".localized()
        self.periodictyLbl.text = "Periodicity:".localized()
        self.premiumAmountLbl.text = "Premium Amount".localized()
        self.totalAmountLbl.text = "Total Amount".localized()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        if isComingFrom == "LeadProposalVC" || self.shouldAddLead {
//            self.agentBtn.isUserInteractionEnabled = false
            self.chooseAgentTxt.text = self.agentName
            addProposalDic.setValue(self.agentName, forKey: "agentName")
        } else {
//            self.agentBtn.isUserInteractionEnabled = true
            
        }
        
        if isComingFrom == "EditVC" || isComingFrom == "ProposalVC" || isComingFrom == "LeadProposalVC" || isComingFrom == "ForEditProposal" {
            setData()
            doneStackView.isHidden = false
            nextBtnStackView.isHidden = true
        }else {
            doneStackView.isHidden = true
            nextBtnStackView.isHidden = false
        }
        setAgentselection()
        self.tabBarController?.tabBar.isHidden = true
//        let partnerId =  kUserDefaults.string(forKey: "partnerID")
//        let param :[String:Any]  = ["searchBy":""]
//        categoryViewModel.productCommissionListApi(param: param, url: LTY_END_POINT_URL.getCategory)
        
        
    }
    
    func setAgentselection(){
        if isComingFrom == "ProposalVC"{
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            if userType == "AGENT" {
                agentBtn.isUserInteractionEnabled = false
            } else {
                agentBtn.isUserInteractionEnabled = true
            }
            
        }else if isComingFrom == ""{
            let userType = kUserDefaults.value(forKey: AppKeys.userType)
            if userType as! String == "AGENT"{
                agentBtn.isUserInteractionEnabled = false
                self.chooseAgentTxt.text = self.agentName
                addProposalDic.setValue(self.agentName, forKey: "agentName")
            }else {
                agentBtn.isUserInteractionEnabled = true
            }
            
        }else if isComingFrom == "ForEditProposal"{
            agentBtn.isUserInteractionEnabled = false
        }
        
        let comingFromLead = UserDefaults.standard.value(forKey: "fromLead")
        if comingFromLead as! String == "yes"{
            agentBtn.isUserInteractionEnabled = false

        }
    }
    
 
    func setData() {
        let catDetails = addProposalDic["categoryDetails"] as! NSMutableDictionary
        
        self.subcatId = catDetails["subCategoryId"] as! String
        self.catId = catDetails["categoryId"] as! String
        
        self.categoryTxt.text = catDetails["categoryName"] as? String
        self.subCategoryTxt.text = catDetails["subCategoryName"] as? String
       // self.insuranceProductTxt.text = catDetails["categoryName"] as? String
        self.chooseAgentTxt.text = addProposalDic["agentName"] as? String
        self.agentId = addProposalDic["agentId"] as? String ?? ""
        self.PremiumAmountTxt.text = addProposalDic["premiumAmount"] as? String
        self.totalAmountTxt.text = addProposalDic["totalAmount"] as? String
        self.periodicityTxt.text = addProposalDic["periodicity"] as? String
        
        let productDetails = addProposalDic["productDetails"] as! NSMutableDictionary
        let prodList = productDetails["productList"] as! NSMutableArray
        self.selectedProductsArr = prodList
        self.productsToSendInAPIArr = prodList
        var arr = NSMutableArray()
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray

        for items in prodList {
            let item = items as! NSMutableDictionary
            
            if result[0] as! String == "fr" {
                arr.add(item["productNameInFrench"] ?? "")
            }else{
                arr.add(item["productName"] ?? "")
            }
          
        }
        
    
        self.insuranceProductTxt.text = arr.componentsJoined(by: ",")
        

        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        let agentParam :[String:Any]  = ["partnerId":partnerId, "categoryId":self.catId, "subCategoryId":self.subcatId]
        self.addProposalViewModel.addProposalAgentListApi(param: agentParam)
        
    }
    
    @IBAction func onClickCategory(_ sender: Any) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            for cat in categoryListNewData{
                
                
                let action = UIAlertAction(title: cat.categoryNameInFrench, style: .default) { (action) in
                    
                    self.insuranceProductTxt.text = ""
                    
                    self.subCategoryTxt.text = ""
                    
                    if shouldEditMembers {
                        self.selectedProductsArr.removeAllObjects()
                        self.catDic.setValue("", forKey: "categoryId")
                        self.catDic.setValue("", forKey: "categoryName")
                        self.catDic.setValue("", forKey: "categoryNameInFrench")
                        self.catDic.setValue("", forKey: "subCategoryId")
                        self.catDic.setValue("", forKey: "subCategoryName")
                        self.catDic.setValue("", forKey: "subCategoryNameInFrench")
                        
                        let dic = NSMutableDictionary()
                        addProposalDic.setValue(dic, forKey: "productDetails")
                    }
                    
                    
                    if self.isComingFrom != "EditVC" {
                        self.subCategoryTxt.text = ""
                        
                        self.catId = cat.categoryId ?? ""
                        self.subCategoryTxt.text = ""
                        let userType = kUserDefaults.value(forKey: AppKeys.userType)

                        
                        
    //                    if userType as! String != "AGENT" {
    //                        self.chooseAgentTxt.text = ""
    //                        self.agentId = ""
    //                        addProposalDic.setValue("", forKey: "agentName")
    //                    }
                        
                    }
                    self.categoryNameInFrench = cat.categoryNameInFrench ?? ""
                    self.categoryName = cat.categoryName ?? ""

                    self.categoryTxt.text = cat.categoryNameInFrench ?? ""
                    
                    let comingFromLead = UserDefaults.standard.value(forKey: "fromLead")
                    if comingFromLead as! String == "yes"{
    //                    let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
    //                    self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                        let userType = kUserDefaults.value(forKey: AppKeys.userType)
                        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                        if userType as! String == "AGENT" {
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": sourceId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        } else {
                            let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        }
                    } else {
    //                    self.chooseAgentTxt.text = ""
    //                    self.agentId = ""
    //                    addProposalDic.setValue("", forKey: "agentName")
                        self.subCategoryTxt.text = ""
                        
                        self.catId = cat.categoryId ?? ""
                        self.subCategoryTxt.text = ""
                        
                        let userType = kUserDefaults.value(forKey: AppKeys.userType)
                        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                        if userType as! String == "AGENT"{
                            
    //                        let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
    //                        self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": sourceId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        }else{
                            if shouldEditMembers {
                                self.chooseAgentTxt.text = ""
                                self.agentId = ""
                                addProposalDic.setValue("", forKey: "agentName")
                            }
                            
                            
                            //                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "searchBy": ""]
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        }
                        
                        
                    }
                    
                    

              }

    //              let icon = UIImage.init(named: cat.icon)

    //              action.setValue(icon, forKey: "image")
                  action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

                  actionSheetAlertController.addAction(action)
                }
        }else{
            
            for cat in categoryListNewData {
                
                
                let action = UIAlertAction(title: cat.categoryName, style: .default) { (action) in
                    
                    self.insuranceProductTxt.text = ""
                    
                    self.subCategoryTxt.text = ""
                    
                    
                    if shouldEditMembers {
                        self.selectedProductsArr.removeAllObjects()
                        self.catDic.setValue("", forKey: "categoryId")
                        self.catDic.setValue("", forKey: "categoryName")
                        self.catDic.setValue("", forKey: "categoryNameInFrench")
                        self.catDic.setValue("", forKey: "subCategoryId")
                        self.catDic.setValue("", forKey: "subCategoryName")
                        self.catDic.setValue("", forKey: "subCategoryNameInFrench")
                        
                        let dic = NSMutableDictionary()
                        addProposalDic.setValue(dic, forKey: "productDetails")
                    }
                    
                    
                    if self.isComingFrom != "EditVC" {
                        self.subCategoryTxt.text = ""
                        
                        self.catId = cat.categoryId ?? ""
                        self.subCategoryTxt.text = ""
                        let userType = kUserDefaults.value(forKey: AppKeys.userType)
                        
                        
                        
                        //                    if userType as! String != "AGENT" {
                        //                        self.chooseAgentTxt.text = ""
                        //                        self.agentId = ""
                        //                        addProposalDic.setValue("", forKey: "agentName")
                        //                    }
                        
                    }
                    self.categoryNameInFrench = cat.categoryNameInFrench ?? ""
                    self.categoryName = cat.categoryName ?? ""
                    self.categoryTxt.text = cat.categoryName ?? ""
                    
                    let comingFromLead = UserDefaults.standard.value(forKey: "fromLead")
                    if comingFromLead as! String == "yes"{
                        //                    let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
                        //                    self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                        let userType = kUserDefaults.value(forKey: AppKeys.userType)
                        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                        if userType as! String == "AGENT" {
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": sourceId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        } else {
                            let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        }
                    } else {
                        //                    self.chooseAgentTxt.text = ""
                        //                    self.agentId = ""
                        //                    addProposalDic.setValue("", forKey: "agentName")
                        self.subCategoryTxt.text = ""
                        
                        self.catId = cat.categoryId ?? ""
                        self.subCategoryTxt.text = ""
                        
                        let userType = kUserDefaults.value(forKey: AppKeys.userType)
                        let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
                        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                        if userType as! String == "AGENT"{
                            
                            //                        let param :[String:Any]  = ["agentId":self.agentId, "categoryId": self.catId]
                            //                        self.subCategoryViewModel.getSubCatByAgent(param: param, url: LTY_END_POINT_URL.getSubCategoryByAgent)
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": sourceId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        }else{
                            if shouldEditMembers {
                                self.chooseAgentTxt.text = ""
                                self.agentId = ""
                                addProposalDic.setValue("", forKey: "agentName")
                            }
                            
                            
                            //                        let subCatParam :[String:Any]  = ["categoryId":self.catId, "searchBy": ""]
                            let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                            self.subCategoryViewModel.subCatListApi(param: subCatParam)
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                //              let icon = UIImage.init(named: cat.icon)
                
                //              action.setValue(icon, forKey: "image")
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)

    }
    
    
    @IBAction func onClickSubCategory(_ sender: Any) {
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            
            for cat in subcategoryList{
                
                let action = UIAlertAction(title: cat.subCategoryNameInFrench, style: .default) { (action) in
                    
                    self.subCategoryNameInFrench = cat.subCategoryNameInFrench ?? ""
                    self.subCategoryName = cat.subCategoryName ?? ""
                    
                    self.subCategoryTxt.text = cat.subCategoryNameInFrench ?? ""
                    self.subcatId = cat.subCategoryId ?? ""
                    
                    let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                    let agentParam :[String:Any]  = ["partnerId":partnerId, "categoryId":self.catId, "subCategoryId":self.subcatId]
                    print(agentParam)
                    self.addProposalViewModel.addProposalAgentListApi(param: agentParam)
                }

                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }else {
            
            for cat in subcategoryList {
                let action = UIAlertAction(title: cat.subCategoryName, style: .default) { (action) in
                    
                    self.subCategoryNameInFrench = cat.subCategoryNameInFrench ?? ""
                    self.subCategoryName = cat.subCategoryName ?? ""
                    
                    self.subCategoryTxt.text = cat.subCategoryName ?? ""
                    self.subcatId = cat.subCategoryId ?? ""
                    
                    let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
                    let agentParam :[String:Any]  = ["partnerId":partnerId, "categoryId":self.catId, "subCategoryId":self.subcatId]
                    print(agentParam)
                    self.addProposalViewModel.addProposalAgentListApi(param: agentParam)
                }
                
                //              let icon = UIImage.init(named: cat.icon)
                
                //              action.setValue(icon, forKey: "image")
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickInsuranceProduct(_ sender: Any) {
        
        if self.categoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Company first.".localized())
            return
        } else if self.subCategoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Branch first.".localized())
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
    
    

    @IBAction func onClickChooseAgent(_ sender: Any) {
        
   
        if self.categoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Company first.".localized())
            return
        } else if self.subCategoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Branch first.".localized())
            return
        }
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for cat in agentList {
            
            
            let action = UIAlertAction(title: cat.agentName, style: .default) { (action) in
                
                let partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) ?? ""
                self.chooseAgentTxt.text = cat.agentName ?? ""
                self.agentId = cat.agentId ?? ""
                addProposalDic.setValue(cat.agentName ?? "", forKey: "agentName")

                var emptyArr = NSMutableArray()
                if self.isComingFrom == "EditVC" {
                    addProposalDic.setValue(emptyArr, forKey: "memberId")
                    addProposalDic.setValue(emptyArr, forKey: "memberNames")
                    addProposalDic.setValue("", forKey: "policyVisibility")
                    
                }
                let param: [String: Any] = ["agentId": self.agentId,"partnerId": partnerId, "searchBy": ""]
                self.addProposalViewModel.getActiveUsers(param: param)

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
    
    @IBAction func onClickPeriodicity(_ sender: Any) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for cat in periodicityArr {
            
            
            let action = UIAlertAction(title: cat[0], style: .default) { (action) in
                
                self.periodicityTxt.text = cat[0]
                self.periodictyFactor = Double(Int(cat[1]) ?? Int(1.0))
                
                if !self.totalAmountTxt.text!.isEmpty {
                    let total = Double(self.totalAmountTxt.text!) ?? 0.0
                    let prmAmt = total/self.periodictyFactor
                    let y = Double(round(100 * prmAmt) / 100)
                    self.PremiumAmountTxt.text = "\(y)"
                }

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
    
    
    @IBAction func onClickPremiumAmount(_ sender: Any) {
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
   
        if self.categoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Company ".localized())
            return
        } else if self.subCategoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Branch ".localized())
            return
        } else if self.insuranceProductTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Coverage.".localized())
            return
        } else if self.periodicityTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select periodicity.".localized())
            return
        } else if self.PremiumAmountTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter premium amount.".localized())
            return
        } else if self.totalAmountTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter toal amount.".localized())
            return
        }
        
        self.catDic.setValue(self.catId, forKey: "categoryId")
        self.catDic.setValue(self.categoryName, forKey: "categoryName")
        self.catDic.setValue(self.categoryNameInFrench, forKey: "categoryNameInFrench")
        self.catDic.setValue(self.subcatId, forKey: "subCategoryId")
        self.catDic.setValue(self.subCategoryName, forKey: "subCategoryName")
        self.catDic.setValue(self.subCategoryNameInFrench, forKey: "subCategoryNameInFrench")
        
        addProposalDic.setValue(self.periodicityTxt.text!, forKey: "periodicity")
        addProposalDic.setValue(self.PremiumAmountTxt.text!, forKey: "premiumAmount")
        addProposalDic.setValue(self.totalAmountTxt.text!, forKey: "totalAmount")
        addProposalDic.setValue(self.catDic, forKey: "categoryDetails")
        addProposalDic.setValue(self.agentId, forKey: "agentId")
        
        
        let dic = NSMutableDictionary()
        dic.setValue(self.productsToSendInAPIArr, forKey: "productList")
        addProposalDic.setValue(dic, forKey: "productDetails")
        
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "FourthViewController") as! FourthViewController
        self.navigationController?.pushViewController(next , animated: true)

    }
    
    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        
        if self.categoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Company.".localized())
            return
        } else if self.subCategoryTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Branch.".localized())
            return
        } else if self.insuranceProductTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select Insurance Coverage.".localized())
            return
        } else if self.periodicityTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select periodicity.".localized())
            return
        } else if self.PremiumAmountTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter premium amount.".localized())
            return
        } else if self.totalAmountTxt.text!.isEmpty {
            self.ShowAlert(message: "Please enter toal amount.".localized())
            return
        }
        
        self.catDic.setValue(self.catId, forKey: "categoryId")
        self.catDic.setValue(self.categoryTxt.text!, forKey: "categoryName")
        self.catDic.setValue(self.subcatId, forKey: "subCategoryId")
        self.catDic.setValue(self.subCategoryTxt.text!, forKey: "subCategoryName")
        
        addProposalDic.setValue(self.periodicityTxt.text!, forKey: "periodicity")
        addProposalDic.setValue(self.PremiumAmountTxt.text!, forKey: "premiumAmount")
        addProposalDic.setValue(self.totalAmountTxt.text!, forKey: "totalAmount")
        addProposalDic.setValue(self.catDic, forKey: "categoryDetails")
        addProposalDic.setValue(self.agentId, forKey: "agentId")
        
        let dic = NSMutableDictionary()
        dic.setValue(self.productsToSendInAPIArr, forKey: "productList")
        addProposalDic.setValue(dic, forKey: "productDetails")

        
        navigationController?.popViewControllerWithHandler(animated: true, completion: {
            if self.isComingFrom == "EditVC" {
                self.delegate?.updateData()
            } else {
                self.updateDelegate?.updateEditedDataFromMainListing()
            }
        })
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)
    }
    @IBAction func backActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    
}

extension ThirdViewController : CategoryListProtocolDelegate, CategoryListByAgentProtocolDelegate, ActiveUsersProtocolDeleagte {
    
    func setCategoryListByAgent(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListNewData.removeAll()

           // self.categoryListNewData = data.data?.categoryList ?? []
            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
            let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                self.categoryListNewData = data.data?.categoryList ?? []

            }else{
                self.categoryListNewData = data.data?.categoryList ?? []

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
   
    func setCategoryList(data: CategoryModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()
            
            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
            let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                self.categoryListData = data.data?.categoryList ?? []
            }else{
                self.categoryListData = data.data?.categoryList ?? []
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
    
    
    func setCategoryNewList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()

           // self.categoryListNewData = data.data?.categoryList ?? []
            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
            let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                self.categoryListNewData = data.data?.categoryList ?? []
            }else{
                self.categoryListNewData = data.data?.categoryList ?? []

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
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
        
    }
    
    func setActiveUsersList(data: AddProposalMembersModel) {
        
        if data.status == "SUCCESS" {
            
            
            var memberList = data.data?.usersList ?? []
            if memberList.count == 0 {
                self.showOkAlert("This Agent does not have members associated. You can't proceed with proposal creation. Please select any other Agent.")
            }
            
        } else {
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

extension ThirdViewController : subCategoryListProtocolDelegate , subCategoryListByAgentProtocolDelegate , AllCatProtocolDelegate{
    
    func setAllCategoryList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListNewData.removeAll()

                let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                let result = language as! NSArray
                
                if result[0] as! String == "fr" {
                    self.categoryListNewData = data.data?.categoryList ?? []
                }else{
                    self.categoryListNewData = data.data?.categoryList ?? []
                    
                }
          //  self.categoryListNewData = data.data?.categoryList ?? []
            
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
            
            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
            let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                self.subcategoryList = data.data?.subCategoryList ?? []

            }else{
                self.subcategoryList = data.data?.subCategoryList ?? []

            }

           // self.subcategoryList = data.data?.subCategoryList ?? []

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
            
            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
            let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                self.subcategoryList = data.data?.subCategoryList ?? []

            }else{
                self.subcategoryList = data.data?.subCategoryList ?? []
                
            }
            
          //  self.subcategoryList = data.data?.subCategoryList ?? []

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

extension ThirdViewController : AddPropsalAgentListProtocolDelegate, AgentProductAmountDelegate {
    
    func setProductAmountData(arr: NSMutableArray, nameArr: NSMutableArray) {
        
//        let dic = NSMutableDictionary()
//        dic.setValue(arr, forKey: "productList")
//        addProposalDic.setValue(dic, forKey: "productDetails")
        self.getSelectedProductNames(arr: arr)
      
        let total = self.calculateTotalAmount(arr: arr)
        self.totalAmountTxt.text = "\(total)"
        self.periodicityTxt.text = ""
        self.periodictyFactor = 0.0
        self.PremiumAmountTxt.text = ""
        
    }
    
    func getSelectedProductNames(arr: NSMutableArray) {
        
    print(arr)
        self.selectedProductsArr.removeAllObjects()
//        self.selectedProductsArr = arr
        var productNamesArr = NSMutableArray()
        var productsArr = NSMutableArray()
        productsToSendInAPIArr.removeAllObjects()
        productsArr.removeAllObjects()
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        for items in arr {
            let item = items as! NSMutableDictionary
            if item["isSelected"] as! String == "yes" {
                
                if result[0] as! String == "fr" {
                    productNamesArr.add(item["productNameInFrench"] as! String)
                    
                }else{
                    productNamesArr.add(item["productName"] as! String)
                    
                }
                
                
                // productsToSendInAPIArr.add(item)
                productsArr.add(item)
                self.selectedProductsArr.add(item)
            }
        }
        productsToSendInAPIArr = productsArr
        // create products arr to send in API
        
        
        // Set selected products data in Tf
        let stringRepresentation = productNamesArr.componentsJoined(by: ",")
        self.insuranceProductTxt.text = stringRepresentation
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

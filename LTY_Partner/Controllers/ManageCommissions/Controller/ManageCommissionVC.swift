//
//  ManageCommissionVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 23/05/23.
//

import UIKit

class ManageCommissionVC: UIViewController {
    

    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavigationDrower: CustomNavigationBarForDrawer!
  //  var agentListData = [AgentsList]()
    var customerAgentArr = [CustomerActiveAgentsList]()
    var customerVm = CustomerViewModel()
    
    var catagoryList = [MainCategoryNewList]()
    var subcategoryList = [SubCategoryDataList]()
    var subCatList = [SubCategoryAndProductList]()
    var productListArr = [ProductList]()
    
    var selectCatVM = SelectCatViewModel()
    var manageCommessionViewModel = ManageCommessionViewModel()
    var agentId = ""
    var catId = ""
    var subcatId = ""
    var categoryName = ""
    var categoryNameInFrench = ""
    var categoryViewModel = CategoryViewModel()
    var subCategoryViewModel = SubCatagoryViewModel()
    
    
// MARK:- Outlets
    @IBOutlet weak var textAgentType: CustomTextField!
 
    @IBOutlet weak var txtselectSubCatagory: CustomTextField!
    @IBOutlet weak var txtSelectCatagory: CustomTextField!
    
    @IBOutlet weak var txtAgentReserve: CustomTextField!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var txtCompREserve: CustomTextField!
    
    @IBOutlet weak var txtAgentCommession: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        doneBtn.viewCorner(8)
        doneBtn.isUserInteractionEnabled = true
        
        manageCommessionViewModel.delegate = self
        customNavigationDrower.titleLabel.text = "Manage Commission".localized()
        customNavigationDrower.titleLabel.textAlignment = .center
        customNavigationDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigationDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
//        selectCatVM.delegate = self
//        selectCatVM.mainCatListApi(param: ["searchBy": ""])
        let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
        customerVm.delegate = self
        let agentParam:[String:Any] = ["partnerId": PartnerId, "searchBy": ""]
        customerVm.getCustomerActiveAgent(param: agentParam)
        categoryViewModel.delegate = self
        subCategoryViewModel.delegate = self
        
        let param :[String:Any]  = ["partnerId":PartnerId]
        categoryViewModel.productCategoryListApi(param: param, url: LTY_END_POINT_URL.getCategoryNew)
        
        self.txtAgentReserve.text = "10"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

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
    
    @IBAction func onClickAgent(_ sender: UIButton) {
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for item in customerAgentArr {
            let action = UIAlertAction(title: (item.firstName ?? "") + " " + (item.lastName ?? "") , style: .default) { (action) in
                
                self.agentId = item.partnerId ?? ""
                let fName = item.firstName?.capitalized   ?? ""
                let lName = item.lastName?.capitalized   ?? ""
                
                self.textAgentType.text = "\(fName ) \(lName)"
               // self.txtAgentReserve.text = "\(item.commissionDetails?.agentReserve ?? 0.0)"
                self.txtAgentCommession.text = "\(item.commissionDetails?.agentCommission ?? 0.0)"
                self.txtCompREserve.text = "\(item.commissionDetails?.companyReserve ?? 0.0)"
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
        
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            for item in catagoryList {
                let action = UIAlertAction(title: item.categoryNameInFrench, style: .default) { (action) in
                    self.catId = item.categoryId ?? ""
                    self.txtSelectCatagory.text = item.categoryNameInFrench ?? ""
                    self.categoryName = item.categoryName ?? ""
                    self.categoryNameInFrench = item.categoryNameInFrench ?? ""
                    //                    self.extractSubCatAndProductListing(item.categoryId ?? "")
                    let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                    
                    let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                    self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    
                }
                
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }else{
            for item in catagoryList {
                let action = UIAlertAction(title: item.categoryName, style: .default) { (action) in
                    self.catId = item.categoryId ?? ""
                    self.txtSelectCatagory.text = item.categoryName ?? ""
                    self.categoryName = item.categoryName ?? ""
                    self.categoryNameInFrench = item.categoryNameInFrench ?? ""
                    //                    self.extractSubCatAndProductListing(item.categoryId ?? "")
                    let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
                    
                    let subCatParam :[String:Any]  = ["categoryId":self.catId, "partnerId": PartnerId]
                    self.subCategoryViewModel.subCatListApi(param: subCatParam)
                    
                }
                
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
//    func extractSubCatAndProductListing(_ id: String) {
//        for item in catagoryList {
//            if item.categoryId == id {
//                self.subCatList = item.subCategoryAndProductList ?? []
//            }
//        }
//    }
    
    @IBAction func onClickSubCat(_ sender: UIButton) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            
            for item in subcategoryList{
                let action = UIAlertAction(title: item.subCategoryNameInFrench, style: .default) { (action) in
                    self.subcatId = item.subCategoryId ?? ""
                    self.txtselectSubCatagory.text = item.subCategoryNameInFrench ?? ""
                    self.extractProductListing(item.subCategoryId ?? "")
                    
                }
                
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }else{
            
            for item in subcategoryList {
                let action = UIAlertAction(title: item.subCategoryName, style: .default) { (action) in
                    self.subcatId = item.subCategoryId ?? ""
                    self.txtselectSubCatagory.text = item.subCategoryName ?? ""
                    self.extractProductListing(item.subCategoryId ?? "")
                    
                    
                }
                
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    

    func extractProductListing(_ id: String) {
        
        for item in subCatList {
            if item.subCategoryId == id {
                self.productListArr = item.productList ?? []
                break
            }
        }
        
    }
//MARK:- Cancel Action btn
    
    @IBAction func cancelActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
    }
    
    //MARK:- Done Action Btn
    
    @IBAction func doneActionBtn(_ sender: UIButton) {
        checkValidation()
        doneBtn.isUserInteractionEnabled = false

        
    }
    //MARK:- Check Validation
    
    func checkValidation(){
        
        let agentReserve = Int(txtAgentReserve.text ?? "")
        let companyReserve = Int(txtCompREserve.text ?? "")
        let  agentCommission = Int(txtAgentCommession.text ?? "")
        
//        if agentReserve ?? 0 > 99 {
//            self.showMsg(msg: "it should not be greater than 99".localized())
//        }
//
//        else if companyReserve ?? 0 > 99 {
//            self.showMsg(msg: "it should not be greater than 99".localized())
//
//        }
//        else
        if agentCommission ?? 0 > 99 {
            self.showMsg(msg: "it should not be greater than 99".localized())
            
        }
        else {
            checkInternet()
        }
    }
    
    //MARK:- check Internet connection
    
    func checkInternet() {
        if internetConnection.isConnectedToNetwork() == true {
            self.txtAgentReserve.text = "10"
            self.txtCompREserve.text = ""
            
            let param : [String:Any] = ["agentId":self.agentId,"agentName":textAgentType.text,"categoryId":self.catId,"categoryName":self.categoryName ,"categoryNameInFrench":self.categoryNameInFrench,"subCategoryId":self.subcatId,"subCategoryName":"","commissionType":"PERCENTAGE","commissionDetails":["agentReserve":txtAgentReserve.text,"companyReserve":txtCompREserve.text,"agentCommission":txtAgentCommession.text]]
            
            manageCommessionViewModel.addAgentCommission(param:param)
            
            
        }
        else  {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
        }
    }
    
    
}

extension ManageCommissionVC : CategoryListProtocolDelegate {
    
    func popupMsg(msg: String) {
        ShowAlert(message: msg)
    }
    
    
    func setCategoryListByAgent(data: CategoryModel) {
        
//        if data.status == "SUCCESS" {
//            self.categoryListData.removeAll()
//
//            self.categoryListData = data.data?.categoryList ?? []
//
//        }
//        else {
//            DispatchQueue.main.async {
//                self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
//            }
//
//        }
        
      
    }
   
    func setCategoryList(data: CategoryModel) {
        
//        if data.status == "SUCCESS" {
//            self.categoryListData.removeAll()
//
//            self.categoryListData = data.data?.categoryList ?? []
//
//        }
//        else {
//            DispatchQueue.main.async {
//                self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
//            }
//
//        }
        
      
    }
    
    
    func setCategoryNewList(data: CategoryNewModel) {
        
        if data.status == "SUCCESS" {
            self.catagoryList.removeAll()

                self.catagoryList = data.data?.categoryList ?? []

        }
        else {
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

extension ManageCommissionVC : subCategoryListProtocolDelegate {
    
    func setSubCategoryListByAgent(data: SubCategoryModel) {
        if data.status == "SUCCESS" {
            
            self.subcategoryList.removeAll()

                self.subcategoryList = data.data?.subCategoryList ?? []

        }
        else {
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
    
    func setSubCategoryList(data: SubCategoryModel) {
        if data.status == "SUCCESS" {
            
            self.subcategoryList.removeAll()

                self.subcategoryList = data.data?.subCategoryList ?? []

        }
        else {
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

extension ManageCommissionVC: CustomerListProtocolDelegate {
    func setCustomerList(data: CustomerModel) {
        print("")
    }
    
    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        
        if data.status == "SUCCESS" {
            
            self.customerAgentArr = data.data?.agentsList ?? []
            
//            if customerAgentArr.count == 0 {
//                DispatchQueue.main.async {
//
//                    self.noDataFoundView.isHidden = false
//                    self.userListTable.isHidden = true
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.noDataFoundView.isHidden = true
//                    self.userListTable.isHidden = false
//                    self.userListTable.reloadData()
//                }
//            }
        }
        else{
            //self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
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

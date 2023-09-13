//
//  SelectCategoryVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 23/05/23.
//

import UIKit

class SelectCategoryVC: UIViewController , SelectCatProtocolDelegate{
    
    @IBOutlet weak var customNavigationBarForDrawer: CustomNavigationBarForDrawer!
    
    @IBOutlet weak var lblSelectAll: UILabel!
    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var lblHeadingSubCat: UILabel!
    @IBOutlet weak var lblHeadingMainCat: UILabel!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var subCatLbl: UILabel!
    @IBOutlet weak var mainCatLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
 
    var selectCatVM = SelectCatViewModel()
    var maincatArr = [CategoryList]()
    var subcatArr = [SubCategoryAndProductList]()
//    var productListArr = [ProductList]()
    var productListArr = [SelectSubCatProductList]()
    var catId = ""
    var subcatId = ""
    
    var catName = ""
    var catNameInFrench = ""
    var subcatName = ""
    var subcatNameInFrench = ""
//    var newProductArr = [NSMutableDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDrowerHeight()
        setUpView()
       
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        selectCatVM.delegate = self
        selectCatVM.mainCatListApi(param: ["searchBy": ""])
        
        customNavigationBarForDrawer.titleLabel.text = "Add Insurance Coverage".localized()
        lblSelectAll.text = "Select All".localized()
        mainCatLbl.text  = "Insurance Company".localized()
        subCatLbl.text  = "Insurance Product".localized()
        customNavigationBarForDrawer.titleLabel.textAlignment = .center
        customNavigationBarForDrawer.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigationBarForDrawer.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        self.noDataFoundView.isHidden = false
        self.tableView.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }

    //MARK:- setUpView
    
    func setUpView() {
   
        subCatLbl.textColor = Asset.Colors.blueColor.color
        mainCatLbl.textColor = Asset.Colors.blueColor.color
        lblHeadingMainCat.textColor = Asset.Colors.gray1.color
        lblHeadingSubCat.textColor = Asset.Colors.gray1.color
        
        subCatLbl.font = FontSize.size14
        mainCatLbl.font = FontSize.size14
        lblHeadingMainCat.font = FontSize.size16
        lblHeadingSubCat.font = FontSize.size16
        
        lblHeadingMainCat.text = LTYText.text_SelectCat_MainCat.localized()
        lblHeadingSubCat.text = LTYText.text_SelectCat_SubCat.localized()
        
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
    
    @IBAction func onClickMainCategory(_ sender: Any) {
        
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            for cat in maincatArr {
                let action = UIAlertAction(title: cat.categoryInFrench, style: .default) { (action) in
                    self.productListArr.removeAll()
                    if self.subCatLbl.text == "Insurance Product" {
                        self.subCatLbl.text = ""
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    self.mainCatLbl.text = cat.categoryInFrench ?? ""
                    self.catId = cat.categoryId ?? ""
                    self.catName = cat.category ?? ""
                    self.catNameInFrench = cat.categoryInFrench ?? ""
                    self.extractSubCatAndProductListing(cat.categoryId ?? "")
                    self.subCatLbl.text = ""
              }

              action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")

              actionSheetAlertController.addAction(action)
            }
        }else {
            for cat in maincatArr {
                let action = UIAlertAction(title: cat.category, style: .default) { (action) in
                    self.productListArr.removeAll()
                    if self.subCatLbl.text == "Insurance Product" {
                        self.subCatLbl.text = ""
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    self.mainCatLbl.text = cat.category ?? ""
                    self.catId = cat.categoryId ?? ""
                    self.catName = cat.category ?? ""
                    self.catNameInFrench = cat.categoryInFrench ?? ""
                    self.extractSubCatAndProductListing(cat.categoryId ?? "")
                    self.subCatLbl.text = ""
                }

                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    func extractSubCatAndProductListing(_ id: String) {
        for item in maincatArr {
            if item.categoryId == id {
                self.subcatArr = item.subCategoryAndProductList ?? []
            }
        }
    }
    
    
    @IBAction func onClickSubcategory(_ sender: UIButton) {
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            for cat in subcatArr {
                let action = UIAlertAction(title: cat.subCategoryInFrench, style: .default) { (action) in
                    self.subCatLbl.text = cat.subCategoryInFrench ?? ""
                    self.subcatId = cat.subCategoryId ?? ""
                    self.subcatName = cat.subCategory ?? ""
                    self.subcatNameInFrench = cat.subCategoryInFrench ?? ""
                    //                    self.extractProductListing(cat.subCategoryId ?? "")
                    let param:[String:Any] = ["categoryId":self.subcatId,"searchBy":""]
                    self.selectCatVM.subCatListApi(param: param)
                    //prepareData
                }

                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }else {
            for cat in subcatArr {
                let action = UIAlertAction(title: cat.subCategory, style: .default) { (action) in
                    self.subCatLbl.text = cat.subCategory ?? ""
                    self.subcatId = cat.subCategoryId ?? ""
                    self.subcatName = cat.subCategory ?? ""
                    self.subcatNameInFrench = cat.subCategoryInFrench ?? ""
                    //                    self.extractProductListing(cat.subCategoryId ?? "")
                    let param:[String:Any] = ["categoryId":self.subcatId,"searchBy":""]
                    self.selectCatVM.subCatListApi(param: param)
                    //prepareData
                }

                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
        }
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)

            self.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
//    func extractProductListing(_ id: String) {
//
//        for item in subcatArr {
//            if item.subCategoryId == id {
//                self.productListArr = item.productList ?? []
//                break
//            }
//        }
//
//        if self.productListArr.count > 0 {
//            var count = -1
//            for item in productListArr {
//                count += 1
//                var newProductDic = NSMutableDictionary()
//                newProductDic["productId"] = self.productListArr[count].productId
//                newProductDic["productName"] = self.productListArr[count].productName
//                newProductDic["commission"] = ""
//                newProductArr.append(newProductDic)
//            }
//
//            if productListArr.count == 0 {
//                DispatchQueue.main.async {
//
//                    self.noDataFoundView.isHidden = false
//                    self.tableView.isHidden = true
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.noDataFoundView.isHidden = true
//                    self.tableView.isHidden = false
//                    self.tableView.delegate = self
//                    self.tableView.dataSource = self
//                    self.tableView.reloadData()
//                }
//            }
//
//
//        }
//
//    }
    
    
    @IBAction func onClickDone(_ sender: UIButton) {
        productArrToBeSent.removeAll()
        for item in newProductArr {
            if item["isSelected"] as! String == "yes" {
                var newProductDic = NSMutableDictionary()
                newProductDic["productId"] = item["productId"]
                newProductDic["productName"] = item["productName"]
                newProductDic["productNameInFrench"] = item["productNameInFrench"]
                newProductDic["commission"] = item["commission"]
                productArrToBeSent.append(newProductDic)
            }
            
        }
        
        print(productArrToBeSent)

        checkInternet()

    }
    
    //MARK:- Check Validation
    
    func checkValidation() {
        if mainCatLbl.text?.isEmpty == true {
            self.ShowAlert(message: "please select Category".localized())
        } else if subCatLbl.text?.isEmpty == true{
            
            self.ShowAlert(message: "please select Sub Category".localized())

        }
        else{
          
            checkInternet ()
        }
        
    }
    
    func checkCommissionValidation() -> (Bool, String) {
        
        productArrToBeSent.removeAll()
        var isValidated = true
        var validationMsg = ""
        
        for item in 0...newProductArr.count - 1{

            let commission = newProductArr[item]["commission"]
            var agentCommission = newProductArr[item]["commission"] as? String
            var textCommission = Int(agentCommission ?? "")

//            if commission as! String == "" {
//                isValidated = false
//                validationMsg = "commission should not be empty".localized()
//                break
//            }
            
            if agentCommission != "" {
                productArrToBeSent.append(newProductArr[item])
            }
            
            if textCommission ?? 0  > 99 {
                isValidated = false
                validationMsg = "Commission should not be greater than 99".localized()
                break
            }

        }
        return (isValidated, validationMsg)
    }
    //MARK:- Check Internet Connection
    
    func checkInternet () {
        if internetConnection.isConnectedToNetwork() == true {

//            var commValidation = self.checkCommissionValidation()
//            if commValidation.0 {
//                let param: [String: Any] = ["categoryId": self.catId, "categoryName": self.catName, "subCategoryId": self.subcatId, "subCategoryName": self.subcatName, "commissionType": "PERCENTAGE", "productList": productArrToBeSent]
//                print(productArrToBeSent)
//                print(param)
//                selectCatVM.addProductApi(param: param)
//            } else {
//                self.ShowAlert(message: commValidation.1)
//            }
            
//            selectCatVM.addProductApi(param: param)
            let param: [String: Any] = ["categoryId": self.catId, "categoryName": self.catName, "categoryNameInFrench": self.catNameInFrench,"subCategoryId": self.subcatId, "subCategoryName": self.subcatName,"subCategoryNameInFrench":self.subcatNameInFrench, "commissionType": "PERCENTAGE", "productList": productArrToBeSent]
            
            selectCatVM.addProductApi(param: param)
        }
        else{
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
        }
    }
    
    func makeProductListArr() {
        for item in self.productListArr {
            let obj = NSMutableDictionary()
            obj.setValue(item.productId, forKey: "productId")
            obj.setValue(item.productName, forKey: "productName")
        }
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.popVC(animated: true)

    }
    
    func setSubCatList(data: SelectSubCatModel) {
        newProductArr.removeAll()
        self.productListArr.removeAll()
        
        self.productListArr = data.data?.productList ?? []
        
        if data.status == "SUCCESS"{
            
                var count = -1
                for item in productListArr {
                    count += 1
                    var newProductDic = NSMutableDictionary()
                    newProductDic["productId"] = self.productListArr[count].productId
                    newProductDic["productName"] = self.productListArr[count].productName
                    newProductDic["productNameInFrench"] = self.productListArr[count].productNameInFrench
                    newProductDic["commission"] = self.productListArr[count].commission
                    newProductDic["isSelected"] = "no"
                    newProductArr.append(newProductDic)
                }
                if productListArr.count == 0 {
                    DispatchQueue.main.async {
                        
                        self.noDataFoundView.isHidden = false
                        self.tableView.isHidden = true
                    }
                }
                    
                else {
                    DispatchQueue.main.async {
                        self.noDataFoundView.isHidden = true
                        self.tableView.isHidden = false
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
                    }
                }
            }

        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
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
    
    func setMainCatList(data: SelectCatResponse) {
        if data.status == "SUCCESS"{
            print(data)
            self.maincatArr.removeAll()

                self.maincatArr = data.data?.categoryList ?? []
          
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
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
    
    func setAddproductList(data: SuccessModel) {
        if data.status == "SUCCESS"{
            
            self.showOkAlertWithHandler("Product added successfully.".localized()) {
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                //                self.navigationController!.popVC(animated: true)
                self.popVC(animated: true)
            }
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
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
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    //MARK:- Select All actin btn
    
    @IBAction func btnActionselectAll(_ sender: UIButton) {
         sender.isSelected = !sender.isSelected

        if sender.isSelected == true {
            print("true")
            self.selectAllProducts("yes")
            imgCheckMark.image = UIImage(named: "check")
        }else{
            self.selectAllProducts("no")
            imgCheckMark.image = UIImage(named: "uncheck")
     
            
        }
        self.tableView.reloadData()
    }
    
    func selectAllProducts(_ value: String) {
        for i in 0..<newProductArr.count {
            newProductArr[i]["isSelected"] = value
        }
    }
}

extension SelectCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCatCell") as! SelectCatCell
        let info = newProductArr[indexPath.row]
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
           let result = language as! NSArray
           
        if result[0] as! String == "fr" {
            cell.cellProductTxt.text = info["productNameInFrench"] as! String
        }else{
            cell.cellProductTxt.text = info["productName"] as! String
        }
       
        cell.cellComissionTxt.tag = indexPath.row
        cell.cellComissionTxt.text = "\(info["commission"] ?? 0.0)"
        
        cell.cellProductTxt.isUserInteractionEnabled = false
        cell.cellComissionTxt.isUserInteractionEnabled = false
        
        cell.cellProductTxt.tag = indexPath.row
        cell.index = indexPath.row
        
        if info["isSelected"] as! String == "no" {
            cell.selectImg.image = UIImage(named: "uncheck")
        } else {
            cell.selectImg.image = UIImage(named: "check")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newProductArr[indexPath.row]["isSelected"] = newProductArr[indexPath.row]["isSelected"] as! String == "yes" ? "no" : "yes"
//        newProductArr[indexPath.row]["isSelected"] = "yes"
        self.tableView.reloadData()
    }
}



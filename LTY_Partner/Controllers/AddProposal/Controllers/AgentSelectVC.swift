//
//  AgentSelectVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import UIKit

protocol AgentProductAmountDelegate : AnyObject {
    
    func setProductAmountData(arr : NSMutableArray, nameArr : NSMutableArray)
}

class AgentSelectVC: UIViewController, ProductListProtocolDelegate, AgentProductAmountDelegate {
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrover: CustomNavigationBarForDrawer!
    func setProductAmountData(arr: NSMutableArray, nameArr: NSMutableArray) {
        self.productArr = arr
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataFoundView: UIView!
    
    var productList = [ProductListt]()
    var productViewModel = ProductViewModel()
    var subCatId = ""
    var productArr = NSMutableArray()
    var delegate : AgentProductAmountDelegate?
    var selectedProductsArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productViewModel.delegate = self
        
        let comingFromLead = UserDefaults.standard.value(forKey: "fromLead")
        if comingFromLead as! String == "yes" {
            let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
            let sourceId = kUserDefaults.string(forKey:AppKeys.sourceId) ?? ""
            let userType = kUserDefaults.value(forKey: AppKeys.userType)
                        if userType as! String == "AGENT" {
                            let param :[String:Any]  = ["subCategoryId":self.subCatId, "partnerId": sourceId]
                            productViewModel.getProductByAgent(param: param)
                        } else {
                            let param :[String:Any]  = ["subCategoryId":self.subCatId, "partnerId": partnerId]
                            productViewModel.getProductByAgent(param: param)
                        }
        } else {
            
           
            
            let userType = kUserDefaults.value(forKey: AppKeys.userType)
            let sourceId = kUserDefaults.value(forKey: AppKeys.sourceId)
            let PartnerId = kUserDefaults.value(forKey: AppKeys.partnerID)
            if userType as! String == "AGENT"{
                let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
                let sourceId = kUserDefaults.string(forKey:AppKeys.sourceId) ?? ""
                let param :[String:Any]  = ["subCategoryId":self.subCatId, "partnerId": sourceId]
                productViewModel.getProductByAgent(param: param)
            }else{
                let param :[String:Any]  = ["subCategoryId":self.subCatId, "partnerId": PartnerId]
                productViewModel.getProductByAgent(param: param)
//                let param :[String:Any]  = ["subCategoryId":self.subCatId, "searchBy": ""]
//                productViewModel.subCatListApi(param: param)
            }
            
            
        }
        
        
        setDrowerHeight()
        customNavDrover.titleLabel.text = "Insurance Coverage".localized()
        customNavDrover.titleLabel.textAlignment = .center
        customNavDrover.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrover.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
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
        self.dismiss(animated: true)
        
    }
    
    func createProdArrForParams() {
        for item in self.productList {
            
            var productObj = NSMutableDictionary()
            productObj.setValue(item.productId, forKey: "productId")
            productObj.setValue(item.productName, forKey: "productName")
            productObj.setValue(item.productNameInFrench, forKey: "productNameInFrench")
            productObj.setValue(0.0, forKey: "amount")
            productObj.setValue("no", forKey: "isSelected")
            self.productArr.add(productObj)
        }
        if selectedProductsArr.count > 0 {
            self.checkExistigSelectedProductsAndSetData()
        }
    }

    func checkExistigSelectedProductsAndSetData() {
        for items in self.selectedProductsArr {
            let item = items as! NSMutableDictionary
            var count = -1
            for apiItems in self.productArr {
                count += 1
                let apiItem = apiItems as! NSMutableDictionary
                    if item["productId"] as! String == apiItem["productId"] as! String {
                        apiItem["amount"] = item["amount"] as! Double
                        apiItem["isSelected"] = "yes"
                        apiItem["productName"] = item["productName"] as! String
                        apiItem["productNameInFrench"] = item["productNameInFrench"] as! String
                        apiItem["productId"] = item["productId"] as! String
                        self.productArr.removeObject(at: count)
                        self.productArr.insert(apiItem, at: count)
                    }
                
            }
            
        }
        print(self.productArr)
    }

    func setSubCategoryList(data: ProductModel) {
        
        if data.status == "SUCCESS" {

        self.productList.removeAll()
        
            self.productList = data.data?.productList ?? []
            self.createProdArrForParams()
            
            
        if productList.count == 0 {
            DispatchQueue.main.async {
                
                self.noDataFoundView.isHidden = false
                self.tableView.isHidden = true
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.noDataFoundView.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
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
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    @IBAction func onClickDone(_ sender: Any) {
//        self.popToVC(<#T##vc: UIViewController##UIViewController#>, animated: <#T##Bool#>)

        if !self.checkValidation() {
            self.ShowAlert(message: "Please fill amount.".localized())
            return
        }
        
        self.dismiss(animated: true) {
            self.delegate?.setProductAmountData(arr: self.productArr, nameArr: [])
        }
        
        
    }
    
    func checkValidation() -> Bool {
        print(self.productArr)
        var isValidated = true
        for items in self.productArr {
            let item = items as! NSMutableDictionary
            if item["isSelected"] as! String == "yes" && item["amount"] as! Double == 0.0 {
                isValidated = false
                break
            }
        }
        return isValidated
    }

    
}

extension AgentSelectVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentSelectCell", for: indexPath) as! AgentSelectCell
        cell.cellSelectBtn.tag = indexPath.row
        
        cell.cellTf.tag = indexPath.row
        cell.productList = self.productList
        cell.productArr = self.productArr
        cell.cellSelectBtn.addTarget(self, action: #selector(checkboxAction(sender:)), for: .touchUpInside)
        let info = self.productList[indexPath.row]
        
        let infoo = self.productArr[indexPath.row] as! NSMutableDictionary
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            cell.cellProductLbl.text = info.productNameInFrench
        }else{
            cell.cellProductLbl.text = info.productName
        }
        if infoo["isSelected"] as! String == "no" {
            cell.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
        } else {
            cell.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
        }
        
        if self.selectedProductsArr.count > 0 {
            cell.cellTf.text = "\(infoo["amount"] as! Double)"
        }
        
        
        return cell
    }
    
    @objc func checkboxAction(sender:UIButton)
    {
//        let index = sender.tag
//        checkNetwork(indexNo: index)
    }
    
    
}

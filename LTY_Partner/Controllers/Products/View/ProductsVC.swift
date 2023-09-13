//
//  ProductsVC.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/23/23.
//

import UIKit

class ProductsVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var productList = [ProductListt]()
    var productListInFrench = [ProductListtInFrench]()
    var categoryName = ""
    var subcategory = ""
    var subCatID = ""
    
   var productViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productViewModel.delegate = self
        setUpViews()
        setDrowerHeight()
        setUpTableView()
        self.searchTf.delegate = self
        tableView.reloadData()
        lblCategory.text  = "Insurance Company".localized()
        lblSubCategory.text  = "Insurance Product".localized()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true

        let partnerId =  kUserDefaults.string(forKey: "partnerID")
//        let param :[String:Any]  = ["partnerId":partnerId,"subCategoryId":self.subCatID]
        let param :[String:Any]  = ["subCategoryId":self.subCatID, "searchBy": ""]
        productViewModel.subCatListApi(param: param)
    }
    
    //MARK:- will disappear func
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false

    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    //MARK:-  setUpViews
    
    func  setUpViews(){
        searchView.viewCorner(8)
        categoryLabel.text = categoryName
        subcategoryLabel.text = subcategory
        customNavigationBar.titleLabel.text = "Insurance Coverage".localized()
        customNavigationBar.titleLabel.textAlignment = .center
        customNavigationBar.leftBarButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigationBar.leftBarButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

    }
    //MARK:- setUp tableview
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ProductsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ProductsTableViewCell")
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    @objc func editAction(sender: UIButton){
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            let buttonTag = sender.tag
            DispatchQueue.main.async {
                
                let vc = EditProductOptionsVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                vc.index = sender.tag
                vc.delegate = self
                vc.commissionDelegate = self
                vc.subCatID = self.subCatID
                vc.productId = self.productList[sender.tag].productId ?? ""

                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: true)
            }
        }else{
            let buttonTag = sender.tag
            DispatchQueue.main.async {
                
                let vc = EditProductOptionsVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                vc.index = sender.tag
                vc.delegate = self
                vc.commissionDelegate = self
                vc.subCatID = self.subCatID
                vc.productId = self.productList[sender.tag].productId ?? ""
          
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: true)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let param :[String:Any]  = ["subCategoryId":self.subCatID, "searchBy": self.searchTf.text!]
        productViewModel.subCatListApi(param: param)
    }
}
extension ProductsVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.productList.count
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as! ProductsTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ProductsTableViewCell" , for: indexPath) as! ProductsTableViewCell

        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            cell.productLabel.text = self.productList[indexPath.row].productNameInFrench
        }else{
            cell.productLabel.text = self.productList[indexPath.row].productName
        }
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
           
            guard let commission =  self.productList[indexPath.row].commission else {return UITableViewCell()}
            cell.commissionLbl.text = "\(commission)"
            
            var createdOnStr = self.productList[indexPath.row].createdOn ?? ""
            createdOnStr = createdOnStr.components(separatedBy: "T")[0]
            cell.addedLbl.text = returnDOB(date: createdOnStr)
            
            var updatedtedOnStr = self.productList[indexPath.row].lastUpdatedOn ?? ""
            updatedtedOnStr = updatedtedOnStr.components(separatedBy: "T")[0]
            cell.updatedOnLbl.text = returnDOB(date: updatedtedOnStr)
    

        return cell
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 //UITableView.automaticDimension
        
    }
    
    
}

extension ProductsVC :ProductListProtocolDelegate,DeleteProductProtocolDelegate, ProductCommissionProtocolDelegate, CommissionEditTappedProtocolDelegate{
    func productActionsTappedIndex(editActionTappedIndex: Int, listIndex: Int) {
        if editActionTappedIndex == 104 {
      
                let vc = EditCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                vc.productObj = self.productList[listIndex]
                vc.delegate = self

                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: true)
            }
    }
    
    
    func setProductCommissiondata() {
        let param :[String:Any]  = ["subCategoryId":self.subCatID, "searchBy": ""]
        productViewModel.subCatListApi(param: param)
    }
    
    
    func deleteProductProtocolWithIndex(data: Int, subCatID: String) {
            let param :[String:Any]  = ["subCategoryId":subCatID, "searchBy": ""]
            productViewModel.subCatListApi(param: param)
        }
    
    func setSubCategoryList(data: ProductModel) {
        
        if data.status == "SUCCESS" {
            
            self.productList.removeAll()
            
            self.productList = data.data?.productList ?? []
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
    
    
}

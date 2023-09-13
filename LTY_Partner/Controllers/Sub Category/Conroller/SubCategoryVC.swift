//
//  SubCategoryVC.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/23/23.
//

import UIKit

class SubCategoryVC: UIViewController, DeleteCatProtocolDelegate, UITextFieldDelegate {

    @IBOutlet weak var lblCategoryHeading: UILabel!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var subCategoryName: UILabel!
    
    
    var subcategoryList = [SubCategoryDataList]()
    var subcategoryListInFrench = [SubCategoryDataListInFrench]()
   
    var subCategoryViewModel = SubCatagoryViewModel()
    var categoryName = ""
    var catId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setDrowerHeight()
        setUpTableView()
        self.searchTf.delegate = self
        tableView.reloadData()
        lblCategoryHeading.text = "Insurance Company".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true

        subCategoryViewModel.delegate = self
        let partnerId =  kUserDefaults.string(forKey: "partnerID")
//        let param :[String:Any]  = ["partnerId":partnerId,"categoryId":self.catId]
        let param :[String:Any]  = ["categoryId":self.catId, "searchBy": ""]
        subCategoryViewModel.subCatListApi(param: param)
    }
    
    //MARK:- will disappear func
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false

    }
    
    
    //MARK:- Setup view
    
    func  setUpViews(){
        searchView.viewCorner(8)
        subCategoryName.text = categoryName
        customNavigationBar.titleLabel.text = "Insurance Product".localized()
        customNavigationBar.titleLabel.textAlignment = .center
        customNavigationBar.leftBarButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigationBar.leftBarButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    //MARK:- setUp tableview
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "SubCategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SubCategoryTableViewCell")
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    func deleteProductProtocolWithIndex(data: Int, subCatID: String) {
        let param :[String:Any]  = ["categoryId":subCatID, "searchBy": ""]
        subCategoryViewModel.subCatListApi(param: param)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let param :[String:Any]  = ["categoryId":self.catId, "searchBy": self.searchTf.text]
        subCategoryViewModel.subCatListApi(param: param)
    }
}
extension SubCategoryVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.subcategoryList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryTableViewCell") as! SubCategoryTableViewCell
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
           let result = language as! NSArray
           
        if result[0] as! String == "fr" {
            cell.nameLabel.text = self.subcategoryList[indexPath.row].subCategoryNameInFrench
        }else{
            cell.nameLabel.text = self.subcategoryList[indexPath.row].subCategoryName

        }
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func editAction(sender: UIButton){
        let buttonTag = sender.tag
        DispatchQueue.main.async {
            
            let vc = EditCatOptionsVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
            vc.subCatId = self.subcategoryList[sender.tag].subCategoryId ?? ""
            vc.catId = self.catId
            vc.index = sender.tag
            vc.delegate = self
            vc.type = "subCat"
//            vc.comingFrom = "loginVC"
//            vc.otpId = data.data?.processStageData?.txnStateData?.otpID ?? ""
//            vc.verifiedEmail = self.textEmail.text ?? ""
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
     
            self.present(vc, animated: true)
        }
        
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
     
        }else{
        }
            let info =  self.subcategoryList[indexPath.row]
          let categoryName = categoryName
            print(categoryName)
            guard let subcategory = info.subCategoryName else {return}

            let vc = ProductsVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
            vc.categoryName = categoryName ?? ""
            vc.subcategory = subcategory ?? ""
            vc.subCatID = info.subCategoryId ?? ""
            pushToVC(vc, animated: true)
    }
}

extension SubCategoryVC : subCategoryListProtocolDelegate {
    func setSubCategoryList(data: SubCategoryModel) {
        if data.status == "SUCCESS" {
            
            self.subcategoryList.removeAll()
                self.subcategoryList = data.data?.subCategoryList ?? []
                
                if subcategoryList.count == 0 {
                    DispatchQueue.main.async {
                        
                        self.noDataFoundView.isHidden = false
                        self.tableView.isHidden = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.noDataFoundView.isHidden = true
                        self.tableView.isHidden = false
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
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    
}

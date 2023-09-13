//
//  CategoryVC.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/22/23.
//

import UIKit

class CategoryVC: UIViewController, UITextFieldDelegate, DeleteCatProtocolDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var selectCategoryView: UIView!
    
    var categoryViewModel = CategoryViewModel()
    var categoryListData = [MainCategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpTableView()
        
        categoryViewModel.delegate = self
        setDrowerHeight()
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true

        let partnerId =  kUserDefaults.string(forKey: "partnerID")
        let param :[String:Any]  = ["searchBy":""]
        categoryViewModel.productCommissionListApi(param: param, url: LTY_END_POINT_URL.getCategory)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    

    func  setUpViews(){
        selectCategoryView.viewCorner(8)
        customNavigationBar.titleLabel.text = "Insurance Company".localized()
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
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CategoryTableViewCell")
        let headerNib = UINib(nibName: "CategoryHeaderView", bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "CategoryHeaderView")
    }

    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    @IBAction func onClickSelectCatagory(_ sender: UIButton) {
        let vc = SelectCategoryVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
        self.pushToVC(vc, animated: true)
    }
    
 
    
    func deleteProductProtocolWithIndex(data: Int, subCatID: String) {
        let param :[String:Any]  = ["searchBy": ""]
        categoryViewModel.productCommissionListApi(param: param, url: LTY_END_POINT_URL.getCategory)
    }
    
}
extension CategoryVC : CategoryListProtocolDelegate {
    
    func setCategoryNewList(data: CategoryNewModel) {
        print("")
    }
   
    func setCategoryList(data: CategoryModel) {
        
        if data.status == "SUCCESS" {
            self.categoryListData.removeAll()
            
                self.categoryListData = data.data?.categoryList ?? []
                if categoryListData.count == 0 {
                    DispatchQueue.main.async {
                        
                        self.noDataFoundView.isHidden = false
                        self.tableView.isHidden = true
                    }
                }
                else {
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

//
//  SelectInsurerVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/08/23.
//

import UIKit



    protocol SetInsurerList {
        func setSelectedMemberList(arr:NSMutableArray, nameArr: NSMutableArray, memberList: [CategoryList] )
    }

class SelectInsurerVC: UIViewController {

        @IBOutlet weak var noDataFoundView: UIView!
        @IBOutlet weak var customNavHeight: NSLayoutConstraint!
        @IBOutlet weak var customNvaBar: CustomNavigationBarForDrawer!
        @IBOutlet weak var tableView: UITableView!
        
        var insurerList = [CategoryList]()
        
        var delegate : SetInsurerList?
        var memberIdArr = NSMutableArray()
        var memberNameArr = NSMutableArray()
        var isEdit = Bool()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setDrowerHeight()
        customNvaBar.titleLabel.text = "Select Insurer".localized()
        customNvaBar.titleLabel.textAlignment = .center
        customNvaBar.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNvaBar.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        if insurerList.count == 0 {
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true

    }

        //MARK:- backAction Btn
        
        @objc func backActionBtn(_ sender: UIButton) {
           
            self.dismiss(animated: true)
            
        }
        
        //MARK:- set navigationDrower Height
        
        func setDrowerHeight() {
            if UIDevice.current.hasNotch {
                customNavHeight.constant = DroverHeight.haveNotch
            } else {
                customNavHeight.constant = DroverHeight.dontHaveNotch
                
            }
        }

        func setSelectedMemberList(arr: NSMutableArray, nameArr: NSMutableArray) {
            self.memberIdArr = arr
            self.memberNameArr = nameArr
        }
        
        @IBAction func onClickDone(_ sender: UIButton) {
            self.dismiss(animated: true) {
                self.delegate?.setSelectedMemberList(arr: self.memberIdArr, nameArr: self.memberNameArr, memberList: self.insurerList)
            }
            
        }
    }

    extension SelectInsurerVC: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
               let result = language as! NSArray
      
                return self.insurerList.count
     
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectInsurerTVC", for: indexPath) as! SelectInsurerTVC
            let info = self.insurerList[indexPath.row]

            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
               let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                
                cell.cellNameLbl.text = info.categoryInFrench
                
                if self.memberNameArr.contains(info.categoryInFrench ?? "") {
                    cell.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
                } else {
                    cell.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
                }
            
            }else{
                
                cell.cellNameLbl.text = info.category
                if self.memberNameArr.contains(info.category ?? "") {
                    cell.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
                } else {
                    cell.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
                }
            
            }
            

            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            /*
             var info = self.insurerList[indexPath.row]
             if info.isSelected == "yes"{
             info.isSelected = "no"
             self.insurerList.remove(at: indexPath.row)
             insurerList.insert(info, at: indexPath.row)
             self.memberIdArr.remove(info.categoryId ?? "")
             self.memberNameArr.remove(info.category ?? "")
             } else {
             info.isSelected = "yes"
             self.insurerList.remove(at: indexPath.row)
             insurerList.insert(info, at: indexPath.row)
             self.memberIdArr.add(info.categoryId ?? "")
             
             self.memberNameArr.add(info.category ?? "")
             }
             tableView.reloadData()
             */
            var info = self.insurerList[indexPath.row]

            let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
            let result = language as! NSArray
            
            if result[0] as! String == "fr" {
                if self.memberNameArr.contains(info.categoryInFrench) {
                    self.memberNameArr.remove(info.categoryInFrench)
                } else {
                    self.memberNameArr.add(info.categoryInFrench)
                }
            } else{
                if self.memberNameArr.contains(info.category) {
                    self.memberNameArr.remove(info.category)
                } else {
                    self.memberNameArr.add(info.category)
                }
            }
            
           
    
            tableView.reloadData()
        }
    }


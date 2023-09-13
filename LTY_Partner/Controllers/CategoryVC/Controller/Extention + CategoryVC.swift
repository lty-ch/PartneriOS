//
//  Extention + CategoryVC.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/22/23.
//

import Foundation
import UIKit



extension CategoryVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return self.categoryListData.count
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        let info = self.categoryListData[indexPath.row]
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
      
            cell.NameLabel.text = info.categoryNameInFrench
        }
        else{
            cell.NameLabel.text = info.categoryName
  
        }
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
  
        return cell
    }
    
    @objc func editAction(sender: UIButton){
        let buttonTag = sender.tag
        DispatchQueue.main.async {
            
                let vc = EditCatOptionsVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                vc.subCatId = self.categoryListData[sender.tag].categoryId ?? ""
                vc.index = sender.tag
                vc.delegate = self
                vc.type = "cat"

                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: true)
            }
        }
        

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        let info = self.categoryListData[indexPath.row]
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        let vc = SubCategoryVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)

        if result[0] as! String == "fr" {
            vc.categoryName = info.categoryNameInFrench ?? ""
        }else{
            vc.categoryName = info.categoryName ?? ""
        }
            //        vc.subcategoryList = subcategoryInfo
           
            vc.catId = info.categoryId ?? ""
            pushToVC(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50

    }
    
  
     //  MARK:-  view for header in section func in tableview

     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         
         let headerView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoryHeaderView") as! CategoryHeaderView
         headerView.fill()
         
//         headerView.btnDropDown.tag = section
//
//         headerView.btnDropDown.addTarget(self, action:#selector(buttonCheckMarkAction(_:)), for: .touchUpInside)
//
//         let dataNew = categories[section].categoryName
//         headerView.labelHeaderTitle.text = dataNew
         return headerView

     } // END  view for header func
     
     
//     @objc func buttonCheckMarkAction(_ sender:UIButton){
//         
//         categories[sender.tag].loadSection.toggle()
//         homeTableView.reloadData()
//     }
    
}


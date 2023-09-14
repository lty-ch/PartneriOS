//
//  ExtensionUserRole+UITable.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import Foundation
import UIKit

extension UserRoleDetailVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.useCaseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userRoleTableView.dequeueReusableCell(withIdentifier: "UserRoleTableCell", for: indexPath) as! UserRoleTableCell
        
        let info = self.useCaseArr[indexPath.row]
        cell.selectionStyle = .none
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
//        if result[0] as! String == "fr" {
//            cell.lblCategoryList.text = info.nameInFrench ?? ""
//        }else{}
            cell.lblCategoryList.text = info.name ?? ""
        
        cell.btnRead.tag = indexPath.row
        cell.btnRead.addTarget(self, action: #selector(self.ReadSwitchChanged(_:)), for: .valueChanged)
        
        cell.btnWrite.tag = indexPath.row
        cell.btnWrite.addTarget(self, action: #selector(self.WriteSwitchChanged(_:)), for: .valueChanged)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(self.DeleteSwitchChanged(_:)), for: .valueChanged)
        cell.readView.isHidden = true
        cell.writeView.isHidden = true
        cell.deleteView.isHidden = true
        
        for item in info.permissionIds ?? [] {
            if item == 1 {
                
                cell.readView.isHidden = false
                
            }
            if item == 2 {
                
                cell.writeView.isHidden = false
            }
            if item == 3 {
                
                cell.deleteView.isHidden = false
            }
        }
        
        
        
//        for item in info.permissionIds ?? [] {
//            if item == 1 {
//
//                cell.readView.isHidden = false
//            } else if item == 2 {
//
//                cell.writeView.isHidden = false
//            } else {
//
//                cell.deleteView.isHidden = false
//            }
//        }
        
        cell.btnRead.isOn = false
        cell.btnWrite.isOn = false
        cell.btnDelete.isOn = false
        
        for item in info.selectedPermissionIds ?? [] {
            if item == 1 {

                cell.btnRead.isOn = true
            }
            if item == 2 {

                cell.btnWrite.isOn = true
            }
            
            if item == 3 {

                cell.btnDelete.isOn = true
            }
        }
        
        
        
//        if self.selectedUseCaseArr.count > 0 {
//            let selectedInfo = self.selectedUseCaseArr[indexPath.row]
//
//            if info.useCaseId == selectedInfo.useCaseId {
//                for item in selectedInfo.permissionIds ?? [] {
//                    if item == 1 {
//                        cell.btnRead.isOn = true
//                    } else if item == 2 {
//                        cell.btnWrite.isOn = true
//                    } else {
//                        cell.btnDelete.isOn = true
//                    }
//                }
//            }
//        }
        
        
        
        
        
        return cell
    }
    
    @objc func ReadSwitchChanged(_ sender : UISwitch!){
        var arr = [Int]()
        let useCaseId = self.useCaseArr[sender.tag].useCaseId ?? 0
        let selectedPIDs = self.useCaseArr[sender.tag].selectedPermissionIds ?? []
        for item in selectedPIDs {
            arr.append(item)
        }
        
        if sender.isOn {
            arr.append(1)
        } else {
            if let index = arr.firstIndex(of: 1) {
                arr.remove(at: index)
            }
        }
        self.useCaseArr[sender.tag].selectedPermissionIds = arr
        
//        self.updateValueInArrForParams(useCaseId, editValue: 1, editAction: sender.isOn ? "add" : "remove")
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    @objc func WriteSwitchChanged(_ sender : UISwitch!){
        
        let useCaseId = self.useCaseArr[sender.tag].useCaseId ?? 0
//        self.updateValueInArrForParams(useCaseId, editValue: 2, editAction: sender.isOn ? "add" : "remove")
        var arr = [Int]()
        
        let selectedPIDs = self.useCaseArr[sender.tag].selectedPermissionIds ?? []
        for item in selectedPIDs {
            arr.append(item)
        }
        
        if sender.isOn {
            arr.append(2)
        } else {
            if let index = arr.firstIndex(of: 2) {
                arr.remove(at: index)
            }
        }
        self.useCaseArr[sender.tag].selectedPermissionIds = arr
        print(self.useCaseArr)
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    @objc func DeleteSwitchChanged(_ sender : UISwitch!){
        
        let useCaseId = self.useCaseArr[sender.tag].useCaseId ?? 0
//        self.updateValueInArrForParams(useCaseId, editValue: 3, editAction: sender.isOn ? "add" : "remove")
        var arr = [Int]()
        
        let selectedPIDs = self.useCaseArr[sender.tag].selectedPermissionIds ?? []
        for item in selectedPIDs {
            arr.append(item)
        }
        
        if sender.isOn {
            arr.append(3)
        } else {
            if let index = arr.firstIndex(of: 3) {
                arr.remove(at: index)
            }
        }
        self.useCaseArr[sender.tag].selectedPermissionIds = arr
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    func updateAllRolesArrWithSelections(_ id: Int, editValue: Int, editAction: String) {
        for item in self.useCaseArr {
            if item.useCaseId == id {
                var obj : RoleDetailList?
                
                obj?.name = item.name
                obj?.useCaseId = id
                obj?.permissionIds = item.permissionIds
//                obj?.selectedPermissionIds =
                
//                obj.setValue(id, forKey: "useCaseId")
//                obj.setValue(item.name, forKey: "name")
                var arr = NSMutableArray()
                if editAction == "add" {
                    arr.add(editValue)
                } else {
                    arr.remove(editValue)
                }

//                obj.setValue(arr, forKey: "selectedPermissionIds")
//                obj.setValue(item.permissionIds, forKey: "permissionIds")
            }
            
        }
    }
    
//    func updateValueInArrForParams(_ id: Int, editValue: Int, editAction: String) {
//        var count = -1
//        for ite in self.duplicateUseCaseArr {
//
//            let item = ite as! NSMutableDictionary
//            count += 1
//            if item.value(forKey: "useCaseId") as! Int == id {
//
//                var obj = NSMutableDictionary()
//
//
//                obj.setValue(id, forKey: "useCaseId")
//                obj.setValue(item.value(forKey: "name") as! String, forKey: "name")
//                var arr = NSMutableArray()
//                if editAction == "add" {
//                    arr.add(editValue)
//                } else {
//                    arr.remove(editValue)
//                }
//
//                obj.setValue(arr, forKey: "selectedPermissionIds")
//
//                self.duplicateUseCaseArr.removeObject(at: count)
//                self.duplicateUseCaseArr.insert(obj, at: count)
//
//            }
//        }
//        print(self.duplicateUseCaseArr)
//    }
    
}

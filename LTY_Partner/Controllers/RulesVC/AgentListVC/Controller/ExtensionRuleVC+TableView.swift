//
//  ExtensionRuleVC+TableView.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import Foundation
import UIKit

extension RulesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rolesTableView {
            return self.rolesArr.count
        }else{
            return self.agentListArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == rolesTableView {
            let cell = rolesTableView.dequeueReusableCell(withIdentifier: "UserRulesTableViewCell", for: indexPath) as! UserRulesTableViewCell
            
            let info = self.rolesArr[indexPath.row]

            cell.selectionStyle = .none
            cell.lblTitle.text = info.name ?? ""
            if info.isDefault == true{
                cell.lblDefault.text = "(Default)".localized()
                cell.lblDefault.textColor = Asset.Colors.greenColor.color
            }else{
                cell.lblDefault.text = ""
            }
            
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editRoleActionBtn(_:)), for: .touchUpInside)
            
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteActionBtn(_:)), for: .touchUpInside)
            
            return cell
            
        }else {
            let cell = agentListTableView.dequeueReusableCell(withIdentifier: "AgentListTableCell", for: indexPath) as! AgentListTableCell
            
            let info = self.agentListArr[indexPath.row]
            
            cell.selectionStyle = .none
            cell.lblName.text = info.name ?? ""
            cell.lblEmail.text = info.email ?? ""
            cell.lblRole.text = info.roleName ?? ""
            cell.editActionBtn.tag = indexPath.row
            cell.editActionBtn.addTarget(self, action: #selector(editActionBtn(_:)), for: .touchUpInside)
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == rolesTableView {
            let vc = UserRoleDetailVC.instantiate(fromAppStoryboard: .ruleStoryboard)
            vc.roleId = self.rolesArr[indexPath.row].id ?? ""
            pushToVC(vc, animated: true)

        }

    }
    
    @objc func editActionBtn(_ sender: UIButton ){
        let vc = AssignAgentVC.instantiate(fromAppStoryboard: .ruleStoryboard)
        vc.roleListArr = self.rolesArr
        vc.agentObj = self.agentListArr[sender.tag]
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func editRoleActionBtn(_ sender: UIButton ){
        let vc = AddRoleVC.instantiate(fromAppStoryboard: .ruleStoryboard)
        let info = self.rolesArr[sender.tag]
        vc.delegate = self
        vc.roleId = info.id ?? ""
        vc.roleName = info.name ?? ""
        vc.isComing = "Update Role"
        vc.defaultValue = info.isDefault
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func deleteActionBtn(_ sender: UIButton ){
        let vc = DeleteUserListVC.instantiate(fromAppStoryboard: .ruleStoryboard)
        vc.delegateUserRole = self
        vc.index = sender.tag
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

extension RulesVC:DeleteUserRoleProtocolDelegate {
    
    func passData(sendValue: String, index: Int) {
        print(sendValue)
        
        switch sendValue {
        case "Delete":
            print("delete user")
            let roleId = self.rolesArr[index].id
            let params : [String:Any] = ["roleId": roleId, "status": false]
            rolesVM.deleteRole(param: params)
            
            
        default:
            print("")
        }
    }
}



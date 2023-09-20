//
//  ExtensionAgentCommission+TableView.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import Foundation
import UIKit

extension AgentCommissionVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agentCommissionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agentCommissionTableView.dequeueReusableCell(withIdentifier: "AgentCommTableViewCell",for:indexPath) as! AgentCommTableViewCell
        
        let data = agentCommissionList[indexPath.row]
        cell.selectionStyle = .none
        cell.labelName.text = data.agentName
        cell.labelCatData.text = data.categoryName
        var startDate = data.lastUpdatedOn ?? ""
        startDate = startDate.components(separatedBy: "T")[0]
        cell.labelUpdateData.text = returnDOB(date: startDate)
        cell.labelSubCatData.text = data.subCategoryName
        cell.labelCompData.text = "\(data.commissionDetails?.companyReserve ?? 0.0)"
        cell.labelAgentReservData.text = "\(data.commissionDetails?.agentReserve ?? 0.0)"
        cell.labelCommissionData.text = "\(data.commissionDetails?.agentCommission ?? 0.0)"
        

            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(btnDeleteAction(sender:)), for: .touchUpInside)
            
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(btnEditAction(sender:)), for: .touchUpInside)

        return cell
    }
    
    @objc func btnDeleteAction(sender:UIButton)
    {
        
        DispatchQueue.main.async {
            var uiAlert = UIAlertController(title: "Lty", message: "Are you sure want to delete.".localized(), preferredStyle: UIAlertController.Style.alert)
           

            uiAlert.addAction(UIAlertAction(title: "Ok".localized(), style: .default, handler: { action in
                self.checkNetwork(indexNo:sender.tag)
            
             }))

            uiAlert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { action in
                print("Click of default button")
             }))
            
            self.present(uiAlert, animated: true, completion: nil)
            
        }

    }
    
    
    func checkNetwork(indexNo:Int){
        let feeId =  agentCommissionList[indexNo].feeId
        
        if internetConnection.isConnectedToNetwork() == true {
            
            let param :[String:Any]  = ["feeId":feeId]
            agentCommissionViewModel.agentCommissionDelete(param: param)
        }
        else {
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert)

        }
    }
    
     
    //MARK:- Edit btn Action
    
    @objc func btnEditAction(sender:UIButton) {
     
        let index = sender.tag
        guard agentCommissionList[index].agentId != nil else{ return }
        
        let vc = EditAgentCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
        let data = agentCommissionList[index]
        vc.feedId = data.feeId ?? ""
        vc.editAgentCommissionData.append(EditAgentCommissionModel.init(feeId: data.feeId,agentName:data.agentName ,categoryName: data.categoryName,subCategoryName: data.subCategoryName,agentReserve: data.commissionDetails?.agentReserve,CompnyReserve: data.commissionDetails?.companyReserve,agentCommission: data.commissionDetails?.agentCommission))

            self.pushToVC(vc, animated: true)
     
     }
    
}


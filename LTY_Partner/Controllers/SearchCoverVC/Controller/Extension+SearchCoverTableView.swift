//
//  Extension+SearchCoverTableView.swift
//  LTY_Partner
//
//  Created by Chawtech on 17/07/23.
//

import Foundation
import UIKit

extension SearchCoverVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectAgentType == "customer" {
            return customerListArr.count
            
        } else if selectAgentType == "agent" {
            return agentListArr.count
            
        }
   
        else {
            return analysisList.count
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectAgentType == "customer" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCoverTVC", for: indexPath) as! SearchCoverTVC

            let info = self.customerListArr[indexPath.row]
            
            cell.cellNameLbl.text = info.customerName ?? ""
            
            cell.cellMailLbl.text = info.email ?? ""
            cell.cellPhoneLbl.text = info.mobile ?? ""
            cell.cellCustomer.text = info.agentName ?? "Unassigned".localized()
            
            cell.cellAmountLbl.text = "\(info.totalAmount  ?? 0)"
            cell.cellProposalShared.text = "\(info.proposalShared  ?? 0)"
            cell.cellContractSigned.text = "\(info.contractSigned  ?? 0)"
         
            cell.totalIncomeView.isHidden = true
            
            return cell

        }
        else if selectAgentType == "agent"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAgentCoverCell", for: indexPath) as! SearchAgentCoverCell

            let info = self.agentListArr[indexPath.row]
            
            cell.cellNameLbl.text = info.agentName ?? "Unassigned".localized()
            
            cell.cellMailLbl.text = info.email ?? ""
            cell.cellPhoneLbl.text = info.mobile ?? ""
            
            cell.cellAmountLbl.text = "\(info.totalAmount  ?? 0)"
            cell.cellProposalShared.text = "\(info.proposalShared  ?? 0)"
            cell.cellContractSigned.text = "\(info.contractSigned  ?? 0)"
            cell.cellTotalIncome.text = "\(info.totalIncome  ?? 0)"
             
             return cell
             
         }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCoverAnalysisTVC", for: indexPath) as! SearchCoverAnalysisTVC
            let info = analysisList[indexPath.row]
            cell.lblProposalData.text =  "\(info.proposalPerLead ?? 0.0)"
            cell.lblSignatureData.text = "\(info.signaturePerProposal ?? 0.0)"
            cell.signaturePerLeadData.text = "\(info.signaturePerLead ?? 0.0)"
            cell.lblSignatureSubCatData.text = "\(info.signaturePerSubCategory ?? 0.0)"
            cell.lblSignaturePerCatData.text = "\(info.signaturePerCategory ?? 0.0)"
            
            if self.catName == "" {
                cell.lblCat.text =  "Select Category"

            }else{
                cell.lblCat.text = self.catName

            }
            if  self.subCatName == "" {
                cell.lblSubcat.text = "Select SubCategory"

            }else{
                cell.lblSubcat.text = self.subCatName

            }
            return cell
            
        }
        
        
        
   
    }
    
}




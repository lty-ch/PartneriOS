//
//  Extension+SetDataSearchCover.swift
//  LTY_Partner
//
//  Created by Chawtech on 17/07/23.
//

import Foundation
import UIKit

extension SearchCoverVC :SearchCoverProtocolDelegate {
    func setAnalysisList(data: SC_AnalysisModel) {
        self.analysisList.removeAll()
        if data.status == "SUCCESS"{
            
            DispatchQueue.main.async {
                self.analysisList.append(SC_AnalysisData.init(proposalPerLead: data.data?.proposalPerLead, signaturePerProposal: data.data?.signaturePerProposal, signaturePerCategory: data.data?.signaturePerCategory, signaturePerSubCategory: data.data?.signaturePerSubCategory, signaturePerLead: data.data?.signaturePerLead))
                
                self.tableView.isHidden = false
                self.overAllView.isHidden = true
                self.emptyView.isHidden = true
                self.tableView.reloadData()
            }

        }
        else{
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
    
    //MARK:- this is use for set agent List
    
    func setAgentList(data: SC_AgentModel) {
        agentListArr.removeAll()
        
        if data.status == "SUCCESS"{
            
            agentListArr = data.data?.agentsStatisticsList ?? []
            
            if agentListArr.count == 0 {
                
                self.tableView.isHidden = true
                self.overAllView.isHidden = true
                self.emptyView.isHidden = false
                
            }else {
                
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.overAllView.isHidden = true
                    self.emptyView.isHidden = true
                    self.tableView.reloadData()
                }
            }
            
        }
        else{
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
    
    
    //MARK:- this is use for set customers List
    
    func setCustList(data: SC_CustomerModel) {
        customerListArr.removeAll()
        
        if data.status == "SUCCESS"{
            
            customerListArr = data.data?.customersStatisticsList ?? []
            
            if customerListArr.count == 0 {
                
                self.tableView.isHidden = true
                self.overAllView.isHidden = true
                self.emptyView.isHidden = false
                
            }else {
                
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.overAllView.isHidden = true
                    self.emptyView.isHidden = true
                    self.tableView.reloadData()
                }
            }
            
        }
        else{
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
    
    //MARK:- this is use for set over all data
    
    func setOverAllData(data: SCOverAllModel) {
        
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                
                self.lblTotalProposal.text = "\(data.data?.proposalShared ?? 0)"
                self.lblTotalAmount.text = "\(data.data?.totalAmount ?? 0.0)"
                self.lblTotalIncome.text = "\(data.data?.totalIncome ?? 0.0)"
                self.lblTotalSignedContract.text = "\(data.data?.contractSigned ?? 0)"
            }
        }
        else{
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
        ShowAlert(message: msg)
    }
    
    
}



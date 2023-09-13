//
//  Extension+SetDataAgendaList.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import Foundation

extension AgendaListVC :AgendaProtocolDelegate{
    
    func deletAgenda(data: AddNewAgendaModel) {
        
        if data.status == "SUCCESS"{
            print(data.data?.status)
                DispatchQueue.main.async {
                    self.ApiCallingFunc ()
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
    
    
    //MARK:- Set agenda list Data
    
    func setAgendaLst(data: AgendaModel) {
        agendaListArr.removeAll()
        
        if data.status == "SUCCESS"{
            
            agendaListArr = data.data?.agendaList ?? []
            
            if agendaListArr.count == 0 {
                
                self.agendaTableView.isHidden = true
                self.emptyView.isHidden = false
                
            }else {
                
                DispatchQueue.main.async {
                    self.agendaTableView.isHidden = false
                    self.emptyView.isHidden = true
                    self.agendaTableView.reloadData()
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
    
    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)

        }
    }
    
    
}

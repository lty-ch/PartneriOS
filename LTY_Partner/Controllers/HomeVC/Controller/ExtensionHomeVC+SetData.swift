//
//  ExtensionHomeVC+SetData.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/07/23.
//

import Foundation


extension HomeVC : LeadVcProtpcolDelegate , ExpiredProposalListProtocolDelegate ,AgendaProtocolDelegate, HomeVCProtocoldelegate {
    
    //MARK:- set dashborad  Data
    
    func setDashboardData(data: HomeVCModel) {
        if data.status == "SUCCESS"{
            
            DispatchQueue.main.async {
                self.labelregCustDate.text = "\(data.data?.newRegisteredUserCount ?? 0)"
                self.labelSignContDate.text = "\(data.data?.newSignedContractCount ?? 0)"
            }
        }
        else{
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
    //MARK:- set expired Data
    
    func setExpiredProposalList(data: SubmissionModel, withInMonth: Int) {
        
        if data.status == "SUCCESS"{
            self.expiredLisArr.removeAll()
            self.expiredLisArr = data.data?.proposalsList ?? []
            
            if self.expiredLisArr.count > 0 {
                if withInMonth == 0 {
                    categories.append(Categories.init(categoryType: .movies, categoeyData: expiredLisArr as! [AnyObject], categoryName:"Expired Contracts".localized(), loadSection: false))
                }else{
                  
                    categories.append(Categories.init(categoryType: .movies, categoeyData: expiredLisArr as! [AnyObject], categoryName:"Expiring Contracts".localized(), loadSection: false))
                }
                
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            } else {
              
            }
        }
        else{
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
    
    func setdata(data: LeadModel) {
        
        self.leadListArr.removeAll()
        if data.status == "SUCCESS"{
            self.leadListArr.removeAll()
            self.leadListArr = data.data?.leadsList ?? []

            if leadListArr.count != 0 {
                categories.append(Categories.init(categoryType: .sports, categoeyData: leadListArr as! [AnyObject], categoryName:"Insurance request".localized(), loadSection: false))
                
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                }
            }else {
            
            }
        }else {
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
    
    
    func deletAgenda(data: AddNewAgendaModel) {
        
        if data.status == "SUCCESS"{
            self.callApiinDispatchGrp()
           
        }
        else{
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
    
    
    //MARK:- Set agenda list Data
    
    func setAgendaLst(data: AgendaModel) {
        
        agendaListArr.removeAll()
        if data.status == "SUCCESS"{
           
            agendaListArr = data.data?.agendaList ?? []
            
            if agendaListArr.count == 0 {
                
                DispatchQueue.main.async {

                    self.homeTableView.reloadData()
                }
                
            }else {
                if isCategoriesData("Appoinments") {
                    categories.append(Categories.init(categoryType: .news, categoeyData:agendaListArr as! [AnyObject] , categoryName:"Appoinments".localized(), loadSection: true))
                } else {
                    categories.append(Categories.init(categoryType: .news, categoeyData:agendaListArr as! [AnyObject] , categoryName:"Appoinments".localized(), loadSection: false))
                }
                DispatchQueue.main.async {

                    self.homeTableView.reloadData()
                }
            }
            
        }
        else{
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
    
    func isCategoriesData(_ catName: String) -> Bool {
        var count = -1
        var isPresent = false
        for i in categories {
            count += 1
            if i.categoryName == catName {
                categories.remove(at: count)
                isPresent = true
            }
        }
        return isPresent
    }
    //MARK:- After Update Agenda
    func AddNewAgenda(data: AddNewAgendaModel) {
        
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                self.reloadAgendaListDelegate?.reloadAgendaList(setValue: "done")
                self.popVC(animated: true)
            }
        }
        else{
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

    
}

extension HomeVC: NotificationDelegate{
  
    func setData(data: NotificationModel) {
        //   notificationListArr
        if data.status == "SUCCESS"{
            notificationListArr.removeAll()
            notificationListArr = data.data?.notificationList ?? []
            if notificationListArr.count != 0 {
                DispatchQueue.main.async {
                    if let tabItems = self.tabBarController?.tabBar.items {
                        // In this case we want to modify the badge number of the third tab:
                        let totalCount = kUserDefaults.value(forKey: AppKeys.totalNotification)
                        if totalCount == nil{
                            
                        }else {
                            let countValue = totalCount as! Int
                            //  print(countValue)
                            if countValue == self.notificationListArr.count{
                                let tabItem = tabItems[1]
                                tabItem.badgeValue = nil
                            }else{
                                let updateValue = self.notificationListArr.count - countValue
                                let tabItem = tabItems[1]
                                tabItem.badgeValue = "\(updateValue)"
                            }
                        }
                    }
                    
                }
            }else{
  
            }
            
        }
      else{
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

}


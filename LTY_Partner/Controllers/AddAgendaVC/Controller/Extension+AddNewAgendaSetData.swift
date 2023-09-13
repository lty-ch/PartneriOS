//
//  Extension+AddNewAgendaSetData.swift
//  LTY_Partner
//
//  Created by Chawtech on 25/07/23.
//

import Foundation

extension AddNewAgendaVC : AddNewAgendaProtocolDelegate {
    func getAgendaDetail(data: GetAgendaDModel) {
        
        if data.status == "SUCCESS"{
            var dict = data.data?.users as! NSDictionary
            
            self.memberNameArr = NSMutableArray(array: dict.allValues)
            self.memberIdArr = NSMutableArray(array: dict.allKeys)
            self.createMemberList(self.memberIdArr)
            
            DispatchQueue.main.async {
                self.textDescription.text = data.data?.description ?? ""
                self.textStartTime.text = data.data?.timeFrom ?? ""
                self.lblSelectMember.text = self.memberNameArr.componentsJoined(by: ",")
               // var joineesArr = NSMutableArray(array: dict)
                 //   self.textSelectMember.text = joineesArr.componentsJoined(by: ",")
                self.textTask.text = data.data?.task ?? ""
                self.textEndTime.text = data.data?.timeTo ?? ""
                self.textMeetingDate.text = data.data?.date ?? ""
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
    
    func createMemberList(_ memberIdArr:NSMutableArray) {
        
        for item in  self.customerListArr {
            var count = -1
            var info = item
            for item2 in memberIdArr{
                count += 1
                if item.userId == item2 as! String {
                    info.isSelected = "yes"
                    self.customerListArr.remove(at: count)
                    self.customerListArr.insert(info, at: count)
                    break
                }
            }
        }
        //print(customerListArr)
    }
    
    func AddNewAgenda(data: AddNewAgendaModel) {
        
        if data.status == "SUCCESS"{
            DispatchQueue.main.async {
                self.reloadAgendaListDelegate?.reloadAgendaList(setValue: "done")
                self.popVC(animated: true)
                let userInfo: [AnyHashable : Any] = ["CallApi":"true"]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CallAgendaApiDashborad"), object: nil, userInfo: userInfo)
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
 
}

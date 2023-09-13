//
//  Extension+NotificationSetData.swift
//  LTY_Partner
//
//  Created by Chawtech on 28/08/23.
//

import Foundation

extension NotificationVC: NotificationDelegate{
  
    func setData(data: NotificationModel) {
        //   notificationListArr
        if data.status == "SUCCESS"{
            notificationListArr.removeAll()
            notificationListArr = data.data?.notificationList ?? []
            if notificationListArr.count != 0 {
                kUserDefaults.set(notificationListArr.count, forKey:AppKeys.totalNotification)

                notifiacationTable.isHidden = false
                emptyView.isHidden = true
            }else{
                emptyView.isHidden = false
                notifiacationTable.isHidden = true
            }
            notifiacationTable.reloadData()
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

    func popupMsg(msg: String) {
        DispatchQueue.main.async {
            self.ShowAlert(message: msg)
        }
    }
    
    
}

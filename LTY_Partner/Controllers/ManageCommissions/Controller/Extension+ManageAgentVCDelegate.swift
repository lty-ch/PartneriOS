//
//  Extension+ManageAgentVCDelegate.swift
//  LTY_Partner
//
//  Created by CTS on 24/05/23.
//

import Foundation

extension ManageCommissionVC : ManageCommessionprotocolDelegate {
    func checkStatus(data: SuccessModel) {
        if data.status == "SUCCESS" {
            self.popVC(animated: true)
         
        }
        else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      self.doneBtn.isUserInteractionEnabled = true
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
    
    func showMsg(msg: String) {
        DispatchQueue.main.async {
            
            self.ShowAlert(message: msg)
        }
    }
    
    
}

//extension ManageCommissionVC : SelectCatProtocolDelegate {
//    
//    func setSubCatList(data: SelectSubCatModel) {
//           print("SUCCESS")
//       }
//    
//    func setMainCatList(data: SelectCatResponse) {
//        if data.status == "SUCCESS" {
//            
//            self.catagoryList = data.data?.categoryList! ?? []
//        }
//        else {
//            //            if data.error?.errorCode == AppKeys.invalidTokenCode {
////                self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
////            }else {
////                self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
////            }
//            self.ShowAlert(message: data.error?.serverErrorMessage ?? "")
//        }
//    }
//    
//    func setAddproductList(data: SuccessModel) {
//        print("No need")
//    }
//    
//    func popupMsg(msg: String) {
//        print("No need")
//    }
//}

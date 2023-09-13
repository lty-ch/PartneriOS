//
//  SelectCatCell.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 23/05/23.
//

import UIKit

class SelectCatCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var lblCommission: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var cellComissionTxt: CustomTextField!
    @IBOutlet weak var cellProductTxt: CustomTextField!
    
    
    
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
        
        self.cellComissionTxt.delegate = self
        self.cellProductTxt.delegate = self
        lblProduct.text = "Insurance Coverage".localized()
        lblCommission.text = "Commission".localized()

//        self.cellComissionTxt.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.cellComissionTxt.addTarget(self, action: #selector(commissionEdited), for:UIControl.Event.editingChanged)
        self.cellProductTxt.addTarget(self, action: #selector(productNameEdited), for:UIControl.Event.editingChanged)
        
    }
    
    @objc func commissionEdited() {
           
           var selectedId = newProductArr[self.cellComissionTxt.tag].value(forKey: "productId") as! String
           var count = -1
           for item in newProductArr {
               count += 1
               if item.value(forKey: "productId") as! String == selectedId {
                   
                   var newProductDic = NSMutableDictionary()
                   newProductDic["productId"] = newProductArr[count].value(forKey: "productId")
                   
                   newProductDic["productName"] = newProductArr[count].value(forKey: "productName")
                   newProductDic["commission"] = self.cellComissionTxt.text
                   newProductArr.remove(at: count)
                   newProductArr.insert(newProductDic, at: count)
               }
           }




       }
       
    @objc func productNameEdited() {
        
        var selectedId = newProductArr[self.cellComissionTxt.tag].value(forKey: "productId") as! String
        var count = -1
        for item in newProductArr {
            count += 1
            if item.value(forKey: "productId") as! String == selectedId {
                
                var newProductDic = NSMutableDictionary()
                newProductDic["productId"] = newProductArr[count].value(forKey: "productId")
                newProductDic["productName"] = self.cellProductTxt.text
                newProductDic["commission"] = self.cellComissionTxt.text ?? ""
                newProductArr.remove(at: count)
                newProductArr.insert(newProductDic, at: count)
            }
        }
    }

    
//    @objc func textFieldDidChange() {
//
//        var selectedId = newProductArr[self.cellComissionTxt.tag].value(forKey: "productId") as! String
//        var count = -1
//        for item in newProductArr {
//            count += 1
//            if item.value(forKey: "productId") as! String == selectedId {
//
//                var newProductDic = NSMutableDictionary()
//                newProductDic["productId"] = newProductArr[count].value(forKey: "productId")
//                if textField == self.cellProductTxt {
//                    newProductDic["productName"] = textField.text
//                    newProductDic["commission"] = self.cellComissionTxt.text ?? ""
//                } else {
//                    newProductDic["productName"] = newProductArr[count].value(forKey: "productName")
//                    newProductDic["commission"] = textField.text
//                }
//                newProductArr.remove(at: count)
//                newProductArr.insert(newProductDic, at: count)
//            }
//        }
//
//
//
//
//    }

    //MARK:- SetUPView
    func setUpView() {
        
        lblProduct.textColor = Asset.Colors.gray1.color
        lblCommission.textColor = Asset.Colors.gray1.color
        
        cellProductTxt.textColor = Asset.Colors.darkGrayColor.color
        cellComissionTxt.textColor = Asset.Colors.darkGrayColor.color

        lblProduct.font = FontSize.size16
        lblCommission.font = FontSize.size16
        cellProductTxt.font = FontSize.size16
        cellComissionTxt.font = FontSize.size16
        
        
        lblProduct.text = LTYText.text_SelectCat_Product.localized()
        lblCommission.text = LTYText.text_SelectCat_Commission.localized()
    }
 
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        var selectedId = newProductArr[textField.tag].value(forKey: "productId") as! String
//        var count = -1
//        for item in newProductArr {
//            count += 1
//            if item.value(forKey: "productId") as! String == selectedId {
//
//                var newProductDic = NSMutableDictionary()
//                newProductDic["productId"] = newProductArr[count].value(forKey: "productId")
//                if textField == self.cellProductTxt {
//                    newProductDic["productName"] = textField.text
//                    newProductDic["commission"] = self.cellComissionTxt.text ?? ""
//                } else {
//                    newProductDic["productName"] = newProductArr[count].value(forKey: "productName")
//                    newProductDic["commission"] = textField.text
//                }
//                newProductArr.remove(at: count)
//                newProductArr.insert(newProductDic, at: count)
//            }
//        }
//
//
//
//
//    }

}

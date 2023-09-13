//
//  AgentSelectCell.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import UIKit


class AgentSelectCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var cellSelectBtn: UIButton!
    @IBOutlet weak var cellTf: UITextField!
    @IBOutlet weak var cellProductLbl: UILabel!
    @IBOutlet weak var uncheckBtn: UIButton!
    
    var productArr = NSMutableArray()
    var delegate : AgentProductAmountDelegate?
    var productList = [ProductListt]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellTf.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(self.productList)
        print(self.productArr)
        
        let info = self.productList[textField.tag]
        var count = -1
        for items in self.productArr {
            count += 1
            let item = items as! NSDictionary
            if info.productId ?? "" == item["productId"] as! String {
                var newProductDic = NSMutableDictionary()
                newProductDic["productName"] = info.productName ?? ""
                newProductDic["productNameInFrench"] = info.productNameInFrench ?? ""
                newProductDic["productId"] = info.productId ?? ""
                newProductDic["amount"] = Double(textField.text!) ?? 0.0
                newProductDic["isSelected"] = item["isSelected"] as! String

                self.productArr.removeObject(at: count)
                self.productArr.insert(newProductDic, at: count)
            }
        }

        print(self.productArr)
        self.delegate?.setProductAmountData(arr: self.productArr, nameArr: [])

    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let info = self.productList[textField.tag]
//        var count = -1
//        for items in self.productArr {
//            count += 1
//            let item = items as! NSDictionary
//            if info.productId ?? "" == item["productId"] as! String {
//                var newProductDic = NSMutableDictionary()
//                newProductDic["productName"] = info.productName ?? ""
//                newProductDic["productId"] = info.productId ?? ""
//                newProductDic["amount"] = Double(textField.text!)
//                newProductDic["isSelected"] = item["isSelected"] as! String
//
//                self.productArr.removeObject(at: count)
//                self.productArr.insert(newProductDic, at: count)
//            }
//        }
//
//        self.delegate?.setProductAmountData(arr: self.productArr)
//        return true
//    }
    
    
    @IBAction func onClickSelectAgent(_ sender: UIButton) {
        let info = self.productArr[sender.tag] as! NSMutableDictionary
        
        var dic = NSMutableDictionary()
        dic["productName"] = info["productName"] as! String
        if info["productNameInFrench"] == nil {
            dic["productNameInFrench"] = "" 
        }else{
            dic["productNameInFrench"] = info["productNameInFrench"] as! String
        }
        dic["productId"] = info["productId"] as! String
        dic["amount"] = info["amount"] as! Double
        
        
        if info["isSelected"] as! String == "no" {
            dic["isSelected"] = "yes"
            self.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
        } else {
            dic["isSelected"] = "no"
            self.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
        }
         
        self.productArr.removeObject(at: sender.tag)
        self.productArr.insert(dic, at: sender.tag)
        self.delegate?.setProductAmountData(arr: self.productArr, nameArr: [])
    }
    
    

}

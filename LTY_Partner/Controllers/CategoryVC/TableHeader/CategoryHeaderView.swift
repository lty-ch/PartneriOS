//
//  CategoryHeaderView.swift
//  LTY_Partner
//
//  Created by Chawtech on 18/08/23.
//

import UIKit

class CategoryHeaderView: UITableViewHeaderFooterView,UITextFieldDelegate {

    @IBOutlet weak var textSearch: UITextField!

    @IBOutlet weak var btnSearch: UIButton!
    var categoryViewModel = CategoryViewModel()
    
    var textFieldDidChange: ((String) -> Void)?
    
    func fill() {
        textSearch.delegate = self
      //  textSearch.text = model.textFieldData
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textFieldDidChange?(textSearch.text ?? "")
//
//
//        let param :[String:Any]  = ["searchBy":self.textSearch.text!]
//        categoryViewModel.productCommissionListApi(param: param, url: LTY_END_POINT_URL.getCategory)
//    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidChange?(textSearch.text ?? "")


        let param :[String:Any]  = ["searchBy":self.textSearch.text!]
        categoryViewModel.productCommissionListApi(param: param, url: LTY_END_POINT_URL.getCategory)
    }

}

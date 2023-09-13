//
//  UserRoleTableCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import UIKit

class UserRoleTableCell: UITableViewCell {

    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var writeView: UIView!
    @IBOutlet weak var btnDelete: UISwitch!
    @IBOutlet weak var lblDelete: UILabel!
    @IBOutlet weak var btnWrite: UISwitch!
    @IBOutlet weak var lblWrite: UILabel!
    @IBOutlet weak var btnRead: UISwitch!
    @IBOutlet weak var lblRead: UILabel!
    @IBOutlet weak var lblCategoryList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblRead.text = "Read".localized()
        self.lblWrite.text = "Write".localized()
        self.lblDelete.text = "Delete".localized()
    }

  
}

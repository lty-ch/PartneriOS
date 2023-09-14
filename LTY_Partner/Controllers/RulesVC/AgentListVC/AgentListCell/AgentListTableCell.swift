//
//  AgentListTableCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 26/06/23.
//

import UIKit

class AgentListTableCell: UITableViewCell {

    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblRoleTitle: UILabel!
    @IBOutlet weak var lblEmailtitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var editActionBtn: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblRoleTitle.text = "Email".localized()
        lblEmailtitle.text = "Role".localized()
        
    }

}

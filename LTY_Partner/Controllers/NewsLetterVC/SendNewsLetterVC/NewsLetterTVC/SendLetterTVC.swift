//
//  SendLetterTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/08/23.
//

import UIKit

class SendLetterTVC: UITableViewCell {

    @IBOutlet weak var lblTitleAgent: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitleAgent.text = "Agent".localized()
    }


    
}

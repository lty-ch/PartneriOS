//
//  LeadTableViewCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/06/23.
//

import UIKit

class LeadTableViewCell: UITableViewCell {
    

    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var leadID:UILabel!
    @IBOutlet weak var partner:UILabel!
    @IBOutlet weak var AgentType:UILabel!
    @IBOutlet weak var requestType:UILabel!
    @IBOutlet weak var cellNameLbl: UILabel!
    @IBOutlet weak var cellMailLbl: UILabel!
    @IBOutlet weak var cellPhoneLbl: UILabel!
    @IBOutlet weak var cellMenuBtn: UIButton!
    @IBOutlet weak var btncheckBox:UIButton!
    @IBOutlet weak var acceptedView:UIView!
    @IBOutlet weak var lblAccepted:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

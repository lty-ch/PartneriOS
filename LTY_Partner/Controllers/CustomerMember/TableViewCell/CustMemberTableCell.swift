//
//  CustMemberTableCell.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 15/06/23.
//

import UIKit

class CustMemberTableCell: UITableViewCell {

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
    
    @IBOutlet weak var cellRelationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }



}

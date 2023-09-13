//
//  SubmissionListTableViewCell.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import UIKit

class SubmissionListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblAddedOn: UILabel!
    @IBOutlet weak var lblEnquiredOn: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblRequestType: UILabel!
    
    @IBOutlet weak var AgentType:UILabel!
    @IBOutlet weak var cellNameLbl: UILabel!
    @IBOutlet weak var cellMenuBtn: UIButton!
    @IBOutlet weak var acceptedView:UIView!
    @IBOutlet weak var lblAccepted:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
}

//
//  HomeInsuranceTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/07/23.
//

import UIKit

class HomeInsuranceTVC: UITableViewCell {
    
    @IBOutlet weak var lblHeadingType: UILabel!
    @IBOutlet weak var lblHeadingAgentName: UILabel!
    @IBOutlet weak var lblHeadingEmail: UILabel!
    @IBOutlet weak var lblHeadingDate: UILabel!
    @IBOutlet weak var lblHeadingePhone: UILabel!
    @IBOutlet weak var lblHeadingRequest: UILabel!
    
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
        
        self.lblHeadingType.text = "Leads ID".localized()
        self.lblHeadingAgentName.text = "Agent".localized()
        self.lblHeadingEmail.text = "Email".localized()
        self.lblHeadingDate.text = "Date".localized()
        self.lblHeadingePhone.text = "Phone".localized()
        self.lblHeadingRequest.text = "Request Type".localized()
        
    }

}

//
//  FinStatementCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 13/07/23.
//

import UIKit

class FinStatementCell: UITableViewCell {
    
    @IBOutlet weak var lblTitlePolicyId: UILabel!
    @IBOutlet weak var lblTitleAgentName: UILabel!
    @IBOutlet weak var lblTitleStartDate: UILabel!
    @IBOutlet weak var lblTitleEndDate: UILabel!
    @IBOutlet weak var lblTitleGrossIncome: UILabel!
    @IBOutlet weak var lblTitlePartnerReserve: UILabel!
    @IBOutlet weak var lblTitleAgentCommisiion: UILabel!
    @IBOutlet weak var lblTitleAgentReserve: UILabel!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var policyIdLbl: UILabel!
    @IBOutlet weak var agentNameLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var endDateLbl: UILabel!
    @IBOutlet weak var grossIncomeLbl: UILabel!
    @IBOutlet weak var partnerReserveLbl: UILabel!
    @IBOutlet weak var agentCommissionLbl: UILabel!
    @IBOutlet weak var reserveLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLocalization()
    }

    func setLocalization(){
     
        self.lblTitlePolicyId.text =  "Policy ID".localized()
        self.lblTitleAgentName.text =  "Agent Name".localized()
        self.lblTitleStartDate.text =  "Start Date".localized()
        self.lblTitleEndDate.text =  "End Date".localized()
        self.lblTitleGrossIncome.text =  "Gross Income".localized()
        self.lblTitlePartnerReserve.text =  "Partner Reserve".localized()
        self.lblTitleAgentCommisiion.text =  "Commission".localized()
        self.lblTitleAgentReserve.text =  "Agent Reserve".localized()
    }

}

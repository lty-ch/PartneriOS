//
//  MemeberListCell.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 30/05/23.
//

import UIKit

class ProposalListCell: UITableViewCell {

    @IBOutlet weak var leadView: UIView!
    @IBOutlet weak var cellLeadId: UILabel!
    @IBOutlet weak var cellStatusLbl: UILabel!
    @IBOutlet weak var cellNameLbl: UILabel!
    @IBOutlet weak var cellMenuBtn: UIButton!
    @IBOutlet weak var cellPolicyIdLbl: UILabel!
    @IBOutlet weak var cellAgentLbl: UILabel!
    @IBOutlet weak var cellPartnerLbl: UILabel!
    @IBOutlet weak var cellAddedOnLbl: UILabel!
    @IBOutlet weak var cellUpdatedLbl: UILabel!
    @IBOutlet weak var cellMailLbl: UILabel!
    @IBOutlet weak var cellPhoneLbl: UILabel!
    @IBOutlet weak var cellSubcatLbl: UILabel!
    @IBOutlet weak var cellAddressLbl: UILabel!
    
    
    @IBOutlet weak var lblOfferId: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblAddedAt: UILabel!
    @IBOutlet weak var lblUpdateOn: UILabel!
    @IBOutlet weak var lblEmai: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblCat: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblLeadID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setData()
    }

    func setData() {
        self.lblOfferId.text = "Offer ID".localized()
        self.lblAgentName.text = "Agent".localized()
        self.lblCustomerName.text = "Customer".localized()
        self.lblAddedAt.text = "Added At".localized()
        self.lblUpdateOn.text = "Updated On".localized()
        self.lblEmai.text = "Email".localized()
        self.lblPhone.text = "Phone".localized()
        self.lblCat.text = "Product/coverage".localized()
        self.lblAddress.text = "Address".localized()
        self.lblLeadID.text = "Lead ID".localized()
    }

}

//
//  HomeExpiringTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/07/23.
//

import UIKit

class HomeExpiringTVC: UITableViewCell {
   
    @IBOutlet weak var lblHeadingType: UILabel!
    @IBOutlet weak var lblHeadingAgentName: UILabel!
    @IBOutlet weak var lblHeadingPlicy: UILabel!
    @IBOutlet weak var lblHeadingStartDate: UILabel!
    @IBOutlet weak var lblHeadingeEndDate: UILabel!
    @IBOutlet weak var lblHeadingInsuranceProduct: UILabel!
    
    @IBOutlet weak var lblAcceptecd: UILabel!
    @IBOutlet weak var cellViewBtn: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSubCat: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblPolicyNo: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var cellAgentNameLbl: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblHeadingType.text = "Type".localized()
        self.lblHeadingAgentName.text = "Agent Name".localized()
        self.lblHeadingPlicy.text = "Policy Number".localized()
        self.lblHeadingStartDate.text = "Start Date".localized()
        self.lblHeadingeEndDate.text = "End Date".localized()
        self.lblHeadingInsuranceProduct.text = "Insurance Product".localized()
      
    }


}

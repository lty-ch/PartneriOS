//
//  custMemberContractCell.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 19/06/23.
//

import UIKit

class custMemberContractCell: UITableViewCell {

    @IBOutlet weak var lblTitleInsurnanceType: UILabel!
    @IBOutlet weak var lblInsuranceType: UILabel!
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
        lblTitleInsurnanceType.text = "Insurnance Type".localized()
    }


}

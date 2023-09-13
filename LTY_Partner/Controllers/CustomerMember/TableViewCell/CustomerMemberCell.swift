//
//  CustomerMemberCell.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

class CustomerMemberCell: UITableViewCell {

    @IBOutlet weak var cellViewBtn: UIButton!
    @IBOutlet weak var cellMainLbl: UILabel!
    @IBOutlet weak var cellTypeLbl: UILabel!
    @IBOutlet weak var cellEmailLbl: UILabel!
    @IBOutlet weak var cellPhoneLbl: UILabel!
    @IBOutlet weak var cellDobLbl: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CustomerListCell.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

class CustomerListCell: UITableViewCell {

    @IBOutlet weak var cellStatusLbl: UILabel!
    @IBOutlet weak var cellEmailLbl: UILabel!
    @IBOutlet weak var cellPhoneLbl: UILabel!
    @IBOutlet weak var cellTypeLbl: UILabel!
    @IBOutlet weak var cellDobLbl: UILabel!
    @IBOutlet weak var cellAgentLbl: UILabel!
    @IBOutlet weak var cellAddressLbl: UILabel!
    
    @IBOutlet weak var cellMenuBtn: UIButton!
    @IBOutlet weak var cellNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

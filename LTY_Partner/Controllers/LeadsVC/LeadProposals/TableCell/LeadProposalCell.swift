//
//  LeadProposalCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 13/06/23.
//

import UIKit

class LeadProposalCell: UITableViewCell {

    @IBOutlet weak var cellStatusLbl: UILabel!
    @IBOutlet weak var cellSubCatLbl: UILabel!
    @IBOutlet weak var cellPeriodicityLbl: UILabel!
    @IBOutlet weak var cellYearlyPriceLbl: UILabel!
    @IBOutlet weak var cellMonthlyPriceLbl: UILabel!
    @IBOutlet weak var cellNameLbl: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var cellImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

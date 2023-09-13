//
//  ProductsTableViewCell.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/23/23.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitleCommission: UILabel!
    @IBOutlet weak var lblTitleAdded: UILabel!
    @IBOutlet weak var lblTitleUpdatedOn: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var commissionLbl: UILabel!
    @IBOutlet weak var addedLbl: UILabel!
    @IBOutlet weak var updatedOnLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitleCommission.text = "Commission".localized()
        lblTitleAdded.text = "Added".localized()
        lblTitleUpdatedOn.text = "Updated On".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

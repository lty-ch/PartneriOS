//
//  SubCategoryTableViewCell.swift
//  LTY_Partner
//
//  Created by Ashish Nimbria on 5/23/23.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

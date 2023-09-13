//
//  AllUserTableViewCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/07/23.
//

import UIKit

class AllUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var employeeLeftSideImgView: UIImageView!
    @IBOutlet weak var employeeNameLbl: UILabel!
    @IBOutlet weak var employeeLastMsgLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

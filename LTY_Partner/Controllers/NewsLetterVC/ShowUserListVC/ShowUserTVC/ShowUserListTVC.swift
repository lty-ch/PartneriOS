//
//  ShowUserListTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/08/23.
//

import UIKit

class ShowUserListTVC: UITableViewCell {

    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

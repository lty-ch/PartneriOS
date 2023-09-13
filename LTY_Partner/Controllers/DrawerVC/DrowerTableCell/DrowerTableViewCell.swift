//
//  DrowerTableViewCell.swift
//  LTY_Partner
//
//  Created by CTS on 17/05/23.
//

import UIKit

class DrowerTableViewCell: UITableViewCell {

    
    @IBOutlet var imgImage: UIImageView!
    @IBOutlet var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.font = FontSize.size16
        lblName.textColor = Asset.Colors.gray2.color
    }


    
}

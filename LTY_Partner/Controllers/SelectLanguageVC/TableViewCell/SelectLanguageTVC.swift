//
//  SelectLanguageTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.
//

import UIKit

class SelectLanguageTVC: UITableViewCell {
    
    @IBOutlet weak var backGView: UIView!
    @IBOutlet weak var labelLanguageName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backGView.viewCorner(5)
        labelLanguageName.font = FontSize.size16
        labelLanguageName.textColor = Asset.Colors.darkGrayColor.color

    }
    
}

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
        backGView.layer.borderWidth = 0.5
        backGView.layer.borderColor = UIColor.black.cgColor
        
        backGView.backgroundColor = .white

        backGView.layer.cornerRadius = 8.0

        backGView.layer.shadowColor = UIColor.darkGray.cgColor

        backGView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        backGView.layer.shadowRadius = 6.0

        backGView.layer.shadowOpacity = 0.7
        labelLanguageName.font = FontSize.size16
        labelLanguageName.textColor = Asset.Colors.blackColor.color

    }
    
}

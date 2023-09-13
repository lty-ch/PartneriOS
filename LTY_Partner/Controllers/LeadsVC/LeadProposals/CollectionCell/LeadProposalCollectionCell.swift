//
//  LeadProposalCollectionCell.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/08/23.
//

import UIKit

class LeadProposalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var lblMonthly: UILabel!
    @IBOutlet weak var lblYearly: UILabel!
    @IBOutlet weak var lblMonthlyPrice: UILabel!
    @IBOutlet weak var lblYearlyPrice: UILabel!
    @IBOutlet weak var imageAccepted: UIImageView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAccepted: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imageDash2: UIImageView!
    @IBOutlet weak var imagedash: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        btnSend.layer.cornerRadius = 4
        btnSend.layer.borderColor = Asset.Colors.blueColor.color.cgColor
        btnSend.layer.borderWidth = 1
       // imagedash.image =
       // imageDash2.image =
    }

}

//
//  GetStartedCVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/05/23.
//

import UIKit

class GetStartedCVC: UICollectionViewCell {

    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var imgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.viewCorner(10)
        
       // lblTitle.textColor = Asset.Colors.gray1.color
        lblTitle.font = UIFont(name:"Helvetica",size:14)
//        lblSubTitle.font = UIFont(name:"Helvetica",size:14)
       // lblSubTitle.textColor = Asset.Colors.lightGray.color
    }

}

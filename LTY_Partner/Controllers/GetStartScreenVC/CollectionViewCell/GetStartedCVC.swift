//
//  GetStartedCVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/05/23.
//

import UIKit

class GetStartedCVC: UICollectionViewCell {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var imgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.viewCorner(10)
    }

}

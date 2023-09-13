//
//  HomeCollectionCell.swift
//  LTY_Partner
//
//  Created by CTS on 18/05/23.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var labelEventName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.viewCorner(8)
        labelEventName.font = FontSize.size14

    }
    override var isSelected: Bool{
          didSet(newValue){
              
             // mainView.backgroundColor = newValue ? UIColor.green : UIColor.white
              
              if newValue == true {
                  mainView.backgroundColor = Asset.Colors.blueColor.color
                  labelEventName.textColor = Asset.Colors.whiteColor.color
              }
              else {
                  mainView.backgroundColor = Asset.Colors.grayColor.color
                  labelEventName.textColor = Asset.Colors.darkGrayColor.color
              }
          }
      }

}

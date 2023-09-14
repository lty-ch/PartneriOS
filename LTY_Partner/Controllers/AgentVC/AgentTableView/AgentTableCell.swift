//
//  AgentTableCell.swift
//  LTY_Partner
//
//  Created by CTS on 19/05/23.
//

import UIKit

class AgentTableCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var centerConstant: NSLayoutConstraint!
    
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var lblHeadingDob: UILabel!
    @IBOutlet weak var lblHeadingCust: UILabel!
    @IBOutlet weak var lblHeadingEmail: UILabel!
    @IBOutlet weak var lblHeadingPhone: UILabel!
    @IBOutlet weak var lblHeadingAddress: UILabel!
    
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var labelMobile: UILabel!
    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelCustomers: UILabel!
    @IBOutlet weak var btnCommissions: UIButton!

    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblRoleHeading: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
        
        let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
        let result = language as! NSArray
        
        if result[0] as! String == "fr" {
            centerConstant.constant = 55
        }else{
            centerConstant.constant = 10
        }

    }

    func setUpUI() {
        
        
      
        mainView.viewCorner(25)
        lblRoleHeading.font = FontSize.boldsize14
        lblAge.font = FontSize.boldsize14
        labelStatus.font = FontSize.size12
        lblHeadingDob.font = FontSize.boldsize14
        lblHeadingCust.font = FontSize.boldsize14
        lblHeadingPhone.font = FontSize.boldsize14
        lblHeadingEmail.font = FontSize.boldsize14
        lblHeadingAddress.font = FontSize.boldsize14
        
        lblRoleHeading.text = LTYText.text_AgentRole.localized()
        lblAge.text = LTYText.text_AgentAge.localized()
        lblHeadingDob.text = LTYText.text_AgentDob.localized()
        lblHeadingPhone.text = LTYText.text_AgentPhone.localized()
        lblHeadingEmail.text = LTYText.text_AgentEmail.localized()
        lblHeadingCust.text = LTYText.text_AgentCustomers.localized()
        lblHeadingAddress.text = LTYText.text_AgentAddress.localized()

        lblAge.textColor = Asset.Colors.blackColor.color
        lblHeadingDob.textColor = Asset.Colors.blackColor.color
        lblHeadingPhone.textColor = Asset.Colors.blackColor.color
        lblHeadingEmail.textColor = Asset.Colors.blackColor.color
        lblHeadingCust.textColor = Asset.Colors.blackColor.color
        lblHeadingAddress.textColor = Asset.Colors.blackColor.color

        
        labelName.font = FontSize.size16
        labelDate.font = FontSize.size14
        labelYear.font = FontSize.size14
        labelEmail.font = FontSize.size16
        labelMobile.font = FontSize.size14
        labelLocation.font = FontSize.size14
        labelCustomers.font = FontSize.size16
        
        labelName.textColor = Asset.Colors.skyBlue.color
        labelDate.textColor = Asset.Colors.gray1.color
        labelYear.textColor = Asset.Colors.blackColor.color
        labelEmail.textColor = Asset.Colors.blackColor.color
        labelMobile.textColor = Asset.Colors.gray1.color
        labelLocation.textColor = Asset.Colors.gray1.color
        labelCustomers.textColor = Asset.Colors.gray1.color


       // btnEdit.backgroundColor = Asset.Colors.lightSkyBlue.color
        mainView.backgroundColor = Asset.Colors.whiteColor.color
  
        
        
    }
    
}

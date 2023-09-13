//
//  AgentCommTableViewCell.swift
//  LTY_Partner
//
//  Created by CTS on 25/05/23.
//

import UIKit

class AgentCommTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var showBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var showBtnStackView: UIStackView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubCat: UILabel!
    @IBOutlet weak var lblCompReseve: UILabel!
    @IBOutlet weak var lblUpdated: UILabel!
    @IBOutlet weak var lblAgentReserve: UILabel!
    @IBOutlet weak var lblAgentCommission: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var labelSubCatData: UILabel!
    @IBOutlet weak var labelCatData: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUpdateData: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var labelAgentReservData: UILabel!
    @IBOutlet weak var labelCommissionData: UILabel!
    @IBOutlet weak var labelCompData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
    }

    //MARK:- SetUp UI
    
    func setUpUI() {
        //btnEdit.viewCorner(6)
        //btnDelete.viewCorner(6)
        mainView.viewCorner(25)
        
        //btnEdit.titleLabel?.font = FontSize.size14
        //btnDelete.titleLabel?.font = FontSize.size14
        
        lblCategory.font = FontSize.boldsize14
        lblSubCat.font = FontSize.boldsize14
        lblCompReseve.font = FontSize.boldsize14
        lblAgentReserve.font = FontSize.boldsize14
        lblUpdated.font = FontSize.boldsize14
        lblAgentCommission.font = FontSize.boldsize14
        
        lblCategory.text = LTYText.text_Agent_Comm_Category.localized()
        lblSubCat.text = LTYText.text_Agent_Comm_SubCategory.localized()
        lblAgentReserve.text = LTYText.text_Agent_Comm_Agent_Reserve.localized()
        lblUpdated.text = LTYText.text_Agent_Comm_Added.localized()
        lblCompReseve.text = LTYText.text_Agent_Comm_CompReserve.localized()
        lblAgentCommission.text = LTYText.text_Agent_Comm_Agent_Comm.localized()

        lblCategory.textColor = Asset.Colors.blackColor.color
        lblSubCat.textColor = Asset.Colors.blackColor.color
        lblAgentReserve.textColor = Asset.Colors.blackColor.color
        lblUpdated.textColor = Asset.Colors.blackColor.color
        lblCompReseve.textColor = Asset.Colors.blackColor.color
        lblAgentCommission.textColor = Asset.Colors.blackColor.color

        
        labelName.font = FontSize.size16
        labelSubCatData.font = FontSize.size14
        labelCatData.font = FontSize.size14
        labelUpdateData.font = FontSize.size16
        labelAgentReservData.font = FontSize.size14
        labelCommissionData.font = FontSize.size14
        labelCompData.font = FontSize.size16
        
        labelName.textColor = Asset.Colors.skyBlue.color
        labelSubCatData.textColor = Asset.Colors.gray1.color
        labelCatData.textColor = Asset.Colors.blackColor.color
        labelUpdateData.textColor = Asset.Colors.blackColor.color
        labelAgentReservData.textColor = Asset.Colors.gray1.color
        labelCommissionData.textColor = Asset.Colors.gray1.color
        labelCompData.textColor = Asset.Colors.gray1.color


        //btnEdit.backgroundColor = Asset.Colors.lightSkyBlue.color
        //btnDelete.backgroundColor = Asset.Colors.lightSkyBlue.color
        mainView.backgroundColor = Asset.Colors.whiteColor.color
        
        //btnEdit.setTitleColor(Asset.Colors.blueColor.color, for: .normal)
        //btnDelete.setTitleColor(Asset.Colors.redColor.color, for: .normal)
        //btnEdit.setTitle("Edit".localized(), for: .normal)
        //btnDelete.setTitle("Delete".localized(), for: .normal)
        
        DispatchQueue.main.async{
            let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String
            if userType  == "AGENT" {
                self.btnDelete.isHidden = true

            }else{
                self.btnDelete.isHidden = false

            }
        }
        
    }
    
}

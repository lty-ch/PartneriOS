//
//  SearchCoverAnalysisTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 18/07/23.
//

import UIKit

class SearchCoverAnalysisTVC: UITableViewCell {

    @IBOutlet weak var lblTitleProposalLead: UILabel!
    @IBOutlet weak var lblTitleSignatureProposal: UILabel!
    @IBOutlet weak var lblTitleSignatureCat: UILabel!
    @IBOutlet weak var lblTitleSignatureSubCat: UILabel!
    @IBOutlet weak var lblTitleSignatureLead: UILabel!
   
    @IBOutlet weak var lblCat: UILabel!
    @IBOutlet weak var lblSubcat: UILabel!
    @IBOutlet weak var selectSubCatBtn: UIButton!
    @IBOutlet weak var selectCatBtn: UIButton!
    @IBOutlet weak var signaturePerLeadData: UILabel!
    @IBOutlet weak var lblSignatureSubCatData: UILabel!
    @IBOutlet weak var lblSignaturePerCatData: UILabel!
    @IBOutlet weak var lblSignatureData: UILabel!
    @IBOutlet weak var lblProposalData: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCat.text = "Select Category".localized()
        self.lblSubcat.text = "Select Subcategory".localized()
        self.lblTitleProposalLead.text = "Proposal / Lead".localized()
        self.lblTitleSignatureProposal.text = "Signature / Proposal".localized()
        
        self.lblTitleSignatureCat.text = "Sign / Company".localized()
        self.lblTitleSignatureSubCat.text = "Sign / Product".localized()
        self.lblTitleSignatureLead.text = "Sign / Lead".localized()
    }

}

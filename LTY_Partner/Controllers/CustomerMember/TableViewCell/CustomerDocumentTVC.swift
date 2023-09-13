//
//  CustomerDocumentTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 22/06/23.
//

import UIKit

class CustomerDocumentTVC: UITableViewCell {
    

    @IBOutlet weak var lblTitleType: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTitleAgent: UILabel!
    @IBOutlet weak var lblAgent: UILabel!
    @IBOutlet weak var lblTitleTotalFiles: UILabel!
    @IBOutlet weak var lblTotalFiles: UILabel!
    @IBOutlet weak var lblTitleLastFile: UILabel!
    @IBOutlet weak var lblLastFile: UILabel!
    @IBOutlet weak var lblTitleAddedBy: UILabel!
    @IBOutlet weak var lblAddedBy: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setLocalization () {
        self.lblTitleType.text = "Type".localized()
        self.lblTitleAgent.text = "Agent".localized()
        self.lblTitleTotalFiles.text = "Total Files Added".localized()
        self.lblTitleLastFile.text = "Last File Added On".localized()
        self.lblTitleAddedBy.text = "Added By".localized()
    }

}

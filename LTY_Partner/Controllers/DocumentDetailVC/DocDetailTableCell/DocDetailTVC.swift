//
//  DocDetailTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/07/23.
//

import UIKit

class DocDetailTVC: UITableViewCell {

    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblUploaded: UILabel!
    @IBOutlet weak var lblTitleUploadedBy: UILabel!
    @IBOutlet weak var lblUploadOn: UILabel!
    @IBOutlet weak var lbltitleUploadOn: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitleUploadedBy.text = "Uploaded  by".localized()
        lbltitleUploadOn.text = "Upload on".localized()
        btnView.setTitle("View".localized(), for: .normal)
    }

}

//
//  ContractDocCell.swift
//  LTY_Partner
//
//  Created by CTS on 16/08/23.
//

import UIKit

class ContractDocCell: UITableViewCell {

    @IBOutlet weak var cellViewBtn: UIButton!
    @IBOutlet weak var cellDownloadBtn: UIButton!
    @IBOutlet weak var cellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

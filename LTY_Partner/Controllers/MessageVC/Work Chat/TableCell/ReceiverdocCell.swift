//
//  ReceiverdocCell.swift
//  Skazule
//
//  Created by CTS-Jay Gupta on 07/06/23.
//

import UIKit

class ReceiverdocCell: UITableViewCell {
    
    var message: Message?{
        didSet{
            
            guard let message = self.message else { return }
            if message.timestamp != nil {
                let timeStamp = Date(timeIntervalSince1970: TimeInterval(message.timestamp!)! / 1000)
                self.lblTime.text = timeStamp.convertTimeInterval()
                self.lblDate.text = timeStamp.convertTimeInterval(format: "MMM d, yyyy")
            }
            self.lblMessage.text = "file.pdf"//message.content
        }
    }
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: 30)
    }
    
}

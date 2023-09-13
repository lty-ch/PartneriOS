//
//  SenderImageCell.swift
//  Skazule
//
//  Created by CTS-Jay Gupta on 07/06/23.
//

import UIKit
import SDWebImage
import FirebaseStorage

class SenderImageCell: UITableViewCell {
    
    var message: Message?{
        didSet{
            
            guard let message = self.message else { return }
            if message.timestamp != nil {
                let timeStamp = Date(timeIntervalSince1970: TimeInterval(message.timestamp!)! / 1000)
                self.lblTime.text = timeStamp.convertTimeInterval()
                self.lblDate.text = timeStamp.convertTimeInterval(format: "MMM d, yyyy")
            }
            let url = message.content ?? ""
            // DOWNLOAD_IMAGE_BASE_URL +
            if url != ""
            {
              self.Images.sd_setImage(with: URL(string: url), placeholderImage: nil)
                }

            }
        }
    
    
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var Images: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 30)
        Images.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 30)
    }

}

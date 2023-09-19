//
//  HomeTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 31/07/23.
//

import UIKit

class HomeTVC: UITableViewCell {

    @IBOutlet weak var lblHeadingJoiness: UILabel!
    @IBOutlet weak var lblHeadingMeetingHour: UILabel!
    @IBOutlet weak var lblHeadingTask: UILabel!
    @IBOutlet weak var lblHeadingDate: UILabel!

    
    @IBOutlet weak var lblMeetingHours: UILabel!
    @IBOutlet weak var lblJoinee: UILabel!
    @IBOutlet weak var lblTask: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var btnDeleteAgenda: UIButton!
    @IBOutlet weak var btnUpdateAgenda: UIButton!
    @IBOutlet weak var btnAddCalender: UIButton!

    @IBOutlet weak var lblAddCalender: UILabel!
    @IBOutlet weak var lblUpdate: UILabel!
    @IBOutlet weak var lblDelete: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDelete.text = "Delete".localized()
        self.lblUpdate.text = "Update".localized()
        self.lblAddCalender.text = "Add Calender".localized()
        
        self.lblHeadingJoiness.text = "Joiness".localized()
        self.lblHeadingMeetingHour.text = "Meeting Hours".localized()
        self.lblHeadingTask.text = "Task".localized()
        self.lblHeadingDate.text = "Date".localized()
    }

  
}

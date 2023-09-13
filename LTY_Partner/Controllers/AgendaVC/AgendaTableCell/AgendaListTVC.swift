//
//  AgendaListTVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import UIKit

class AgendaListTVC: UITableViewCell {

    @IBOutlet weak var lblDelete: UILabel!
    @IBOutlet weak var lblUpdate: UILabel!
    @IBOutlet weak var lblAddCalender: UILabel!
    @IBOutlet weak var lblTitleJoineeName: UILabel!
    @IBOutlet weak var lblTitleDate: UILabel!
    @IBOutlet weak var lblTitleMeetingHour: UILabel!
    @IBOutlet weak var lblTitleTask: UILabel!
    
    @IBOutlet weak var btnAddCalender: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblJoineeNames: UILabel!
    @IBOutlet weak var lblMeetingHours: UILabel!
    @IBOutlet weak var lblTask: UILabel!
    
    @IBOutlet weak var btnDeleteAgenda: UIButton!
    @IBOutlet weak var btnUpdateAgenda: UIButton!
    
    override func awakeFromNib() {
        setUpLocalization()
    }
    
    func setUpLocalization(){
        
        self.lblDelete.text = "Delete".localized()
        self.lblUpdate.text = "Update".localized()
        self.lblAddCalender.text = "Add Calender".localized()
        self.lblTitleJoineeName.text = "Joiness".localized()
        self.lblTitleDate.text = "Date".localized()
        self.lblTitleMeetingHour.text = "Meeting Hours".localized()
        self.lblTitleTask.text = "Task".localized()
    }
}

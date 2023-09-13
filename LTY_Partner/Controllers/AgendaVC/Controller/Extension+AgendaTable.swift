//
//  Extension+AgendaTable.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import Foundation
import UIKit

extension AgendaListVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendaListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = agendaTableView.dequeueReusableCell(withIdentifier: "AgendaListTVC") as! AgendaListTVC
        let info = agendaListArr[indexPath.row]
        cell.lblDate.text = returnDOB(date: info.date ?? "")
        cell.lblTask.text = info.task
        cell.lblMeetingHours.text = "\(String(describing: info.timeFrom ?? "")) to \(String(describing: info.timeTo ?? ""))"
        let dict = info.users! as NSDictionary
        let joineesArr = NSMutableArray(array: dict.allValues)
        cell.lblJoineeNames.text = joineesArr.componentsJoined(by: ",")
        
        cell.btnAddCalender.tag = indexPath.row
        cell.btnAddCalender.addTarget(self, action: #selector(SelectedDate(_:)), for: .touchUpInside)
        
        cell.btnUpdateAgenda.tag = indexPath.row
        cell.btnUpdateAgenda.addTarget(self, action: #selector(UpdateAgenda(_:)), for: .touchUpInside)
        
        cell.btnDeleteAgenda.tag = indexPath.row
        cell.btnDeleteAgenda.addTarget(self, action: #selector(DeleteAgenda(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func SelectedDate(_ sender : UIButton){
        print(sender.tag)
        let info = agendaListArr[sender.tag]
        
        let dateString: String = info.date ?? ""
        let numbers = dateString.components(separatedBy: "-")
        print(numbers)
        var year : String = numbers[0]
        var month : String = numbers[1]
        var day : String = numbers[2]
        
        let fromTimeString: String = info.timeFrom ?? ""
        let fromTimeNumbers = fromTimeString.components(separatedBy: ":")
        var fromTimeHour : String = fromTimeNumbers[0]
        var fromTimeMinutes : String = fromTimeNumbers[1]
        
        let toTimeString: String = info.timeTo ?? ""
        let toTimeNumbers = toTimeString.components(separatedBy: ":")
        var toTimeHour : String = toTimeNumbers[0]
        var toTimeMinutes : String = toTimeNumbers[1]
        
        var fromDate = DateComponents()
        fromDate.year = Int(year)
        fromDate.month = Int(month)
        fromDate.day = Int(day)
        //fromDate.timeZone = .current
        //  fromDate.timeZone = TimeZone(abbreviation: "IST")
        fromDate.hour = Int(fromTimeHour)
        fromDate.minute = Int(fromTimeMinutes)
        fromDate.second = 00
        let fromDateCalendar = Calendar.current
        // let fromDateCalendar = Calendar(identifier: .gregorian)
        //let timeInterval = (5*3600) + (1800)
        let fromDateAndTime = fromDateCalendar.date(from: fromDate)
        var toDate = DateComponents()
        toDate.year = Int(year)
        toDate.month = Int(month)
        toDate.day = Int(day)
        //toDate.timeZone = TimeZone(abbreviation: "IST")
        toDate.hour = Int(toTimeHour)
        toDate.minute = Int(toTimeMinutes)
        toDate.second = 00
        let toDateCalendar = Calendar.current
        // let toDateCalendar = Calendar(identifier: .gregorian)
        let toDateAndTime = toDateCalendar.date(from: toDate)
        //  let toDateAndTime = toDateCalendar.date(from: toDate)
        
        CalendarMan.sharedInstance.saveEventToCalendar(title: info.task ?? "", startDate: fromDateAndTime!, endDate: toDateAndTime!, notes: info.agendaListDescription) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.showToast(message: "Event Saved".localized(), font: FontSize.size12!)
                }
                
            } else {
                // An error occurred while saving the event
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Unknown error occurred.")
                }
            }
            
        }
    }
    
    
    @objc func UpdateAgenda(_ sender : UIButton){
        
        let vc = AddNewAgendaVC.instantiate(fromAppStoryboard: .agenda)
        let info = agendaListArr[sender.tag]
        vc.updateAgenda = true
        vc.updateAgendaId = info.id ?? 0
        vc.reloadAgendaListDelegate = self
        vc.meetingDate = info.date ?? ""
        pushToVC(vc, animated: true)
        
    }
    
    @objc func DeleteAgenda(_ sender : UIButton){
        let info = agendaListArr[sender.tag]
        let param:[String:Any] = ["ids": [info.id ?? 0]]
        
        agendaViewModel.deleteAgenda(param: param)
        
    }

}

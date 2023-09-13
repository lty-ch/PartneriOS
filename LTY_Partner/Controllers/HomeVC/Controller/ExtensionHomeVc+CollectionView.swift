//
//  ExtensionHomeVc+CollectionView.swift
//  LTY_Partner
//
//  Created by CTS on 18/05/23.
//

import Foundation
import UIKit


//MARK:- this extension is use for tableView

extension HomeVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categories[section].loadSection {
            return categories[section].categoeyData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if categories[indexPath.section].categoryName == "Appoinments".localized() {
            
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as! HomeTVC
            cell.selectionStyle = .none
            let info =  categories[indexPath.section].categoeyData[indexPath.row] as! AgendaList
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = dateFormatter.date(from: info.date!)
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let resultString = dateFormatter.string(from: date!)

            cell.lblDate.text = resultString
            cell.lblTask.text = info.task
            cell.lblMeetingHours.text = "\(String(describing: info.timeFrom ?? "")) to \(String(describing: info.timeTo ?? ""))"
            let dict = info.users! as NSDictionary
            let joineesArr = NSMutableArray(array: dict.allValues)
            cell.lblJoinee.text = joineesArr.componentsJoined(by: ",")
            
            cell.btnAddCalender.tag = indexPath.row
            cell.btnAddCalender.addTarget(self, action: #selector(SelectedDate(_:)), for: .touchUpInside)

            cell.btnUpdateAgenda.tag = indexPath.row
            cell.btnUpdateAgenda.addTarget(self, action: #selector(UpdateAgenda(_:)), for: .touchUpInside)

            cell.btnDeleteAgenda.tag = indexPath.row
            cell.btnDeleteAgenda.addTarget(self, action: #selector(DeleteAgenda(_:)), for: .touchUpInside)

            
            return cell
            
            
        } else if categories[indexPath.section].categoryName == "Expired Contracts".localized() {
            
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeExpiringTVC", for: indexPath) as! HomeExpiringTVC
            cell.selectionStyle = .none
            
            let info =  categories[indexPath.section].categoeyData[indexPath.row] as! SubmissionProposalsList
        
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            cell.cellAgentNameLbl.text = fName + " " + lName
            cell.lblType.text = info.insuranceType ?? ""
            cell.lblAgentName.text = info.agentDetails?.agentName ?? "Unassigned".localized()
            cell.lblPolicyNo.text = info.policyDetails?.policyId ?? ""
            cell.lblSubCat.text = info.policyDetails?.categoryDetails?.subCategoryName ?? ""
            
            var dob = "\(info.memberDetails?.dob ?? "")"
            dob = dob.components(separatedBy: "T")[0]
            cell.lblDate.text = dob
            var StartDob = "\(info.policyDetails?.startDate ?? "" ?? "")"
            StartDob = StartDob.components(separatedBy: "T")[0]
            var endDob = "\(info.policyDetails?.endDate ?? "")"
            endDob = endDob.components(separatedBy: "T")[0]
            
            cell.lblStartDate.text = returnDob(date: StartDob)

            cell.lblEndDate.text = returnDob(date: endDob)
            
            cell.cellViewBtn.tag = indexPath.row
            cell.cellViewBtn.addTarget(self, action: #selector(expiryMenuAction(_:)), for: .touchUpInside)
            
            return cell
            
            
        } else if categories[indexPath.section].categoryName == "Insurance request".localized() {
            
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeInsuranceTVC", for: indexPath) as! HomeInsuranceTVC
            cell.selectionStyle = .none
            let info =  categories[indexPath.section].categoeyData[indexPath.row] as! LeadList
            
            cell.leadID.text = info.leadId
            if info.agentName == nil{
                cell.AgentType.text = "Unassigned".localized()
                
            }
            else{
                cell.AgentType.text = info.agentName
            }
            
            
            let fname = info.memberDetails?.firstName?.capitalized   ?? ""
            let lname = info.memberDetails?.lastName?.capitalized   ?? ""
            //cell.partner.text = fname + " " + lname

            cell.cellNameLbl.text = fname + " " + lname
            
            
            cell.cellMailLbl.text = info.memberDetails?.email
            cell.cellPhoneLbl.text = info.memberDetails?.mobile
            cell.requestType.text = info.metadata?.type
            var createdOnStr = info.createdOn ?? ""
            createdOnStr = createdOnStr.components(separatedBy: "T")[0]
            cell.date.text = returnDob(date: createdOnStr)
            
            cell.lblAccepted.text = info.status?.localized()
            cell.lblAccepted.textColor =  Asset.Colors.redColor.color
            cell.acceptedView.backgroundColor = Asset.Colors.grayColor.color
            
            cell.cellMenuBtn.tag = indexPath.row
            cell.cellMenuBtn.addTarget(self, action: #selector(menuActionBtn(_:)), for: .touchUpInside)
   
            return cell
        } else if categories[indexPath.section].categoryName == "Expiring Contracts".localized() {
            
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeExpiringTVC", for: indexPath) as! HomeExpiringTVC
            cell.selectionStyle = .none
            
            let info =  categories[indexPath.section].categoeyData[indexPath.row] as! SubmissionProposalsList
        
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            cell.cellAgentNameLbl.text = fName + " " + lName
            cell.lblType.text = info.insuranceType ?? ""
            cell.lblAgentName.text = info.agentDetails?.agentName ?? "Unassigned".localized()
            cell.lblPolicyNo.text = info.policyDetails?.policyId ?? ""
            cell.lblSubCat.text = info.policyDetails?.categoryDetails?.subCategoryName ?? ""
            
            var dob = "\(info.memberDetails?.dob ?? "")"
            dob = dob.components(separatedBy: "T")[0]
            cell.lblDate.text = dob
            var StartDob = "\(info.policyDetails?.startDate ?? "" ?? "")"
            StartDob = StartDob.components(separatedBy: "T")[0]
            var endDob = "\(info.policyDetails?.endDate ?? "")"
            endDob = endDob.components(separatedBy: "T")[0]
            cell.lblStartDate.text = returnDob(date: StartDob)
            cell.lblEndDate.text = returnDob(date: endDob)
            
            cell.cellViewBtn.tag = indexPath.row
            cell.cellViewBtn.addTarget(self, action: #selector(expiryMenuAction(_:)), for: .touchUpInside)
            
            return cell
            
            
        }
        
        
        return UITableViewCell()
    }
   
    func returnDob(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultString = dateFormatter.string(from: date!)
        
        return resultString
    }
    //  MARK:-  view for header in section func in tableview

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeHeaderView") as! HomeHeaderView
        
        headerView.btnDropDown.tag = section

        headerView.btnDropDown.addTarget(self, action:#selector(buttonCheckMarkAction(_:)), for: .touchUpInside)

        let dataNew = categories[section].categoryName
        headerView.labelHeaderTitle.text = dataNew
        return headerView

    } // END  view for header func
    
    
    @objc func buttonCheckMarkAction(_ sender:UIButton){
        
        categories[sender.tag].loadSection.toggle()
        homeTableView.reloadData()
    }
   
    
    //  MARK:-  view for footer in section func in tableview
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeFooterView") as! HomeFooterView
        footerView.viewMorebtn.layer.cornerRadius = 4
        
        let showBtn = categories[section].loadSection
        if showBtn == true {
            footerView.viewMorebtn.isHidden = false
            footerView.viewMorebtn.setTitle("View More".localized(), for: .normal)
            footerView.viewMorebtn.tag = section
            footerView.viewMorebtn.addTarget(self, action:#selector(buttonFooterAction(_:)), for: .touchUpInside)
        }else{
            footerView.viewMorebtn.isHidden = true
        }
        
        return footerView
 
    }
    
    @objc func buttonFooterAction(_ sender:UIButton){
        print(sender.tag)
     let sectionName =  categories[sender.tag].categoryName
        if sectionName == "Appoinments".localized() {
            
            let vc = AgendaListVC.instantiate(fromAppStoryboard: .agenda)
            pushToVC(vc, animated: true)
            
        }else if sectionName == "Expired Contracts".localized(){
            let vc = ExoiringContractsVC.instantiate(fromAppStoryboard: .home)
            vc.withinMonth = 0
            pushToVC(vc, animated: true)
        }else if sectionName == "Expiring Contracts".localized(){
            let vc = ExoiringContractsVC.instantiate(fromAppStoryboard: .home)
            vc.withinMonth = 3
            pushToVC(vc, animated: true)
        }else if sectionName == "Insurance request".localized(){
            let vc = LeadListVC.instantiate(fromAppStoryboard: .leadStoryboard)
            pushToVC(vc, animated: true)
        }
      
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let showBtn = categories[section].loadSection
        if showBtn == true {
            return 60
        }
        return 0
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//40
    }
    
    //MARK:-  expiry menu action btn
    
    @objc func expiryMenuAction(_ sender: UIButton ){
        let vc = ContractDetailVC.instantiate(fromAppStoryboard: .customerStoryboard)
        
//        let info = expiredLisArr[sender.tag]
//
//        let fName = info.memberDetails?.firstName ?? ""
//        let lName = info.memberDetails?.lastName ?? ""
//        let signedDocs = info.signedDoc ?? []
//        let policyDocs = info.policyDetails?.policyDocs ?? []
//        vc.contractDictArr.append(ContractDetailModel.init(name: fName + " " + lName, endDate: info.policyDetails?.endDate ?? "", startDate:  info.policyDetails?.startDate ?? "", sumAssured: "", totalDuration: "", personCovered: "", benifits:info.policyDetails?.productBenefits ?? "", premiumTerm: info.policyDetails?.premiumAmount ?? 0, periodicity: info.commissionDetails?.frequency ?? "", email:  info.memberDetails?.email ?? "", agentName:  info.agentDetails?.agentName ?? "", policyNumber:  info.policyDetails?.policyId ?? "", policyName:info.policyDetails?.policyType ?? "", signedDoc: signedDocs, policyDoc: policyDocs))
//
//        pushToVC(vc, animated: true)
        
        
        let info = self.expiredLisArr[sender.tag]
        
        let fName = info.memberDetails?.firstName?.capitalized   ?? ""
        let lName = info.memberDetails?.lastName?.capitalized   ?? ""
        let signedDocs = info.signedDoc ?? []
        let policyDocs = info.policyDetails?.policyDocs ?? []
        let contractDoc = info.contractDoc ?? []
        vc.contractDictArr.append(ContractDetailModel.init(totalAmount:info.policyDetails?.totalAmount ?? 0, category:info.policyDetails?.categoryDetails?.categoryName ?? "", subCategory:info.policyDetails?.categoryDetails?.subCategoryName ?? "", name: fName + " " + lName, endDate: info.policyDetails?.endDate ?? "", startDate:  info.policyDetails?.startDate ?? "", sumAssured: "", totalDuration: "", personCovered: "", benifits:info.policyDetails?.productBenefits ?? "", premiumTerm: info.policyDetails?.premiumAmount ?? 0, periodicity:  info.policyDetails?.periodicity ?? "", email:  info.memberDetails?.email ?? "", agentName:  info.agentDetails?.agentName ?? "", policyNumber:  info.policyDetails?.policyId ?? "", policyName:info.policyDetails?.policyType ?? "", signedDoc: signedDocs, policyDoc: policyDocs,contractDoc: contractDoc))
        self.pushToVC(vc, animated: true)
    }
    
    //MARK:-  insurance menu actionbtn
    
    @objc func menuActionBtn(_ sender: UIButton ){
        let vc = ViewLeadVC.instantiate(fromAppStoryboard: .leadStoryboard)
        let index = sender.tag
        
        let info = leadListArr[index]
        vc.index = sender.tag
        vc.insuranceType = info.metadata?.type ?? ""
        vc.checkInsuranceDelegate = self
        vc.checkProposalDelegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    //MARK:- Appoinments Btn actions
    
    
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
                    print("Unknown error occurred.".localized())
                }
            }
            
        }
    }
    
    
    @objc func UpdateAgenda(_ sender : UIButton){
        
        let vc = AddNewAgendaVC.instantiate(fromAppStoryboard: .agenda)
        let info = agendaListArr[sender.tag]
        vc.updateAgenda = true
        vc.updateAgendaId = info.id ?? 0
        vc.meetingDate = info.date ?? ""
        vc.reloadAgendaListDelegate = self
        pushToVC(vc, animated: true)
        
    }
    
    @objc func DeleteAgenda(_ sender : UIButton){
        let info = agendaListArr[sender.tag]
        let param:[String:Any] = ["ids": [info.id ?? 0]]
        
        agendaViewModel.deleteAgenda(param: param)
        
    }

}

extension HomeVC: ReloadAgendaListDelegate {
    func reloadAgendaList(setValue: String) {
        if setValue == "done"{
            callApiinDispatchGrp()
        }
    }
}



extension HomeVC : checkInsuranceTypeDelegate, checkProposalDelegate{
    func checkInsuranceType(index: Int, insuranceType: String) {
        
        if insuranceType == "HEALTH"{
            let vc = HealthInsuranceVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "TERM_LIFE"{
            let vc = TermLifeVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "GENERAL"{
            let vc = GeneralRequestVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "TRAVEL"{
            let vc = TravelInsuranceVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "Proposal"{
            let vc = LeadProposalsVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.insurnceType = info.metadata?.type ?? ""
            vc.leadId = info.leadId ?? ""
            vc.agentName = info.agentName ?? ""
            vc.agentId = info.agentId ?? ""
            vc.status = info.status?.localized() ?? ""
            
            var memberNames = NSMutableArray()
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            
            memberNames.add(fName + " " + lName)
            UserDefaults.standard.set(fName + " " + lName, forKey: "memebrNameArr")
            
            var memberIds = NSMutableArray()
            
            memberIds.add(info.memberDetails?.memberId ?? "")
//            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(memberIds), forKey: "memberIds")

            UserDefaults.standard.set(memberIds, forKey: "memberIds")
            
            
            pushToVC(vc, animated: true)
            
        }else {
            print(index,insuranceType)
            
        }
        
    }
    
    
}

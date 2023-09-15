//
//  Extension+TableViewDelegate.swift
//  LTY_Partner
//
//  Created by CTS on 19/05/23.
//
import Foundation
import UIKit

extension AgentVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agentListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewAgentVC.dequeueReusableCell(withIdentifier: "AgentTableCell") as! AgentTableCell
        
        let fName = agentListData[indexPath.row].firstName ?? ""
        let lName = agentListData[indexPath.row].lastName ?? ""
        cell.labelName.text = fName.capitalized + " " + lName.capitalized
        var dob = "\(agentListData[indexPath.row].dob ?? "")"
        dob = dob.components(separatedBy: "T")[0]
        if dob != "" {
            cell.labelYear.text = "\(self.calcAge(birthday: dob)) Years"
        }
        cell.labelEmail.text = agentListData[indexPath.row].email
     

        cell.labelDate.text = returnDOB(date:agentListData[indexPath.row].dob!)
        let countryCode = agentListData[indexPath.row].countryCode ?? ""
        cell.labelMobile.text = "\(countryCode) \(agentListData[indexPath.row].mobile ?? "")"
        cell.labelLocation.text = agentListData[indexPath.row].address
        cell.labelCustomers.text = "\(String(describing: agentListData[indexPath.row].customerCount ?? 0))"
        cell.lblRole.text = agentListData[indexPath.row].roleName
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(btnEditAction(sender:)), for: .touchUpInside)
      
        if agentListData[indexPath.row].partnerState == "ACTIVE" {
            cell.labelStatus.textColor = UIColor.systemGreen
        } else {
            cell.labelStatus.textColor = UIColor.red
        }
        cell.labelStatus.text = agentListData[indexPath.row].partnerState?.localized()
    

        return cell
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "dd.mm.yyyy"
    // inputFormatter= the type of format you getting date from api other place
    //you can change the format according to your getting date
    if let date = inputFormatter.date(from: dateString) {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = format
    return outputFormatter.string(from: date)
    }
    return nil
    }
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        if birthday.contains(".") {
            print("dd.mm.yyyy")
            let replaced = birthday.replacingOccurrences(of: ".", with: "-")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: replaced)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let resultString = dateFormatter.string(from: date!)
            print(resultString)
            return 0
 
        }else {
            print("yyyy-MM-dd /\(birthday)")
            dateFormater.dateFormat = "yyyy-MM-dd"
            let birthdayDate = dateFormater.date(from: birthday)
            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
            let now = Date()
            let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
            let age = calcAge.year
            
            return age!
        }
        
//        if dateFormater.dateFormat == "yyyy-MM-dd" {
//            dateFormater.dateFormat = "yyyy-MM-dd"
//            let birthdayDate = dateFormater.date(from: birthday)
//            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
//            let now = Date()
//            let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
//            let age = calcAge.year
//
//            return age!
//        }else{
//            dateFormater.dateFormat = "dd.mm.yyyy"
//            let birthdayDate = dateFormater.date(from: birthday)
//            let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
//            let now = Date()
//            let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
//            let age = calcAge.year
//
//            return age!
//        }
       // return 0
    }
    
    /*

    
    //MARK:- Commesion btn Action
    
    
    @objc func btnCommissionAction(sender:UIButton) {
     
        let index = sender.tag
        guard agentListData[index].partnerId != nil else{ return }
            let vc = AgentCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
            vc.agentId = agentListData[index].partnerId ?? ""
            self.pushToVC(vc, animated: true)
    }
    
     */
    //MARK:- Edit btn Action
    
    @objc func btnEditAction(sender:UIButton) {
     
//        let index = sender.tag
//        guard agentListData[index].partnerId != nil else{ return }
//            let vc = ProfileVC.instantiate(fromAppStoryboard: .home)
//            vc.agentId = agentListData[index].partnerId ?? ""
//            vc.isCommingFrom = "Edit_agent_detail"
//            self.pushToVC(vc, animated: true)
        indexValue =  sender.tag
        let vc = EditAgentVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
        vc.delegateSendEditAgent = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.blockConfirmationMsg = agentListData[indexValue].partnerState ?? ""
        presentVC(vc, animated: true, presentationStyle: .overFullScreen)
        
    }
}


//MARK:- Extension for protocol

extension AgentVC : SendEditAgentData{
    func sendEditData(sendValue: String,checkBlockStatus: String) {
        blockStatus = checkBlockStatus
        
        switch sendValue {
        case "Profile" :
            
            let index = indexValue
            guard agentListData[index].partnerId != nil else{ return }
            let vc = AgentProfileVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
            vc.agentId = agentListData[index].partnerId ?? ""
            self.pushToVC(vc, animated: true)
            
        case "Edit" :
            
            let index = indexValue
            guard agentListData[index].partnerId != nil else{ return }
            let vc = ProfileVC.instantiate(fromAppStoryboard: .home)
            vc.agentId = agentListData[index].partnerId ?? ""
            vc.isCommingFrom = "Edit_agent_detail"
            self.pushToVC(vc, animated: true)
            
        case "Delete" :
            
            let index = indexValue
            checkNetwork(indexNo: index,type: "Delete")

        case "Commisssion" :
            let index = indexValue
            guard agentListData[index].partnerId != nil else{ return }
                let vc = AgentCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                vc.agentId = agentListData[index].partnerId ?? ""
                self.pushToVC(vc, animated: true)

        case "Block" :
            let index = indexValue
            if agentListData[index].partnerState ?? ""  == "ACTIVE" {
//                type = "BLOCKED"
                checkNetwork(indexNo: index,type: "BLOCKED")
            }
            else {
//                type = "ACTIVE"
                checkNetwork(indexNo: index,type: "ACTIVE")

            }
            
            
        case "UnBlock" :
            print("6")
            
        default:
            print("")
        }
        
    }

    // MARK:- Delete agent Api
    
    func checkNetwork(indexNo:Int,type:String){
        
        let partnerId =  agentListData[indexNo].partnerId
        
        if internetConnection.isConnectedToNetwork() == true {
            
            if type == "Delete" {
                
                let param :[String:Any]  = ["agentIds":[partnerId]]
                agentVCViewModel.agentDeleteApi(param: param)//agentListApi(param: param)
            }
            else {
                
                let param :[String:Any]  = ["partnerId": partnerId,"partnerState":type]
                agentVCViewModel.blockAgentApi(params: param)
                
            }
        }
            
        else {
            self.ShowAlert(message:LTY_AlterText.internetConnectionAlert)

        }
    }
    
    // MARK:- block / unblock Agent
    
    
  
}


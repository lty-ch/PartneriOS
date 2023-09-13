//
//  Extension+AllUsersVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 11/07/23.
//

import Foundation
import UIKit

extension AllUsersVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customerListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTable.dequeueReusableCell(withIdentifier: "AllUserTableViewCell", for: indexPath) as! AllUserTableViewCell
        let info = customerListArr[indexPath.row]
        let fName = info.firstName?.capitalized ?? ""
        let lName = info.lastName?.capitalized ?? ""
        cell.employeeNameLbl.text = fName + " " + lName
        cell.employeeLastMsgLbl.text = info.email
        cell.employeeLeftSideImgView.sd_setImage(with:URL(string: info.profilePic ?? ""), placeholderImage:UIImage(named: "user"))
        cell.selectionStyle = .none
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WorkChatDetailChatVC.instantiate(fromAppStoryboard: .chatStoryboard)
        let info = customerListArr[indexPath.row]
        
        let fName = info.firstName?.capitalized ?? ""
        let lName = info.lastName?.capitalized ?? ""
  
        vc.senderId = info.userId ?? ""
        vc.senderName = fName + " " + lName
        vc.senderEmail = info.email ?? ""
        vc.senerImage = info.profilePic ?? ""
        pushToVC(vc, animated: true)
    }
}

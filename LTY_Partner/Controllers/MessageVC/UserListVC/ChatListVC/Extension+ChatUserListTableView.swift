//
//  Extension+ChatUserListTableView.swift
//  LTY_Partner
//
//  Created by CTS on 05/07/23.
//

import Foundation
import UIKit

extension ChatuserListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTable.dequeueReusableCell(withIdentifier: "UserListTVC", for: indexPath) as! UserListTVC
        let info = userListArr[indexPath.row]
        cell.employeeNameLbl.text = info.name
        cell.employeeLastMsgLbl.text = info.lastMessage
        cell.employeeLeftSideImgView.sd_setImage(with:URL(string: info.profilePic ?? ""), placeholderImage:UIImage(named: "user"))
        cell.selectionStyle = .none
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WorkChatDetailChatVC.instantiate(fromAppStoryboard: .chatStoryboard)
        let info = userListArr[indexPath.row]
        vc.senderId = info.uid ?? ""
        vc.senderName = info.name ?? ""
        vc.senerImage = info.profilePic ?? ""
        vc.fcmKeyValue = info.fcmKey ?? ""
        pushToVC(vc, animated: true)
    }
}

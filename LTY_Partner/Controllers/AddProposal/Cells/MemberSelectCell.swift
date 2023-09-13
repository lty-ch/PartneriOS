//
//  MemberSelectCell.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import UIKit

class MemberSelectCell: UITableViewCell {

    @IBOutlet weak var cellSelectBtn: UIButton!
    @IBOutlet weak var cellNameLbl: UILabel!
    @IBOutlet weak var uncheckBtn: UIButton!
    
    var memberList = [AddProposalMembersModelUsersList]()
    var memberIdArr = NSMutableArray()
    var memberNameArr = NSMutableArray()
        
        var delegate : AgentProductAmountDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func onClickSelectAgent(_ sender: UIButton) {
//        let info = self.memberList[sender.tag]
//        let fName = info.firstName ?? ""
//        let lName = info.lastName ?? ""
//        
//        self.checkMemberBeforeAdding(id: info.userId ?? "", name: fName + " " + lName)
//    }
//        
//    func checkMemberBeforeAdding(id: String, name: String) {
//            if self.memberIdArr.count > 0 {
//                var count = -1
//                for item in memberIdArr {
//                    count += 1
//                    if item as! String == id {
//                        memberIdArr.removeObject(at: count)
//                        memberNameArr.removeObject(at: count)
//    //                    memberIdArr.insert(id, at: count)
//                    }else{
//                        self.memberIdArr.add(id)
//                        self.memberNameArr.add(name)
//                    }
//                }
//                self.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
//            } else {
//                self.memberIdArr.add(id)
//                self.memberNameArr.add(name)
//                self.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
//            }
//        self.delegate?.setProductAmountData(arr: memberIdArr, nameArr: self.memberNameArr)
//        }

}

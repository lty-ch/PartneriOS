//
//  MemberSelectVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 05/06/23.
//

import UIKit

class MemberSelectVC: UIViewController , AgentProductAmountDelegate{
    
    @IBOutlet weak var selectAllBtnImg: UIButton!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNvaBar: CustomNavigationBarForDrawer!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectAllBtn: UIButton!
    var memberList = [AddProposalMembersModelUsersList]()
    //    var AddProposalVM = AddProposalViewModel()
    var delegate : AgentProductAmountDelegate?
    var memberIdArr = NSMutableArray()
    var memberNameArr = NSMutableArray()
    var isEdit = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEdit {
            self.setPreviosValueSelection()
        } else {
            self.setSelection()
        }
        
        setDrowerHeight()
        customNvaBar.titleLabel.text = "Select Member".localized()
        customNvaBar.titleLabel.textAlignment = .center
        customNvaBar.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNvaBar.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        if memberList.count == 0 {
            DispatchQueue.main.async {
                
                self.noDataFoundView.isHidden = false
                self.tableView.isHidden = true
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.noDataFoundView.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
        
    }
    
    func setSelection() {
        var count = -1
        for items in memberList{
            count += 1
            var item = items
            if item.isSelected == nil{
                
                item.isSelected = "no"
                self.memberList.remove(at: count)
                self.memberList.insert(item, at: count)
            }
        }
        
        print(memberList)
        
    }
    
    func setPreviosValueSelection() {
        var count = -1
        for items in memberList{
            count += 1
            var item = items
            for olditem in memberIdArr{
                
                if item.userId ?? "" == olditem as! String {
                    
                    item.isSelected = "yes"
                    self.memberList.remove(at: count)
                    self.memberList.insert(item, at: count)
                }
            }
        }

    }
    
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }

    func setProductAmountData(arr: NSMutableArray, nameArr: NSMutableArray) {
        self.memberIdArr = arr
        self.memberNameArr = nameArr
    }
    
    @IBAction func onClickDone(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            self.delegate?.setProductAmountData(arr: self.memberIdArr, nameArr: self.memberNameArr)
        }
        
    }
    
    @IBAction func onClickSelectAll(_ sender: UIButton) {
        selectAllBtn.isSelected = !selectAllBtn.isSelected
        self.memberIdArr.removeAllObjects()
        self.memberNameArr.removeAllObjects()
        
        for i in 0..<memberList.count {
            if selectAllBtn.isSelected {
                memberList[i].isSelected = "yes"
                selectAllBtnImg.setImage(UIImage(named: "check"), for: .normal)
                self.memberIdArr.add(memberList[i].userId ?? "")
                let fName = memberList[i].firstName ?? ""
                let lName = memberList[i].lastName ?? ""
                self.memberNameArr.add(fName + " " + lName)
            } else {
                memberList[i].isSelected = "no"
                selectAllBtnImg.setImage(UIImage(named: "uncheck"), for: .normal)
                self.memberIdArr.removeAllObjects()
                self.memberNameArr.removeAllObjects()
            }
        }
        self.tableView.reloadData()
    }
    
}

extension MemberSelectVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberSelectCell", for: indexPath) as! MemberSelectCell
        
        let info = self.memberList[indexPath.row]
        let fname = info.firstName?.capitalized  ?? ""
        let lname = info.lastName?.capitalized  ?? ""
        cell.cellNameLbl.text = fname + " " + lname
//        cell.cellSelectBtn.tag = indexPath.row
//        cell.cellSelectBtn.addTarget(self, action: #selector(SelectBtn(_:)), for: .touchUpInside)
      //  cell.memberList = self.memberList
//        cell.delegate = self
//        cell.memberIdArr = self.memberIdArr
//        cell.memberNameArr = self.memberNameArr
        
        if info.isSelected == "yes"{
            cell.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
        } else {
            cell.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
        }
        
//        if self.memberIdArr.count > indexPath.row {
//            if info.userId == self.memberIdArr[indexPath.row] as! String {
//                cell.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
//            } else {
//                cell.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
//            }
//        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = self.memberList[indexPath.row]
        if info.isSelected == "yes"{
            info.isSelected = "no"
            self.memberList.remove(at: indexPath.row)
            memberList.insert(info, at: indexPath.row)
            self.memberIdArr.remove(info.userId ?? "")
            let fName = info.firstName?.capitalized  ?? ""
            let lName = info.lastName?.capitalized  ?? ""
            self.memberNameArr.remove(fName + " " + lName)
        } else {
            info.isSelected = "yes"
            self.memberList.remove(at: indexPath.row)
            memberList.insert(info, at: indexPath.row)
            self.memberIdArr.add(info.userId ?? "")
            let fName = info.firstName?.capitalized  ?? ""
            let lName = info.lastName?.capitalized  ?? ""
            self.memberNameArr.add(fName + " " + lName)
        }
        tableView.reloadData()
    }
    
    @objc func SelectBtn(_ sender: UIButton) {
        let info = self.memberList[sender.tag]
        let fName = info.firstName?.capitalized  ?? ""
        let lName = info.lastName?.capitalized  ?? ""
        
      if sender.isSelected == true {
          var item = self.memberList[sender.tag]
          item.isSelected = "yes"
          self.memberList.remove(at: sender.tag)
          memberList.insert(item, at: sender.tag)
          //  self.checkMemberBeforeAdding(id: info.userId ?? "", name: fName + " " + lName, index: sender.tag)
        }else{
            var item = self.memberList[sender.tag]
            item.isSelected = "no"
            self.memberList.remove(at: sender.tag)
            memberList.insert(item, at: sender.tag)

        }
    }
        
    func checkMemberBeforeAdding(id: String, name: String, index:Int) {
        print(memberList)
            if self.memberIdArr.count > 0 {
                var count = -1
                for item in memberIdArr {
                    count += 1
                    if item as! String == id {
                        memberList[index].isSelected = "no"
                        memberIdArr.removeObject(at: count)
                        memberNameArr.removeObject(at: count)
    //                    memberIdArr.insert(id, at: count)
                    }else{
                        memberList[index].isSelected = "yes"
                        self.memberIdArr.add(id)
                        self.memberNameArr.add(name)
                    }
                }
            } else {
                memberList[index].isSelected = "yes"
                self.memberIdArr.add(id)
                self.memberNameArr.add(name)
//                self.memberIdArr.insert(id, at: 0)
//                self.memberNameArr.insert(name, at: 0)
            }
        print(memberList)
        self.tableView.reloadData()
       // self.delegate?.setProductAmountData(arr: memberIdArr, nameArr: self.memberNameArr)
        }
    
}

//
//  MemberAgendaSelectVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 25/07/23.
//

import UIKit

protocol SetAgendaMembers {
    func setSelectedMemberList(arr:NSMutableArray, nameArr: NSMutableArray, memberList: [UsersList])
}


class MemberAgendaSelectVC: UIViewController {
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblSelectAll: UILabel!
    @IBOutlet weak var selectAllBtnImg: UIButton!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNvaBar: CustomNavigationBarForDrawer!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectAllBtn: UIButton!
    var memberList = [UsersList]()
    
    var delegate : SetAgendaMembers?
    var memberIdArr = NSMutableArray()
    var memberNameArr = NSMutableArray()
    var isEdit = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setDrowerHeight()
        customNvaBar.titleLabel.text = "Select Member".localized()
        lblSelectAll.text = "Select All".localized()
        btnDone.setTitle("Done".localized(), for: .normal)
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

    func setSelectedMemberList(arr: NSMutableArray, nameArr: NSMutableArray) {
        self.memberIdArr = arr
        self.memberNameArr = nameArr
    }
    
    @IBAction func onClickDone(_ sender: UIButton) {
        print(memberList)
        self.dismiss(animated: true) {
            self.delegate?.setSelectedMemberList(arr: self.memberIdArr, nameArr: self.memberNameArr, memberList: self.memberList)
        }
        
    }
    
    @IBAction func onClickSelectAll(_ sender: UIButton) {
        selectAllBtn.isSelected = !selectAllBtn.isSelected
        self.memberIdArr.removeAllObjects()
        self.memberNameArr.removeAllObjects()
        
        for i in 0..<memberList.count {
            if selectAllBtn.isSelected {
                memberList[i].isSelected = "yes"
                selectAllBtnImg.setImage(UIImage.init(named: "check"), for: .normal)
                self.memberIdArr.add(memberList[i].userId ?? "")
                let fName = memberList[i].firstName?.capitalized   ?? ""
                let lName = memberList[i].lastName?.capitalized   ?? ""
                self.memberNameArr.add(fName + " " + lName)
            } else {
                memberList[i].isSelected = "no"
                selectAllBtnImg.setImage(UIImage.init(named: "uncheck"), for: .normal)
                self.memberIdArr.removeAllObjects()
                self.memberNameArr.removeAllObjects()
            }
        }
        self.tableView.reloadData()
    }
}

extension MemberAgendaSelectVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectMemberAgendaCell", for: indexPath) as! selectMemberAgendaCell
        
        let info = self.memberList[indexPath.row]
        let fname = info.firstName?.capitalized  ?? ""
        let lname = info.lastName?.capitalized  ?? ""
        cell.cellNameLbl.text = fname + " " + lname
        
        if info.isSelected == "yes"{
            cell.uncheckBtn.setImage(UIImage.init(named: "check"), for: .normal)
        } else {
            cell.uncheckBtn.setImage(UIImage.init(named: "uncheck"), for: .normal)
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = self.memberList[indexPath.row]
        if info.isSelected == "yes"{
            info.isSelected = "no"
            self.memberList.remove(at: indexPath.row)
            memberList.insert(info, at: indexPath.row)
            self.memberIdArr.remove(info.userId ?? "")
            let fName = info.firstName?.capitalized   ?? ""
            let lName = info.lastName?.capitalized   ?? ""
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
}

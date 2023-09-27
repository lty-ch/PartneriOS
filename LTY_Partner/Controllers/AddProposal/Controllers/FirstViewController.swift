//
//  FirstViewController.swift
//  LTY_Partner
//
//  Created by Chawtech on 30/05/23.
//

import UIKit
import DropDown
class FirstViewController: UIViewController, AddPropsalMemberListProtocolDelegate, AgentProductAmountDelegate, ActiveUsersProtocolDeleagte {
    
    
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblChooseMembr: UILabel!
    @IBOutlet weak var lblPolicyVisibility: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var memberBtn: UIButton!
    @IBOutlet weak var policyBtn: UIButton!
    @IBOutlet weak var doneBtnStackView: UIStackView!
    @IBOutlet weak var nextBtnStackView: UIStackView!
    @IBOutlet weak var policyVisibiltyLbl: UILabel!
    @IBOutlet weak var chooseMembersLbl: UILabel!
    @IBOutlet weak var policyVisibiltyTxt: UITextField!
    @IBOutlet weak var chooseMebersTXT: UITextField!
    
    let policyVisibiltyDropDown = DropDown()
    let policyVisibiltyDropDownItem  = ["Private".localized(),"Group".localized()]
    
    let chooseMebersDropDown = DropDown()
    let chooseMebersDropDownItem  = ["Private".localized(),"All".localized(), "Wade Warren".localized(),"Jerome Bell".localized(),"Darell Steward ".localized(),"Floyed Miles".localized(),"Darlen Rabertson".localized(),"Albert Flores".localized()]
    
    var isComingFrom = ""
    
    var memberIdArr = NSMutableArray()
    var memberNameArr = NSMutableArray()
    var memberList = [AddProposalMembersModelUsersList]()
    var AddProposalVM = AddProposalViewModel()
    var delegate : updateProposalData?
    var updateDelegate : updateProposalEditDataFromMainListing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextLocalization()
        
        policyVisibiltyDropDown.anchorView = policyVisibiltyTxt
        policyVisibiltyDropDown.dataSource = policyVisibiltyDropDownItem
        policyVisibiltyDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.policyVisibiltyTxt.text = policyVisibiltyDropDownItem[Index]
        }
        
        chooseMebersDropDown.anchorView = chooseMebersTXT
        chooseMebersDropDown.dataSource = chooseMebersDropDownItem
        chooseMebersDropDown.selectionAction = {[unowned self] (Index:Int, item:String) in
            self.chooseMebersTXT.text = chooseMebersDropDownItem[Index]
        }
        
        AddProposalVM.proposalDelegate = self
        AddProposalVM.activeUsersDelegate = self
        
    }
    
    func setTextLocalization() {
        self.btnDone.setTitle("Done".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
        self.btnNext.setTitle("Next".localized(), for: .normal)
        self.lblChooseMembr.text = "Choose Member(s)".localized()
        self.lblPolicyVisibility.text = "Policy Visibility".localized()
        self.lblTitle.text = "Agent , Group And Customer Information".localized()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if isComingFrom == "LeadProposalVC" {
            self.policyBtn.isUserInteractionEnabled = false
            self.memberBtn.isUserInteractionEnabled = false
        } else {
            self.policyBtn.isUserInteractionEnabled = true
            self.memberBtn.isUserInteractionEnabled = true
        }
        
        if UserDefaults.standard.value(forKey: "fromLead") as! String == "yes" {
            policyVisibiltyTxt.text = "Private"
            policyBtn.isUserInteractionEnabled = false
            memberBtn.isUserInteractionEnabled = false
            
            let meberArr = UserDefaults.standard.value(forKey: "memebrNameArr") as! String
//            if meberArr != nil {
//                chooseMebersTXT.text = meberArr?.componentsJoined(by: ",")
//            }
            chooseMebersTXT.text = meberArr
            
//            guard  let UserData = UserDefaults.standard.value(forKey: "memberIds") as? Data  else {
//                return
//            }
//
//            let userRole = try? PropertyListDecoder().decode(LeadMemberDetails.self, from: UserData)

           
            //let memberIdsArr = UserDefaults.standard.value(forKey: "memberIds") as? NSMutableArray
            let memberIdsArr = UserDefaults.standard.value(forKey: "memberIds") as! NSArray
            
            let memberArr = memberIdsArr.mutableCopy() as! NSMutableArray
            
            addProposalDic.setValue(memberArr, forKey: "memberId")
            let arr = NSMutableArray()
            arr.add(meberArr)
            addProposalDic.setValue(arr, forKey: "memberNames")
            
            
            
            
        } else {
            policyBtn.isUserInteractionEnabled = true
            memberBtn.isUserInteractionEnabled = true
        }
        if isComingFrom == "EditVC" || isComingFrom == "ProposalVC" || isComingFrom == "LeadProposalVC" || isComingFrom == "ForEditProposal" || isComingFrom == "ContractVC" {
            setData()
            doneBtnStackView.isHidden = false
            nextBtnStackView.isHidden = true
        }else{
            doneBtnStackView.isHidden = true
            nextBtnStackView.isHidden = false
        }
        let agentId = addProposalDic.value(forKey: "agentId") as! String
        let partnerId = kUserDefaults.value(forKey: "partnerID") as! String
        let param: [String: Any] = ["agentId": agentId,"partnerId": partnerId, "searchBy": ""]
        if shouldEditMembers {
            policyBtn.isUserInteractionEnabled = true
            memberBtn.isUserInteractionEnabled = true
        } else {
            policyBtn.isUserInteractionEnabled = false
            memberBtn.isUserInteractionEnabled = false
        }
        
//        AddProposalVM.getMembersApi(param: param)
        print(param)
        AddProposalVM.getActiveUsers(param: param)
        
    }
    
    func setData(){
        policyVisibiltyTxt.text = addProposalDic["policyVisibility"] as? String
        let membersDetails = addProposalDic["memberNames"] as? NSMutableArray
        if membersDetails != nil {
            chooseMebersTXT.text = membersDetails?.componentsJoined(by: ",")
        }
    }
    
    func setActiveUsersList(data: AddProposalMembersModel) {
        
        if data.status == "SUCCESS" {
            
            self.memberList.removeAll()
            
            self.memberList = data.data?.usersList ?? []
            self.createMemberIdArr()
            
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
    }
    
    func setMembersList(data: AddProposalMembersModel) {
        
        if data.status == "SUCCESS" {
            
            self.memberList.removeAll()
            
            self.memberList = data.data?.usersList ?? []
            self.createMemberIdArr()
            
        } else {
            DispatchQueue.main.async {
                  if data.error?.errorCode == AppKeys.invalidTokenCode {
                      
                      LTY_AppDelegate.setRootVC()
                  }else {
                      DispatchQueue.main.async {
                          let language =  kUserDefaults.value(forKey: APPLE_LANGUAGE_KEY)
                          let result = language as! NSArray
                          
                          if result[0] as! String == "fr" {
                              self.ShowAlert(message: data.error?.clientErrorMessageInFrench ?? "")

                          }else{
                              self.ShowAlert(message: data.error?.clientErrorMessage ?? "")

                          }
                      }
                      
                  }
              }
          }
        
    }
    
    func createMemberIdArr() {
        self.memberIdArr.removeAllObjects()
        for item in self.memberList {
            self.memberIdArr.add(item.userId ?? "")
        }
    }
    
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        popVC(animated: true)
    }
    
    
    @IBAction func onClickPolicyVisibility(_ sender: Any) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for cat in policyVisibiltyDropDownItem {
            
            
            let action = UIAlertAction(title: cat, style: .default) { (action) in
                
                self.policyVisibiltyTxt.text = cat
                self.chooseMebersTXT.text = ""
                
            }
            
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onClickChooseMembers(_ sender: Any) {
        //        chooseMebersDropDown.show()
        
        if self.policyVisibiltyTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select policy visibility.".localized())
            return
        }
        
        if self.policyVisibiltyTxt.text == "Private" {
            
            let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            for cat in memberList {
                
                let fname = cat.firstName?.capitalized   ?? ""
                let lname = cat.lastName?.capitalized   ?? ""
                
                let action = UIAlertAction(title: fname + " " + lname, style: .default) { (action) in
                    
                    self.chooseMebersTXT.text = fname + " " + lname
                    self.memberIdArr.removeAllObjects()
                    self.memberIdArr.add(cat.userId ?? "")
                    addProposalDic.setValue(self.memberIdArr, forKey: "memberId")
                    self.memberNameArr.removeAllObjects()
                    self.memberNameArr.add(fname + " " + lname)
                    addProposalDic.setValue(self.memberNameArr ?? "", forKey: "memberNames")
                    
                }
                action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
                
                actionSheetAlertController.addAction(action)
            }
            
            let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            actionSheetAlertController.addAction(cancelActionButton)
            
            self.present(actionSheetAlertController, animated: true, completion: nil)
            
        } else {

            let vc = MemberSelectVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            if !chooseMebersTXT.text!.isEmpty {
                vc.memberIdArr = self.memberIdArr
                vc.memberNameArr = self.memberNameArr
                vc.isEdit = true
            } else {
                
                vc.isEdit = false
            }
            vc.memberList = self.memberList
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
     
            self.present(vc, animated: true)
        }
        
    }
    
    func setProductAmountData(arr: NSMutableArray, nameArr: NSMutableArray) {
        self.memberIdArr = arr
        self.memberNameArr = nameArr
        print(self.memberIdArr)
       // self.chooseMebersTXT.text = "Done".localized()
        var arr = NSMutableArray()
        for items in memberNameArr {
            arr.add(items)
        }
        self.chooseMebersTXT.text = arr.componentsJoined(by: ",")
        addProposalDic.setValue(self.memberIdArr, forKey: "memberId")
        addProposalDic.setValue(self.memberNameArr, forKey: "memberNames")
    }
    //MARK:- done action btn
    @IBAction func doneActionBtn(_ sender: UIButton) {
        if self.policyVisibiltyTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select policy visibility.".localized())
            return
        } else if self.chooseMebersTXT.text!.isEmpty {
            self.ShowAlert(message: "Please choose member.".localized())
            return
        }
        
        addProposalDic.setValue(self.policyVisibiltyTxt.text!, forKey: "policyVisibility")
        
        navigationController?.popViewControllerWithHandler(animated: true, completion: {
            if self.isComingFrom == "EditVC" {
                self.delegate?.updateData()
            } else {
                self.updateDelegate?.updateEditedDataFromMainListing()
            }
        })
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
        if self.policyVisibiltyTxt.text!.isEmpty {
            self.ShowAlert(message: "Please select policy visibility.".localized())
            return
        } else if self.chooseMebersTXT.text!.isEmpty {
            self.ShowAlert(message: "Please choose member.".localized())
            return
        }
        
        addProposalDic.setValue(self.policyVisibiltyTxt.text!, forKey: "policyVisibility")
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SixthViewController") as! SixthViewController
        self.navigationController?.pushViewController(next , animated: true)
        
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        popVC(animated: true)
    }
    
    
    
}

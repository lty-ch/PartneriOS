//
//  Extension+LeadProposalVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/08/23.
//

import Foundation
import UIKit

extension LeadProposalsVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.proposalsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeadProposalCollectionCell", for: indexPath) as! LeadProposalCollectionCell
        
        let info = self.proposalsArr[indexPath.row]
        
        cell.lblName.text = "\(info.policyDetails?.categoryDetails?.categoryName ?? "")" + " " + "(\(info.insuranceType ?? ""))"
        cell.lblYearlyPrice.text = "\(info.policyDetails?.totalAmount ?? 0)"
        cell.lblMonthly.text = info.policyDetails?.periodicity ?? ""
        cell.lblMonthlyPrice.text = "\(info.policyDetails?.premiumAmount ?? 0)"
        
        if self.status == "CLOSED" || self.status == "ACCEPTED" {
            cell.btnSend.isHidden = true
            if info.proposalState == "OFFER_CREATED"{
                cell.lblAccepted.text = "Pending"
                cell.lblAccepted.textColor = .systemYellow
                cell.imageAccepted.image = UIImage(named: "pending")
            } else if info.proposalState == "SIGNED_DOCS" {
                cell.lblAccepted.text = "Accepted"
                cell.imageAccepted.image = UIImage(named: "accept_1")
                cell.lblAccepted.textColor = Asset.Colors.greenColor.color
            } else if info.proposalState == "POLICY_CREATED" {
                cell.lblAccepted.text = "Policy Created"
                cell.imageAccepted.image = UIImage(named: "pending")
                cell.lblAccepted.textColor = .systemOrange
            } else {
                cell.lblAccepted.text = "REJECTED"
                cell.imageAccepted.image = UIImage(named: "reject_1")
                cell.lblAccepted.textColor = .systemRed
            }
        } else {
            cell.btnSend.isHidden = true
            if info.proposalState == "OFFER_CREATED"{
                cell.lblAccepted.text = "Pending"
                cell.imageAccepted.image = UIImage(named: "pending")
                cell.lblAccepted.textColor = .systemYellow
            } else if info.proposalState == "SIGNED_DOCS" {
                cell.lblAccepted.text = "Accepted"
                cell.imageAccepted.image = UIImage(named: "accept_1")
                cell.lblAccepted.textColor = Asset.Colors.greenColor.color
            } else if info.proposalState == "POLICY_CREATED" {
                cell.lblAccepted.text = "Policy Created"
                cell.imageAccepted.image = UIImage(named: "pending")
                cell.lblAccepted.textColor = .systemOrange
            }  else if info.proposalState == "PROPOSAL_SAVED" {
                cell.lblAccepted.text = "Saved"
                cell.imageAccepted.image = UIImage(named: "pending")
                cell.lblAccepted.textColor = .systemOrange
                cell.btnSend.isHidden = false
            } else {
                cell.lblAccepted.text = "REJECTED"
                cell.imageAccepted.image = UIImage(named: "reject_1")
                cell.lblAccepted.textColor = .systemRed
            }
        }

        cell.menuBtn.tag = indexPath.row
        cell.btnSend.tag = indexPath.row
        
        cell.btnSend.addTarget(self, action: #selector(sendActionBtn(_:)), for: .touchUpInside)
        cell.menuBtn.addTarget(self, action: #selector(menuActionBtn(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func menuActionBtn (_ sender:UIButton){
        
        let info = self.proposalsArr[sender.tag]
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        var menuArr = [String]()
//        if self.status == "CLOSED" || self.status == "SIGNED_DOCS" || self.status == "POLICY_CREATED" || self.status == "REJECTED" {
//            menuArr = ["View"]
//        }else{
//            menuArr =  ["View","Edit",]//["View","Edit","Delete"]
//        }
        
        if info.proposalState == "CLOSED" || info.proposalState == "SIGNED_DOCS" || info.proposalState == "POLICY_CREATED" || info.proposalState == "REJECTED" {
                    menuArr = ["View"]
                }else{
                    menuArr =  ["View","Edit",]//["View","Edit","Delete"]
                }
        for cat in menuArr {
            let action = UIAlertAction(title: cat, style: .default) { (action) in
                
                if cat == "View" || cat == "Edit" {
                    
                    guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                        let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                        vc.proposalId = self.proposalsArr[sender.tag].proposalId ?? ""
                        vc.leadId = self.leadId
//                        vc.fromWhichVC = sender.tag == 101 ? "LeadProposalVC" : "ForEditProposal"
//                        UserDefaults.standard.set(sender.tag == 102 ? "yes" : "no", forKey: "fromLead")
                        vc.fromWhichVC = cat == "View" ? "LeadProposalVC" : "ForEditProposal"
                        UserDefaults.standard.set(cat == "Edit" ? "yes" : "no", forKey: "fromLead")
                        self.pushToVC(vc, animated: true)
                        return
                    }

                    let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                    let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
                    let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

                    if (checkAccess.1 && userType == "AGENT" && cat == "Edit") || (userType == "PARTNER")  || (checkAccess.0 && userType == "AGENT" && cat == "View"){
                   
                        
                        let vc = ProposalDetailVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                        vc.proposalId = self.proposalsArr[sender.tag].proposalId ?? ""
                        vc.leadId = self.leadId
//                        vc.fromWhichVC = sender.tag == 101 ? "LeadProposalVC" : "ForEditProposal"
//                        UserDefaults.standard.set(sender.tag == 102 ? "yes" : "no", forKey: "fromLead")
                        vc.fromWhichVC = cat == "View" ? "LeadProposalVC" : "ForEditProposal"
                        UserDefaults.standard.set(cat == "Edit" ? "yes" : "no", forKey: "fromLead")
                        self.pushToVC(vc, animated: true)
                    }
                    else{
                        if sender.tag == 101 {
                            self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                        }else{
                            self.ShowAlert(message: LTY_AlterText.messageNoWriteAccess.localized())
                        }
                        
                        
                    }
         
                }else {
                    
                    guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                        self.showAlertWithActions(msg: "Are you sure you want to delete this Proposal ?".localized(), titles: ["Yes".localized(), "No".localized()]) { (value) in
                            if value == 1{
                          
                                let params:[String: Any] = ["proposalIds": [info.proposalId]]
                                self.leadProposalViewModel.deleteProposalApi(param: params)
                            }
                        }
                        return
                    }

                    let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                    let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
                    let userType = kUserDefaults.value(forKey: AppKeys.userType) as! String

                    if (checkAccess.2 && userType == "AGENT") || userType == "PARTNER"{
                        self.showAlertWithActions(msg: "Are you sure you want to delete this Proposal ?".localized(), titles: ["Yes".localized(), "No".localized()]) { (value) in
                            if value == 1{
                          
                                let params:[String: Any] = ["proposalIds": [info.proposalId]]
                                self.leadProposalViewModel.deleteProposalApi(param: params)
                            }
                        }
                    }
                    else{
                        self.ShowAlert(message: LTY_AlterText.messageNoDeleteAccess.localized())
                        
                    }
                    
                    
                 
                }
                

                
            }
            
            //              let icon = UIImage.init(named: cat.icon)
            
            //              action.setValue(icon, forKey: "image")
            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }

    @objc func sendActionBtn (_ sender:UIButton){
        let info = self.proposalsArr[sender.tag]
        let params:[String: Any] = ["proposalId": info.proposalId ?? "", "partnerId": info.partnerId ?? "", "proposalState": "OFFER_CREATED", "signedDoc": []]
        print(params)
        leadProposalViewModel.sendLeadProposalApi(param: params)
    }
}

extension LeadProposalsVC : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

          return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)

      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = ((UIScreen.main.bounds.width) / 2 - 5)
        let height: CGFloat = ((UIScreen.main.bounds.height) / 2 - 120)
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }

 
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }


}

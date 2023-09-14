//
//  Extension+DrowerViewController.swift
//  LTY_Partner
//
//  Created by CTS on 17/05/23.
//

import Foundation
import UIKit


extension DrowerViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      
        if userType as! String == "PARTNER"{
            return data.count
        }else {
            return agentData.count
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = drowerTableView.dequeueReusableCell(withIdentifier: "DrowerTableViewCell") as! DrowerTableViewCell
        cell.selectionStyle = .none
        if userType as! String == "PARTNER"{
            cell.lblName.text = data[indexPath.row]
            cell.imgImage.image = images[indexPath.row]
        }else {
            cell.lblName.text = agentData[indexPath.row]
            cell.imgImage.image = agentImages[indexPath.row]
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if userType as! String == "PARTNER"{
            if indexPath.row == 0 {
                let tabType = kUserDefaults.value(forKey: AppKeys.tabName)
                if tabType as! String == "ProfileTab"{
                    LTY_AppDelegate.switchToHomeVC()
                }else{
                    hideDrower()
                }
            }else if indexPath.row == 1 {
                let vc = CategoryVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                pushToVC(vc, animated: true)
            }
            else if indexPath.row == 2 {
                let vc = AgentVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                pushToVC(vc, animated: true)
            }
            else if indexPath.row == 3 {
                let vc = CustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
                pushToVC(vc, animated: true)
            }
            else if indexPath.row == 4 {
                let vc = ProposalVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                pushToVC(vc, animated: true)
            }
            else if indexPath.row == 5 {
                let vc = FinancialStatmentsVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                pushToVC(vc, animated: true)                
            }else if indexPath.row == 6 {
                let vc = NewsLetterVc.instantiate(fromAppStoryboard: .newsLetter)
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 7 {
                let vc = LeadListVC.instantiate(fromAppStoryboard: .leadStoryboard)
                pushToVC(vc, animated: true)
            }
            else if indexPath.row == 8 {
                let vc = SubmissionListVC.instantiate(fromAppStoryboard: .submissionStoryboard)
                pushToVC(vc, animated: true)
                
            } else if indexPath.row == 9 {
                let vc = RulesVC.instantiate(fromAppStoryboard: .ruleStoryboard)
                pushToVC(vc, animated: true)
                
            } else if indexPath.row == 10 {
                let vc = SearchCoverVC.instantiate(fromAppStoryboard: .searchCoverStoryboard)
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 11  {
                
                let vc = ChatuserListVC.instantiate(fromAppStoryboard: .chatStoryboard)
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 12 {
                let vc = AgendaListVC.instantiate(fromAppStoryboard: .agenda)
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 13  {
                
                let vc = SelectLanguageVC.instantiate(fromAppStoryboard: .main)
                //   vc.delegate = self
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.isComingFrom = "HOMEVC"
                self.present(vc, animated: true)
                
                
            }
            else if indexPath.row == 14  {
                
                let vc = PrivacyPolicyVC.instantiate(fromAppStoryboard: .newsLetter)
                
                pushToVC(vc, animated: true)
                
            }  else if indexPath.row == 15  {
                
                let vc = TermconditionVC.instantiate(fromAppStoryboard: .newsLetter)
                
                pushToVC(vc, animated: true)
                
            }
        }else {
            
            if indexPath.row == 0 {
                let tabType = kUserDefaults.value(forKey: AppKeys.tabName)
                if tabType as! String == "ProfileTab"{
                    LTY_AppDelegate.switchToHomeVC()
                }else{
                    hideDrower()
                }
            }else if indexPath.row == 1 {
              let vc = AgentCommissionVC.instantiate(fromAppStoryboard: .sideMenuStoryboard)
                vc.agentId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 2 {
                guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                    return
                }

                let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                let checkAccess = self.checkAccess(id: 1, useCaseArr: userRole?.useCasesList)
                if checkAccess.0 {
                    let vc = CustomerVC.instantiate(fromAppStoryboard: .customerStoryboard)
                    pushToVC(vc, animated: true)
                }
                else{
                    self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                    
                }
            }
            else if indexPath.row == 3 {
                guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                    return
                }

                let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                let checkAccess = self.checkAccess(id: 2, useCaseArr: userRole?.useCasesList)
                if checkAccess.0 {
                    let vc = ProposalVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                    pushToVC(vc, animated: true)
                }
                else{
                    self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                    
                }

                
            }
            else if indexPath.row == 4 {
                guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                    return
                }

                let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                let checkAccess = self.checkAccess(id: 2, useCaseArr: userRole?.useCasesList)
                if checkAccess.0 {
                    let vc = FinancialStatmentsVC.instantiate(fromAppStoryboard: .proposalStoryboard)
                    pushToVC(vc, animated: true)
                }
                else{
                    self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                    
                }

                
            }
            else if indexPath.row == 5 {
                let vc = NewsLetterVc.instantiate(fromAppStoryboard: .newsLetter)
                pushToVC(vc, animated: true)
            }
            else if indexPath.row == 6 {
                guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                    return
                }

                let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                let checkAccess = self.checkAccess(id: 9, useCaseArr: userRole?.useCasesList)
                if checkAccess.0 {
                    let vc = LeadListVC.instantiate(fromAppStoryboard: .leadStoryboard)
                    pushToVC(vc, animated: true)
                }
                else{
                    self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                    
                }
                
            }
            else if indexPath.row == 7 {
                guard  let UserData = UserDefaults.standard.value(forKey: AppKeys.roleList) as? Data  else {
                    return
                }

                let userRole = try? PropertyListDecoder().decode(RoleDetailData.self, from: UserData)

                let checkAccess = self.checkAccess(id: 10, useCaseArr: userRole?.useCasesList)
                if checkAccess.0 {
                    let vc = SubmissionListVC.instantiate(fromAppStoryboard: .submissionStoryboard)
                    pushToVC(vc, animated: true)
                }
                else{
                    self.ShowAlert(message: LTY_AlterText.messageNoReadAccess.localized())
                    
                }
                
            }
            else if indexPath.row == 8 {
               let vc = SearchCoverVC.instantiate(fromAppStoryboard: .searchCoverStoryboard)
               pushToVC(vc, animated: true)
               
           }
            else if indexPath.row == 9  {
                
                let vc = ChatuserListVC.instantiate(fromAppStoryboard: .chatStoryboard)
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 10 {
                let vc = AgendaListVC.instantiate(fromAppStoryboard: .agenda)
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 11  {
                
                let vc = SelectLanguageVC.instantiate(fromAppStoryboard: .main)
                //   vc.delegate = self
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.isComingFrom = "HOMEVC"
                self.present(vc, animated: true)
                
                
            }
            else if indexPath.row == 12  {
                
                let vc = PrivacyPolicyVC.instantiate(fromAppStoryboard: .newsLetter)
              
                pushToVC(vc, animated: true)
                
            }else if indexPath.row == 13  {
                
                let vc = TermconditionVC.instantiate(fromAppStoryboard: .newsLetter)
              
                pushToVC(vc, animated: true)
                
            }
        }
        
    }


}

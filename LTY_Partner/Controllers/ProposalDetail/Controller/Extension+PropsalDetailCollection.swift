//
//  Extension+PropsalDetailCollection.swift
//  LTY_Partner
//
//  Created by Chawtech on 06/06/23.
//

import UIKit

extension ProposalDetailVC : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == chooseMemberCollectionView {
            return membersArr.count
            
        }else {
            return keyTagsArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == chooseMemberCollectionView {
            let cell = chooseMemberCollectionView.dequeueReusableCell(withReuseIdentifier: "ChooseMemberCollectionViewCell", for: indexPath) as! ChooseMemberCollectionViewCell
            
            let info = self.membersArr[indexPath.row]
            cell.lblMemberList.text = info as? String

            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProposelDetailCollectionCell", for: indexPath) as! ProposelDetailCollectionCell
            
            let info = self.keyTagsArr[indexPath.row]
            cell.lblKeyName.text = info as! String 
            
            return cell
        }
    }
    

}

extension ProposalDetailVC : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

          if collectionView.numberOfItems(inSection: section) == 1 {

               let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
              return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        }

          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

      }

}

extension ProposalDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.policyDocsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = policyTableView.dequeueReusableCell(withIdentifier: "ProposalDetailPolicyTableCell", for: indexPath) as! ProposalDetailPolicyTableCell
                cell.cellLbl.text = (self.policyDocsArr[indexPath.row] as! String)
//        let data = (self.policyDocsArr[indexPath.row] as! String)
//        if let lastSlashIndex = data.lastIndex(of: "/") {
//            let fileName = String(data[data.index(after: lastSlashIndex)...])
//            cell.cellLbl.text = fileName
//            //            print("File Name: \(fileName)")
//        } else {
//            print("Invalid URL format")
//        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        let filename: NSString = policyDocsArr[indexPath.row] as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            let info = policyDocsArr[indexPath.row] as! String
            vc.attachmentStr = info
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)

//            if let url = URL(string:policyDocsArr[indexPath.row] as! String) {
//                UIApplication.shared.open(url)
//            }
        }else{
            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.image = policyDocsArr[indexPath.row] as! String
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)

        }
        
 
    }
    
}

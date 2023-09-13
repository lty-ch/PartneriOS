//
//  Extension+CustMemberCollection.swift
//  LTY_Partner
//
//  Created by shashivendra sengar on 15/06/23.
//

import Foundation
import UIKit

extension CustomerMemberVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = custDocCollection.dequeueReusableCell(withReuseIdentifier: "CustDocCollectionViewCell", for: indexPath) as! CustDocCollectionViewCell
        cell.lblName.text = showListArr[indexPath.row]["name"]

        if showListArr[indexPath.row]["isSelected"]  == "yes" {
            cell.mainView.backgroundColor = Asset.Colors.blueColor.color
            cell.lblName.textColor = Asset.Colors.whiteColor.color
        }else{
        cell.mainView.backgroundColor = Asset.Colors.grayColor.color
        cell.lblName.textColor = Asset.Colors.gray2.color
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = ((custDocCollection.frame.size.width) / 3 - 5)
        return CGSize(width: width, height: 50)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
 
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }

    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for (index, element) in showListArr.enumerated() {
           // print("Element index: \(index)Element value \(element)")
            showListArr[index]["isSelected"] = "no"
            
        }
        showListArr[indexPath.item]["isSelected"] = "yes"
        custDocCollection.reloadData()
        
        if indexPath.item == 0 {
            btnAddExtractingContract.isHidden = true
            profileView.isHidden = false
            tableView.isHidden = true
            noDataFoundView.isHidden = true
        }
        if indexPath.item == 1 {
            btnAddExtractingContract.isHidden = true
            let param:[String:Any] = ["userId": userId]
            customerMemberVM.getCustomerMemberApi(param: param)
            
        }else if indexPath.item == 2 {
            btnAddExtractingContract.isHidden = false
            let param: [String : Any] = ["entityType": "MEMBER_ID", "entityId": userId ,"proposalState": "POLICY_CREATED","pageSize": 50,"pageCount": 1,"offerType" : ""]
          
            customerMemberVM.getCustomerContractApi(param:param)
 
        }else if indexPath.item == 3 {
            btnAddExtractingContract.isHidden = true
            let param: [String : Any] = ["userId": userId]
            customerMemberVM.getCustomerUserDocumentApi(param:param)
            
        }else if indexPath.item == 4 {
            btnAddExtractingContract.isHidden = true
            let param: [String : Any] = ["entityType": "USER_ID", "entityId": userId ,"status": "","pageSize": 50,"pageCount": 1]
            customerMemberVM.getCustomerLeadsApi(param: param)
        }
//        else if indexPath.item == 5 {
//
//
//            let vc = AddExistingContractsVC.instantiate(fromAppStoryboard: .customerStoryboard)
//            vc.userId = userId
//            vc.memberId = familyMemberId
//            pushToVC(vc, animated: true)
//        }

    }

 
    

}

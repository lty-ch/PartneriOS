//
//  Extension+GetStartScreenVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 04/05/23.
//

import Foundation
import SwiftGifOrigin

import UIKit

extension GetStartScreenVC :UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(GetStartedCVC.self,indexPath)
        //   var images = ["family-insurance","man-working-on-ab-testing","support-center"]
        
        
        if indexPath.row == 0 {
            
            //            let gifImage = UIImage.gif(name: "family-insurance")
         
            cell.imgImage.image = UIImage(named: "ab-testing")
            cell.imgImage.contentMode = .scaleAspectFit
           // cell.topView.backgroundColor = Asset.Colors.skyBlue.color
            
        }
        else if indexPath.row == 1 {
          
            cell.imgImage.image = UIImage(named:"customer-help-centre")
            cell.imgImage.contentMode = .scaleAspectFit
            
           // cell.topView.backgroundColor = Asset.Colors.lightOrange.color
        }
        else if indexPath.row == 2 {
      
            cell.imgImage.image = UIImage(named: "family-safety")
            //UIImage(name: "family-safety")
            cell.imgImage.contentMode = .scaleAspectFit
            
            //cell.topView.backgroundColor = Asset.Colors.lightGreen.color
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let wid = (collectionView.frame.width - 10)
        return CGSize(width: wid, height: 329)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        pageControl.currentPage = indexPath.item
        
        let indexValue = indexPath.item //Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl?.currentPage = indexValue
        if indexValue == 0 {
            labelTitle.text = LTYText.text_getStartVCTitle1.localized()
            labelSubTitle.text = LTYText.text_getStartVCSubTitle1.localized()
        }
        else if indexValue == 1 {
            labelTitle.text = LTYText.text_getStartVCTitle2.localized()
            labelSubTitle.text = LTYText.text_getStartVCSubTitle2.localized()
        }
        else if indexValue == 2{
            labelTitle.text = LTYText.text_getStartVCTitle3.localized()
            labelSubTitle.text = LTYText.text_getStartVCSubTitle3.localized()
        }
    }
    
    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        
//        let indexValue = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        pageControl?.currentPage = indexValue
//        //pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        
//        if indexValue == 0 {
//            labelTitle.text = LTYText.text_getStartVCTitle1.localized()
//            labelSubTitle.text = LTYText.text_getStartVCSubTitle1.localized()
//        }
//        else if indexValue == 1 {
//            labelTitle.text = LTYText.text_getStartVCTitle2.localized()
//            labelSubTitle.text = LTYText.text_getStartVCSubTitle2.localized()
//        }
//        else if indexValue == 2{
//            labelTitle.text = LTYText.text_getStartVCTitle3.localized()
//            labelSubTitle.text = LTYText.text_getStartVCSubTitle3.localized()
//        }
//    }
    
}

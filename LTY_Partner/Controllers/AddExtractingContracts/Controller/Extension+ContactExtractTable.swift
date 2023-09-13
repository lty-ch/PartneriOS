//
//  Extension+ContactExtractTable.swift
//  LTY_Partner
//
//  Created by Chawtech on 05/08/23.
//

import Foundation
import UIKit

extension AddExistingContractsVC : UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uploadDocArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docTableView.dequeueReusableCell(withIdentifier: "ExtractingContractTVC", for: indexPath) as! ExtractingContractTVC
        let info = uploadDocArr[indexPath.row]
        let data1 = uploadDocArr[indexPath.row]
        if let lastSlashIndex = data1.lastIndex(of: "/") {
            let fileName = String(data1[data1.index(after: lastSlashIndex)...])
            cell.textLabel?.text = fileName
          
        }
        //cell.textLabel?.text = info
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filename: NSString = uploadDocArr[indexPath.row] as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            if let url = URL(string:uploadDocArr[indexPath.row] as! String) {
                UIApplication.shared.open(url)
            }
        }else{
            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.image = uploadDocArr[indexPath.row] as! String
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

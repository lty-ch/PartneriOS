//
//  ChooseCountryVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 02/08/23.
//

import UIKit

protocol SetCountyCode {
    func setCountryCode(countyCode:Int)
}
class ChooseCountryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   // var view: UIView!
    
    @IBOutlet weak var searchBackView: UIStackView!
    @IBOutlet weak var customMainView: UIView!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchFieldBackView: UIView!
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    
    @IBOutlet weak var customNavigation: CustomNavigationBarForDrawer!

    @IBOutlet weak var tableView: UITableView!
    
    
    var filteredData = [DrpDownListStruct]()
    var listArray = [DrpDownListStruct]()
    var countryCodeDelegate : SetCountyCode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        customNavigation.titleLabel.text = "Select Country".localized()
        customNavigation.titleLabel.textAlignment = .center
        customNavigation.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavigation.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)

        searchFieldBackView.layer.cornerRadius = 5
        searchFieldBackView.layer.borderWidth  = 1
        searchFieldBackView.layer.borderColor  = UIColor.systemBlue.cgColor
        
        
        searchTxtField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
 
    
    @IBAction func searchBarTextChanged(_ sender: UITextField) {
        if sender.text != ""
        {
           // filteredData = listArray.filter { $0.name.contains(sender.text!) }
            filteredData = listArray.filter { $0.name.lowercased().contains(sender.text!.lowercased()) }

        }
        else
        {
            self.filteredData = self.listArray
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
 //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
        
    }
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCountryTVC") as! SelectCountryTVC
        cell.selectionStyle = .none
        
        let info = self.filteredData[indexPath.row]
        cell.textLabel?.text = info.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = self.filteredData[indexPath.row]
        self.dismiss(animated: true) {
            self.countryCodeDelegate?.setCountryCode(countyCode: info.phoneCode)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
 
}



extension ChooseCountryVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        filteredData = listArray.filter { $0.name.lowercased().contains(textField.text!.lowercased()) }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if searchTxtField.text != ""
        {
            filteredData = listArray.filter { $0.name.lowercased().contains(searchTxtField.text!.lowercased()) }
            
        }
        else
        {
            self.filteredData = self.listArray
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return true
    }
}

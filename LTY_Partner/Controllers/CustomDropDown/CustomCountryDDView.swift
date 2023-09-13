//
//  CustomCountryDDView.swift
//  LTY_Partner
//
//  Created by CTS-Jay Gupta on 16/05/23.
//

import UIKit


struct DrpDownListStruct {
    let id: Int
    let phoneCode: Int
    let name: String
}

protocol SetDrpDownText{
    func setDrpDownText(id:String, name:String, phoneCode:Int)
}

class CustomCountryDDView: UIView {
    
    var delegate : SetDrpDownText?
    
    var view: UIView!
    
    @IBOutlet weak var searchBackView: UIStackView!
    @IBOutlet weak var customMainView: UIView!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchFieldBackView: UIView!
    
    var listArray = [DrpDownListStruct]()
    var filteredData = [DrpDownListStruct]()
    
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
        xibSetup()
        tbleView.register(UINib(nibName: "CountryDropDownCell", bundle: Bundle.main), forCellReuseIdentifier: "CountryDropDownCell")
        searchFieldBackView.layer.cornerRadius = 5
        searchFieldBackView.layer.borderWidth  = 1
        searchFieldBackView.layer.borderColor  = UIColor.systemBlue.cgColor
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        // IQKeyboardManager.shared.enable = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        addSubview(view)
    }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomCountryDDView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height - 140
                //self.view.frame.origin.y -= keyboardSize.height - 300
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    @IBAction func onTapCancelBtn(_ sender: Any) {
        self.removeFromSuperview()
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
            self.tbleView.reloadData()
        }
    }
}

extension CustomCountryDDView: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDropDownCell") as! CountryDropDownCell
        cell.selectionStyle = .none
        
        let info = self.filteredData[indexPath.row]
        cell.textLabel?.text = info.name
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.removeFromSuperview()
        if self.filteredData.count != 0
        {
            if indexPath.row < self.filteredData.count {
                let info = self.filteredData[indexPath.row]
                self.delegate?.setDrpDownText(id: String(info.id), name: info.name, phoneCode: info.phoneCode ?? 0)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50 //UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension CustomCountryDDView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        filteredData = listArray.filter { $0.name.contains(textField.text!) }
        filteredData = listArray.filter { $0.name.lowercased().contains(textField.text!.lowercased()) }

        DispatchQueue.main.async {
            self.tbleView.reloadData()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard range.location == 0 else {
            return true
        }
        let newString = (textField.text!.lowercased() as NSString).replacingCharacters(in: range, with: string.lowercased()) as NSString
        return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
    }
}




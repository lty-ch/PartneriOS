//
//  FinancialStatmentsVC.swift
//  LTY_Partner
//
//  Created by CTS on 13/07/23.
//

import UIKit

class FinancialStatmentsVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var searchCloseBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    var proposalVM = ProposalViewModel()
    var proposalListArr = [ProposalsList]()
    var datePicker = UIDatePicker()
    var startDate = ""
    var endDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Financial Statements".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
        startDateTxt.delegate = self
        endDateTxt.delegate = self
        proposalVM.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        
       // let currentDate = Date()
        var components = DateComponents()
        var comps = DateComponents()
       // components.calendar = calendar
  
 
            components.month = -1
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: components, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = Date()
       // print(datePicker.minimumDate)
        //print(datePicker.maximumDate)
        

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        startDate = "\(formatter.string(from: datePicker.minimumDate!))"
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd.MM.yyyy"
        startDateTxt.text = formatter1.string(from: datePicker.minimumDate!)
        

        let formatter12 = DateFormatter()
        formatter12.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        endDate = "\(formatter.string(from: datePicker.date))"
        
        let formatter123 = DateFormatter()
        formatter123.dateFormat = "dd.MM.yyyy"
        endDateTxt.text = formatter123.string(from: datePicker.date)
        
        print(endDate,startDate)
        self.ApiCallingFunc(state: "POLICY_CREATED")

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false

    }
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
  //MARK:- Api call func
    
    func ApiCallingFunc(state:String) {
        
        guard internetConnection.isConnectedToNetwork() == true  else {
            self.ShowAlert(message: LTY_AlterText.internetConnectionAlert)
            return
        }
    
        var entityType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
        if entityType as! String == "AGENT"{
            entityType = "AGENT_ID"
        } else if entityType as! String == "PARTNER"{
            entityType = "PARTNER_ID"
        }
        let partnerId = kUserDefaults.string(forKey: "partnerID") ?? ""
        let param:[String: Any] = ["entityType": entityType,"entityId": partnerId, "proposalState": state,"startDate": self.startDate, "endDate": self.endDate, "pageSize": 50, "pageCount": 1,"offerType":""]
        print(param)
        proposalVM.proposalListApi(param: param)
    }
    
    
    @IBAction func onClickSearch(_ sender: UIButton) {
                
        UIView.animate(withDuration: 0.1) {
            //self.searchBtn.setImage(UIImage.init(named: "accept"), for: .normal)
            self.searchView.isHidden = false
            self.stackView.isHidden = true
            self.searchCloseBtn.isHidden = false
            self.searchBtn.isHidden = true
//            self.viewHeaderBar.isHidden = false

//            self.consSearchViewWidth.constant = 0

            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func onClickSearchClose(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) {
           // self.searchBtn.setImage(UIImage.init(named: "search"), for: .normal)
            self.searchView.isHidden = true
            self.stackView.isHidden = false
            self.searchCloseBtn.isHidden = true
            self.searchBtn.isHidden = false


            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func onClickStartDate(_ sender: UIButton) {
//        self.showDatePicker()
    }
    
    @IBAction func onClickEndDate(_ sender: UIButton) {
//        self.showDatePicker()
    }
    
    
    //MARK:- Show DatePicker

    func showDatePicker(name:String){
        
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        
       // let currentDate = Date()
        var components = DateComponents()
        var comps = DateComponents()
       // components.calendar = calendar
  
 
//            components.year = 110
//            let minDate = calendar.date(byAdding: components, to: Date())
//            let maxDate = calendar.date(byAdding: components, to: Date())
//            datePicker.minimumDate = minDate
//            datePicker.maximumDate = Date()
        
        if name == "end"{
            components.year = -110
            comps.year = 0
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: comps, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
        }else{
            components.year = 110
            let minDate = calendar.date(byAdding: components, to: Date())
            let maxDate = calendar.date(byAdding: components, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = Date()
        }
    
//        components.year = -150
//        let minDate = calendar.date(byAdding: components, to: Date())
//        datePicker.minimumDate = minDate
//        datePicker.maximumDate = Date()
        
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //  use this case for set date in multiple textfiled using same picker
        
    
        startDateTxt.inputView = datePicker
        startDateTxt.inputAccessoryView = toolbar
        
        endDateTxt.inputView = datePicker
        endDateTxt.inputAccessoryView = toolbar
  
    }
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if startDateTxt.isEditing == true {
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            startDateTxt.text = formatter1.string(from: datePicker.date)
            
            if !endDateTxt.text!.isEmpty {
                startDate = "\(formatter.string(from: datePicker.date))"
                
                
                self.ApiCallingFunc(state: "POLICY_CREATED")
            }
            

        }
        else {
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            endDateTxt.text = formatter1.string(from: datePicker.date)
            
            if !startDateTxt.text!.isEmpty {
                endDate =  "\(formatter.string(from: datePicker.date))"//"\(datePicker.date)"
                
                self.ApiCallingFunc(state: "POLICY_CREATED")
            }
            

        }
        self.view.endEditing(true)
        
    }
    
    //MARK: Function to handle cancel in datepicker
    
    @objc func cancelDatePicker(){
        
        self.view.endEditing(true)
    }
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        startDateTxt.text = formatter.string(from: sender.date)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == startDateTxt {
            showDatePicker(name:"start")
                return true
            }
            if textField == endDateTxt {

                showDatePicker(name:"end")
                return true
            }
            return true
        
        
    }

}

extension FinancialStatmentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.proposalListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.proposalListArr[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FinStatementCell", for: indexPath) as! FinStatementCell
        cell.policyIdLbl.text = info.policyDetails?.policyId ?? ""
        cell.agentNameLbl.text = info.agentDetails?.agentName ?? "Unassigned".localized()
        
        let fName = info.memberDetails?.firstName?.capitalized ?? ""
        let lName = info.memberDetails?.lastName?.capitalized ?? ""
        cell.nameLbl.text = fName + " " + lName
        
        var startDateStr = info.policyDetails?.startDate ?? ""
        startDateStr = startDateStr.components(separatedBy: "T")[0]
        cell.startDateLbl.text = returnDOB(date: startDateStr)
        
        var endDateStr = info.policyDetails?.endDate ?? ""
        endDateStr = endDateStr.components(separatedBy: "T")[0]
        cell.endDateLbl.text = returnDOB(date: endDateStr)
        
        cell.grossIncomeLbl.text = "\(info.commissionDetails?.partnerGrossCommission ?? 0)"
        cell.partnerReserveLbl.text = "\(info.commissionDetails?.partnerReserve ?? 0)"
        cell.agentCommissionLbl.text = "\(info.commissionDetails?.agentGrossCommission ?? 0)"
        cell.reserveLbl.text = "\(info.commissionDetails?.agentReserve ?? 0)"
        
        return cell
    }
    
    
}

extension FinancialStatmentsVC: ProposalListProtocolDelegate {
    
    func setProposalList(data: ProposalModel) {
        if data.status == "SUCCESS"{
        //    self.proposalListArr = data.data?.proposalsList ?? []
            let proposalArr = data.data?.proposalsList ?? []
            
            self.proposalListArr = proposalArr.filter { obj in
                obj.offerType != "EXISTING"
            }
            
            if self.proposalListArr.count > 0 {
                self.emptyView.isHidden = true
                self.tableView.isHidden = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.emptyView.isHidden = false
                self.tableView.isHidden = true
            }
        }else{
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
    
    func popupMsg(msg: String) {
        ShowAlert(message: msg)
    }
    
    
}

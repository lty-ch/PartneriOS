//
//  AddNewAgendaVC.swift
//  LTY_Partner
//
//  Created by Chawtech on 24/07/23.
//

import UIKit

protocol ReloadAgendaListDelegate {
    func reloadAgendaList(setValue:String)
}

class AddNewAgendaVC: UIViewController, SetAgendaMembers ,UITextFieldDelegate {
    
    func setSelectedMemberList(arr: NSMutableArray, nameArr: NSMutableArray, memberList: [UsersList]) {
        
      //  textSelectMember.text = nameArr.componentsJoined(by: ",")
        lblSelectMember.text = nameArr.componentsJoined(by: ",")
        memberIdArr = arr
        memberNameArr = nameArr
        self.customerListArr = memberList
    }
    
    
    @IBOutlet weak var lblTitleMember: UILabel!
    @IBOutlet weak var lbltitleMeetingDate: UILabel!
    @IBOutlet weak var lblTitleMeetingTime: UILabel!
    @IBOutlet weak var lblTitleTask: UILabel!
    @IBOutlet weak var lblTitleDesciption: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnSelectMember: UIButton!
    @IBOutlet weak var lblSelectMember: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var textStartTime: UITextField!
    @IBOutlet weak var textSelectMember: UITextField!
    @IBOutlet weak var textTask: UITextField!
    @IBOutlet weak var textEndTime: UITextField!
    @IBOutlet weak var textMeetingDate: UITextField!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    
    
    var memberIdArr = NSMutableArray()
    var memberNameArr = NSMutableArray()
    var meetingDate = ""
    
    var customerVM = CustomerViewModel()
    var customerListArr = [UsersList]()
    var datePicker = UIDatePicker()
    var reloadAgendaListDelegate :ReloadAgendaListDelegate?
    var addAgendaViewModel = AddAgendaViewModel()
    
    var updateAgenda = false
    var updateAgendaId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDrowerHeight()
        textEndTime.delegate = self
        textStartTime.delegate = self
        textMeetingDate.delegate = self
        
        if updateAgenda == true {
            customNavDrower.titleLabel.text = "Update Agenda".localized()
        }else {
            customNavDrower.titleLabel.text = "Add New Agenda".localized()
        }
        
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        addAgendaViewModel.delegate = self
        
        let partnerId =  kUserDefaults.string(forKey: "partnerID") ?? ""
        
        self.customerVM.delegate = self
        
        let usertype = kUserDefaults.value(forKey: AppKeys.userType)
        
        if usertype as! String == "PARTNER"{
            let param:[String:Any] = ["partnerId": partnerId, "searchBy": "" ,"agentId": ""]
            let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getCustomers
            customerVM.customerListApi(param: param,url: url)
        }else{
            let url = LTY_BASE_URL.BASE_URL_IDENTITY + LTY_END_POINT_URL.getAgentList
            let param:[String:Any] = ["agentId": partnerId, "searchBy": ""]
            customerVM.customerListApi(param: param,url: url)
        }
        
        setUpLocalization()
      
    }
    
    
    func setUpLocalization() {
        self.lblTitleMember.text = "Member".localized()
        self.lbltitleMeetingDate.text = "Meeting Date".localized()
        self.lblTitleMeetingTime.text = "Meeting Time".localized()
        self.lblTitleTask.text = "Task".localized()
        self.lblSelectMember.text = "Select Member".localized()
        self.lblTitleDesciption.text = "Description (optional)".localized()
        
        self.btnSubmit.setTitle("Submit".localized(), for: .normal)
        self.btnCancel.setTitle("Cancel".localized(), for: .normal)
  
    }
    
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
            
        }
    }
    
    
    //MARK:- Show DatePicker
    
    func showDatePicker(name:String){
        
        //Formate Date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        if name == "time"{
            
            datePicker.locale = .current
            datePicker.datePickerMode = .time
            // let calendar = Calendar(identifier: .gregorian)
            
            
        }else{
            
            datePicker.locale = .current
            datePicker.datePickerMode = .date
            let calendar = Calendar(identifier: .gregorian)
            
            // let currentDate = Date()
            var components = DateComponents()
            var maxDatecomponents = DateComponents()
            components.year = 0
            maxDatecomponents.year = 110
            let minDate = calendar.date(byAdding: components, to: Date())
             let maxDate = calendar.date(byAdding: maxDatecomponents, to: Date())
            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));
        
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        //  use this case for set date in multiple textfiled using same picker
        
        
        textMeetingDate.inputView = datePicker
        textEndTime.inputView = datePicker
        textStartTime.inputView = datePicker
        textMeetingDate.inputAccessoryView = toolbar
        textEndTime.inputAccessoryView = toolbar
        textStartTime.inputAccessoryView = toolbar
        
        
    }
    
    //MARK: Function to handle done in datepicker
    
    @objc func donedatePicker(){
        
        
        if textMeetingDate.isEditing == true {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"//"yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            meetingDate = "\(formatter.string(from: datePicker.date))"
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd.MM.yyyy"
            textMeetingDate.text = formatter1.string(from: datePicker.date)
            
        }else if textStartTime.isEditing == true {
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"//"HH:mm:ss a"
            
            textStartTime.text = "\(formatter.string(from: datePicker.date))"
            
        }else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            textEndTime.text = "\(formatter.string(from: datePicker.date))"
            
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
        textMeetingDate.text = formatter.string(from: sender.date)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == textMeetingDate {
            showDatePicker(name:"Date")
            return true
        }
        if textField == textStartTime  || textField == textEndTime  {
            
            showDatePicker(name:"time")
            return true
        }
        
        return true
        
        
    }
    
    func checkValidation() {
        
        if meetingDate == ""{
            self.ShowAlert(message:"Please select meeting date .")
        }
//        guard let memberName = textSelectMember.text, !memberName.isEmpty else {
//            self.ShowAlert(message:"Please select Member .")
//            return
//        }
        if lblSelectMember.text == "Select Member" {
        self.ShowAlert(message:"Please select Member .")

        }
//        guard  let meetingDate = textMeetingDate.text, !meetingDate.isEmpty else {
//            self.ShowAlert(message:"Please select meeting date .")
//            return
//        }
        guard let startTime = textStartTime.text, !startTime.isEmpty else {
            self.ShowAlert(message:"Please select start time .")
            return
        }
        guard let endTime = textEndTime.text, !endTime.isEmpty else {
            self.ShowAlert(message:"Please select end time .")
            return
        }
        guard let task = textTask.text, !task.isEmpty else {
            self.ShowAlert(message:"Please enter your task .")
            return
        }
        
        if updateAgenda == true {
        
            let param :[String:Any] = [ "id": updateAgendaId,
                                        "userIds": memberIdArr,
                                        "date":meetingDate,
                                        "timeFrom": textStartTime.text!,
                                        "timeTo": textEndTime.text!,
                                        "task": textTask.text!,
                                        "description": textDescription.text ?? "",]
            addAgendaViewModel.updateAgendaDetailsApi(param: param)
        }
        else {
            var userType = kUserDefaults.value(forKey: AppKeys.userType) ?? ""
            var partnerId = ""
            var agentId = ""
            if userType as! String == "AGENT"{
                agentId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
                partnerId = kUserDefaults.value(forKey: AppKeys.sourceId) as! String
            } else if userType as! String == "PARTNER"{
                partnerId = kUserDefaults.value(forKey: AppKeys.partnerID) as! String
            }
            
            
            
            let param :[String:Any] = [ "partnerId": partnerId,
                                        "agentId": agentId,
                                        "userIds": memberIdArr,
                                        "date":meetingDate,
                                        "timeFrom": textStartTime.text!,
                                        "timeTo": textEndTime.text!,
                                        "task": textTask.text!,
                                        "description": textDescription.text ?? "",]
            addAgendaViewModel.addNewAgendaApi(param: param)
        }
    }
  
    
    @IBAction func selectMemberList(_ sender: UIButton) {
        
        let vc = MemberAgendaSelectVC.instantiate(fromAppStoryboard: .agenda)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        vc.memberIdArr = self.memberIdArr
        vc.memberNameArr = self.memberNameArr
        vc.memberList = self.customerListArr
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func submitActionBtn(_ sender: UIButton) {
        checkValidation()
    }
    
    @IBAction func cancelActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
    }
    
}

extension AddNewAgendaVC: CustomerListProtocolDelegate {
    func popupMsg(msg: String) {
        self.ShowAlert(message: msg)
    }
    
    
    func setCustomerAgentList(data: CustomerActiveAgentModel) {
        print("")
    }
    
    func setCustomerList(data: CustomerModel) {
        
        if data.status == "SUCCESS" {
            self.customerListArr = data.data?.usersList ?? []
            if updateAgenda == true{
                let param :[String:Any]  = ["id":self.updateAgendaId]
                addAgendaViewModel.getAgendaDetails(param: param)
            }
        }
        else{
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
}

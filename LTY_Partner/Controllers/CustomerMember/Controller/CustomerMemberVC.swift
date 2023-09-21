//
//  CustomerMemberVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

class CustomerMemberVC: UIViewController, CustomerUserDocProtocolDelegate {
  
    
    @IBOutlet weak var btnAddExtractingContract: UIButton!
    @IBOutlet weak var custContractTableView: UITableView!
    @IBOutlet weak var customerDocTable: UITableView!
    @IBOutlet weak var customerMemberTable: UITableView!
    @IBOutlet weak var lblInsurerType: UILabel!
    @IBOutlet weak var custDocCollection: UICollectionView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    
    var userId = ""
    var familyMemberId = ""
    var userName = ""
    var registerFrontId = ""
    var registerBackId = ""
    
    var memberArr = [FamilyMemberList]()
    var docListArr = [CustDocMemberList]()
    var contractListArr = [SubmissionProposalsList]()
    
    var leadListArr = [LeadList]()
    
    var customerMemberVM = CustomerMemberViewModel()
    var showListArr = [["name":"Profile".localized(),"isSelected":"yes"],["name":"General".localized(),"isSelected":"no"],["name":"Contracts".localized(),"isSelected":"no"],["name":"Documents".localized(),"isSelected":"no"],["name":"Leads".localized(),"isSelected":"no"]]
    
    
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
  
    @IBOutlet weak var lblTitleFrontID: UILabel!
    @IBOutlet weak var lblTitleBackID: UILabel!
    @IBOutlet weak var lblTitleInsurance: UILabel!
    @IBOutlet weak var lblTitlePersnalInfo: UILabel!
    @IBOutlet weak var lblTitleUserType: UILabel!
    @IBOutlet weak var lblTitleFullName: UILabel!
    @IBOutlet weak var lblTitleAgentName: UILabel!
    @IBOutlet weak var lblTitleEmail: UILabel!
    @IBOutlet weak var lblTitleGender: UILabel!
    @IBOutlet weak var lblTitlePhone: UILabel!
    @IBOutlet weak var lblTitleCountry: UILabel!
    @IBOutlet weak var lblTitleDob: UILabel!
    @IBOutlet weak var lblTitleState: UILabel!
    @IBOutlet weak var lblTitleCity: UILabel!
    @IBOutlet weak var lblTitleAddress: UILabel!
    @IBOutlet weak var lblTitlePostCoce: UILabel!
    //MARK:- outlets for profileview
    
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var agentNameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var postalCodeLbl: UILabel!
    
    @IBOutlet weak var lblRegistrationIdBack: UILabel!
    @IBOutlet weak var lblRegistrationIdFront: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var mainNameLbl: UILabel!
    
    var customerListObj: UsersList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.isHidden = false
        // Do any additional setup after loading the view.
        customerMemberVM.delegate = self
        btnAddExtractingContract.isHidden = true

        setDrowerHeight()
        setUpCollectionView()
        setUpLocalization()
        
        customNavDrower.titleLabel.text = "Customer info".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        setUpCustomerListView()
        
    }
    
    func setUpLocalization() {
        
    self.lblTitleFrontID.text = "Registration Id (Front)".localized()
    self.lblTitleBackID.text = "Registration Id (Back)".localized()
    self.lblTitleInsurance.text = "Insurer Type".localized()
    self.lblTitlePersnalInfo.text = "Personal Info".localized()
    self.lblTitleUserType.text = "User Type".localized()
    self.lblTitleFullName.text = "Full Name".localized()
    self.lblTitleAgentName.text = "Agent Name".localized()
    self.lblTitleEmail.text = "Email".localized()
    self.lblTitleGender.text = "Gender".localized()
    self.lblTitlePhone.text = "Phone".localized()
    self.lblTitleCountry.text = "Country".localized()
    self.lblTitleDob.text = "Date of Birth".localized()
    self.lblTitleState.text = "State".localized()
    self.lblTitleCity.text = "City".localized()
    self.lblTitleAddress.text = "Address".localized()
    self.lblTitlePostCoce.text = "Post Code".localized()
    }
    
    func setUpCustomerListView() {
        imgImage.makeRounded()
        if ((customerListObj?.profilePic) != nil) {
            self.imgImage.sd_setImage(with: URL(string: customerListObj?.profilePic ?? ""), placeholderImage:UIImage(named: "user"))
        }
        
        let fName = customerListObj?.firstName?.capitalized   ?? ""
        let lName = customerListObj?.lastName?.capitalized   ?? ""
        self.mainNameLbl.text = fName + " " + lName
        // self.ageLbl.text = customerListObj?.dob ?? ""
        self.typeLbl.text = customerListObj?.type ?? ""
        self.nameLbl.text = fName + " " + lName
        self.agentNameLbl.text = customerListObj?.agentName ?? "Unassigned".localized()
        
        self.dobLbl.text = returnDOB(date: customerListObj?.dob ?? "")//customerListObj?.dob ?? ""
        self.mailLbl.text = customerListObj?.email ?? ""
        let countryCode = customerListObj?.countryCode ?? ""
        self.phoneLbl.text = "\(countryCode) \(customerListObj?.mobile ?? "")"
       // self.phoneLbl.text = customerListObj?.mobile ?? ""
        self.genderLbl.text = customerListObj?.gender ?? ""
        self.countryLbl.text = customerListObj?.country ?? ""
        self.stateLbl.text = customerListObj?.state ?? ""
        self.cityLbl.text = customerListObj?.city ?? ""
        self.addressLbl.text = customerListObj?.address ?? ""
        self.postalCodeLbl.text = customerListObj?.postCode ?? ""
        
        var insurerDoc = self.customerListObj?.insurerCompanies
        if insurerDoc  != nil {
            var arr = NSMutableArray()
            for item in insurerDoc! {
                
                arr.add(item)
                
            }
            lblInsurerType.text = arr.componentsJoined(by: ",")
        }
        if let registrationIdArr = self.customerListObj?.registrationIds, registrationIdArr.count > 0 {
            self.registerFrontId = registrationIdArr[0]
            self.registerBackId = registrationIdArr[1]
            
            let data = self.registerFrontId
            if let lastSlashIndex = data.lastIndex(of: "/") {
                let fileName = String(data[data.index(after: lastSlashIndex)...])
                self.lblRegistrationIdFront.text = fileName
                //            print("File Name: \(fileName)")
            } else {
                print("Invalid URL format")
            }
            
            let data1 = self.registerBackId
            if let lastSlashIndex = data1.lastIndex(of: "/") {
                let fileName = String(data1[data1.index(after: lastSlashIndex)...])
                self.lblRegistrationIdBack.text = fileName
                //            print("File Name: \(fileName)")
            } else {
                print("Invalid URL format")
            }
            
        }
    }
    
    @IBAction func onClickFrontIdActionBtn(_ sender: UIButton) {
        
        let filename: NSString = registerFrontId as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            if let url = URL(string:registerFrontId) {
                UIApplication.shared.open(url)
            }
        }else{
            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.image = registerFrontId
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func onClickBackIdActionBtn(_ sender: UIButton) {
        
        let filename: NSString = registerBackId as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            if let url = URL(string:registerBackId) {
                UIApplication.shared.open(url)
            }
       
        }else{
            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.image = registerBackId
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    //MARK:- SetUp CollectionView
    
    func setUpCollectionView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        custDocCollection.delegate = self
        custDocCollection.dataSource = self
        customerMemberTable.delegate = self
        customerDocTable.dataSource = self
        customerDocTable.delegate = self
        customerMemberTable.dataSource = self
        custContractTableView.delegate = self
        custContractTableView.dataSource = self
        
        custDocCollection.register(UINib(nibName: "CustDocCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CustDocCollectionViewCell")
    }
    
    
    //MARK:- set navigationDrower Height
    
    func setDrowerHeight() {
        if UIDevice.current.hasNotch {
            customNavHeight.constant = DroverHeight.haveNotch
        } else {
            customNavHeight.constant = DroverHeight.dontHaveNotch
        }
    }
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    @IBAction func AddExtractingContact(_ sender: UIButton) {
     
        let vc = AddExistingContractsVC.instantiate(fromAppStoryboard: .customerStoryboard)
        vc.userId = userId
        vc.memberId = familyMemberId
        vc.updadetContractDelegate = self
        pushToVC(vc, animated: true)
    }
    
    //MARK:- delegate func
    //Set cust documemt  Data
    
    func setCustUserDocData(data: CustDocModel) {
        
        docListArr.removeAll()
        if data.status == "SUCCESS" {
            self.docListArr = data.data?.memberList ?? []
            
            if docListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.tableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = true
                    self.profileView.isHidden = true
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                    self.noDataFoundView.isHidden = true
                    self.customerDocTable.isHidden = false
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = true
                    self.profileView.isHidden = true
                    self.customerDocTable.reloadData()
                }
            }
            
        }
        else {
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
    
    //Set cust contract Data
    
    func setCustContract(data: SubmissionModel) {
        contractListArr.removeAll()
        if data.status == "SUCCESS" {
            self.contractListArr = data.data?.proposalsList ?? []
            
            if contractListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.tableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = true
                    self.profileView.isHidden = true
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.noDataFoundView.isHidden = true
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = false
                    self.custContractTableView.reloadData()
                    self.profileView.isHidden = true
                }
            }
            
        }
        else {
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
    
    //Set cust Lead Data
    
    func setCustomerLeadata(data: LeadModel) {
        leadListArr.removeAll()
        if data.status == "SUCCESS" {
            self.leadListArr = data.data?.leadsList ?? []
            
            if leadListArr.count == 0 {
                DispatchQueue.main.async {
                    
                    self.tableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = true
                    self.profileView.isHidden = true
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.profileView.isHidden = true
                    self.tableView.isHidden = true
                    self.noDataFoundView.isHidden = true
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = false
                    self.custContractTableView.isHidden = true
                    self.customerMemberTable.reloadData()
                }
            }
            
        }
        else {
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
    
    //Set Cust Member Data
    
    func setCustomerMemberdata(data: CustomerMemberModel) {
        memberArr.removeAll()
        
        if data.status == "SUCCESS" {
            self.memberArr = data.data?.familyMemberList ?? []
            
            if memberArr.count == 0 {
                DispatchQueue.main.async {
                    self.profileView.isHidden = true
                    self.tableView.isHidden = true
                    self.noDataFoundView.isHidden = false
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = true
                    
                    
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.tableView.isHidden = false
                    self.noDataFoundView.isHidden = true
                    self.customerDocTable.isHidden = true
                    self.customerMemberTable.isHidden = true
                    self.custContractTableView.isHidden = true
                    self.profileView.isHidden = true
                    
                    self.tableView.reloadData()
                }
            }
            
        }
        else {
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

extension CustomerMemberVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == customerMemberTable {
            return self.leadListArr.count
        }else if tableView == custContractTableView{
            return contractListArr.count
        }else if tableView == customerDocTable{
            return docListArr.count
        }else {
            return self.memberArr.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // CustMemberTableCell
        if tableView == customerMemberTable {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustMemberTableCell", for: indexPath) as! CustMemberTableCell
            
            let info = leadListArr[indexPath.row]
            cell.leadID.text = info.leadId
            if info.agentName == nil{
                cell.AgentType.text = "Unassigned".localized()
               // cell.cellNameLbl.text = "Unassigned".localized()
            }else{
               // cell.cellNameLbl.text = info.agentName
                cell.AgentType.text = info.agentName
            }
            
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            cell.partner.text = fName + " " + lName
            cell.cellNameLbl.text = fName + " " + lName
            cell.cellMailLbl.text = info.memberDetails?.email ?? ""
            cell.cellPhoneLbl.text = "\(info.memberDetails?.countryCode ?? "") \(info.memberDetails?.mobile ?? "")"
            cell.requestType.text = info.metadata?.type ?? ""
            var createdOnStr = info.createdOn ?? ""
            createdOnStr = createdOnStr.components(separatedBy: "T")[0]
            cell.date.text = returnDOB(date: createdOnStr)
            
            cell.lblAccepted.text = info.status
            cell.lblAccepted.textColor =  Asset.Colors.redColor.color
            cell.acceptedView.backgroundColor = Asset.Colors.grayColor.color
            cell.cellRelationLbl.text = info.relation ?? ""
            
            cell.cellMenuBtn.tag = indexPath.row
            cell.cellMenuBtn.addTarget(self, action: #selector(menuActionBtn(_:)), for: .touchUpInside)
            return cell
            
        }else if tableView == custContractTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "custMemberContractCell", for: indexPath) as! custMemberContractCell
            cell.selectionStyle = .none
            let info = contractListArr[indexPath.row]
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            cell.cellAgentNameLbl.text = fName + " " + lName
            cell.lblType.text = info.insuranceType ?? ""
            cell.lblAgentName.text = info.agentDetails?.agentName ?? "Unassigned".localized()
            cell.lblPolicyNo.text = info.policyDetails?.policyId ?? ""
            cell.lblSubCat.text = info.policyDetails?.categoryDetails?.subCategoryName ?? ""
            
            var dob = "\(info.memberDetails?.dob ?? "")"
            dob = dob.components(separatedBy: "T")[0]
            cell.lblDate.text = returnDOB(date: dob)
            var StartDob = "\(info.policyDetails?.startDate ?? "" ?? "")"
            StartDob = StartDob.components(separatedBy: "T")[0]
            var endDob = "\(info.policyDetails?.endDate ?? "")"
            endDob = endDob.components(separatedBy: "T")[0]
            cell.lblStartDate.text = returnDOB(date: StartDob)
            cell.lblEndDate.text = returnDOB(date: endDob)
            
            cell.cellViewBtn.tag = indexPath.row
            cell.cellViewBtn.addTarget(self, action: #selector(viewContactAction(_:)), for: .touchUpInside)
            
            return cell
            
        }else if tableView == customerDocTable{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerDocumentTVC", for: indexPath) as! CustomerDocumentTVC
            cell.selectionStyle = .none
            let info = docListArr[indexPath.row]
            
            cell.lblName.text = info.memberName
            cell.lblType.text = info.relation ?? ""
            cell.lblAgent.text = info.agentName ?? "Unassigned".localized()
            cell.lblTotalFiles.text = String(info.docCount ?? 0)
            var StartDob = "\(info.lastUploadedOn ?? "")"
            StartDob = StartDob.components(separatedBy: "T")[0]
            cell.lblLastFile.text = returnDOB(date: StartDob)
            cell.lblAddedBy.text = info.uploadedBy ?? ""
            
            // cell.btnMenu.tag = indexPath.row
            // cell.btnMenu.addTarget(self, action: #selector(viewAction(sender:)), for: .touchUpInside)
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerMemberCell", for: indexPath) as! CustomerMemberCell
            let info = memberArr[indexPath.row]
            
            let fName = info.firstName?.capitalized  ?? ""
            let lName = info.lastName?.capitalized  ?? ""
            cell.cellMainLbl.text = fName + " " + lName
            cell.cellPhoneLbl.text =  "\(info.countryCode ?? "") \(info.mobile ?? "")"
            cell.cellDobLbl.text = returnDOB(date: info.dob ?? "")
            cell.cellEmailLbl.text = info.email ?? ""
            cell.cellTypeLbl.text = info.memberType ?? ""
            
            cell.cellViewBtn.tag = indexPath.row
            cell.cellViewBtn.addTarget(self, action: #selector(viewAction(_:)), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    
    @objc func viewContactAction(_ sender: UIButton ){
        
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            var menuArr = ["View","Modify Commission"]
     
        for cat in menuArr {
            let action = UIAlertAction(title: cat, style: .default) { (action) in
              
                
                if cat == "View" {
                    let vc = ContractDetailVC.instantiate(fromAppStoryboard: .customerStoryboard)
                    
                    let info = self.contractListArr[sender.tag]
                    
                    let fName = info.memberDetails?.firstName?.capitalized   ?? ""
                    let lName = info.memberDetails?.lastName?.capitalized   ?? ""
                    let signedDocs = info.signedDoc ?? []
                    let policyDocs = info.policyDetails?.policyDocs ?? []
                    let contractDoc = info.contractDoc ?? []
                    vc.contractDictArr.append(ContractDetailModel.init(totalAmount:info.policyDetails?.totalAmount ?? 0, category:info.policyDetails?.categoryDetails?.categoryName ?? "", subCategory:info.policyDetails?.categoryDetails?.subCategoryName ?? "", name: fName + " " + lName, endDate: info.policyDetails?.endDate ?? "", startDate:  info.policyDetails?.startDate ?? "", sumAssured: "", totalDuration: "", personCovered: "", benifits:info.policyDetails?.productBenefits ?? "", premiumTerm: info.policyDetails?.premiumAmount ?? 0, periodicity:  info.policyDetails?.periodicity ?? "", email:  info.memberDetails?.email ?? "", agentName:  info.agentDetails?.agentName ?? "", policyNumber:  info.policyDetails?.policyId ?? "", policyName:info.policyDetails?.policyType ?? "", signedDoc: signedDocs, policyDoc: policyDocs,contractDoc: contractDoc))
                    self.pushToVC(vc, animated: true)
                } else {
                    let info = self.contractListArr[sender.tag]
                    if info.offerType == "EXISTING" {
                        self.ShowAlert(message: "You cannot modify commission of Existing Contract. ")
                    }else {
                        let vc = ModifyCommissionVC.instantiate(fromAppStoryboard: .customerStoryboard)
                        let info = self.contractListArr[sender.tag]
                        vc.contractDic = info
                        vc.modifyProtocolDelegate = self
                        self.pushToVC(vc, animated: true)
                    }
                }
 
            }

            action.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            actionSheetAlertController.addAction(action)
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
        
    }
    @objc func viewAction(_ sender: UIButton){
        let buttonTag = sender.tag
        DispatchQueue.main.async {
            let vc = CustomerProfileVC.instantiate(fromAppStoryboard: .customerStoryboard)
            vc.memberObj = self.memberArr[buttonTag]
            vc.iFrom = "customerMember"
            self.pushToVC(vc, animated: true)
        }
        
    }
    
    @objc func menuActionBtn(_ sender: UIButton ){
        let vc = ViewLeadVC.instantiate(fromAppStoryboard: .leadStoryboard)
        let index = sender.tag
        
        let info = leadListArr[index]
        vc.index = sender.tag
        vc.insuranceType = info.metadata?.type ?? ""
        vc.checkInsuranceDelegate = self
        vc.checkProposalDelegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        if tableView == custContractTableView {
            
            let vc = ContractDetailVC.instantiate(fromAppStoryboard: .customerStoryboard)
            
            let info = contractListArr[indexPath.row]
            
            let fName = info.memberDetails?.firstName ?? ""
            let lName = info.memberDetails?.lastName ?? ""
            let signedDocs = info.signedDoc ?? []
            let policyDocs = info.policyDetails?.policyDocs ?? []
            vc.contractDictArr.append(ContractDetailModel.init(name: fName + " " + lName, endDate: info.policyDetails?.endDate ?? "", startDate:  info.policyDetails?.startDate ?? "", sumAssured: "", totalDuration: "", personCovered: "", benifits:info.policyDetails?.productBenefits ?? "", premiumTerm: info.policyDetails?.premiumAmount ?? 0, periodicity:  info.policyDetails?.periodicity ?? "", email:  info.memberDetails?.email ?? "", agentName:  info.agentDetails?.agentName ?? "", policyNumber:  info.policyDetails?.policyId ?? "", policyName:info.policyDetails?.policyType ?? "", signedDoc: signedDocs, policyDoc: policyDocs))
            pushToVC(vc, animated: true)
        }else
        */
        if tableView == customerDocTable{
            let vc = DocDetailVC.instantiate(fromAppStoryboard: .customerStoryboard)
            vc.userId = self.userId
            vc.updateDocCountProtocol = self
            vc.memberId = self.docListArr[indexPath.row].memberId ?? ""
            pushToVC(vc, animated: true)
            
        }
        
    }
    
}


extension CustomerMemberVC : checkInsuranceTypeDelegate, checkProposalDelegate, ModifyProtolDelegate{
    
    func modifyProtocol(setValue: String) {
        let param: [String : Any] = ["entityType": "MEMBER_ID", "entityId": userId ,"proposalState": "POLICY_CREATED","pageSize": 50,"pageCount": 1,"offerType" : ""]
      
        customerMemberVM.getCustomerContractApi(param:param)
        
    }
    
    
    func checkInsuranceType(index: Int, insuranceType: String) {
        
        if insuranceType == "HEALTH".localized(){

            let vc = HealthFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "TERM_LIFE".localized(){
            let vc = TermLifeVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "GENERAL".localized(){
            let vc = GeneralRequestVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "TRAVEL".localized(){
//            let vc = TravelInsuranceVC.instantiate(fromAppStoryboard: .leadStoryboard)
//            let info = leadListArr[index]
//            vc.leadId = info.leadId ?? ""
//            pushToVC(vc, animated: true)
            let vc = TravelFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "BUILDING".localized(){
            let vc = BuildingFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "BUSINESS_LEGAL_PROTECTION".localized(){
            let vc = LegalProtectionBusinessFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        }else if insuranceType == "THIRD_PILLAR".localized(){
            let vc = ThirdPillarFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
            
        } else if insuranceType == "BUSINESS_COMPANY_THINGS".localized(){
            let vc = CompaniesThingsVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "ANIMAL".localized(){
            let vc = AnimalFormVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "RC_HOUSEHOLD".localized(){
            let vc = HouseHoldRcVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "HOUSING_RENTAL".localized(){
            let vc = HousingRentalVC.instantiate(fromAppStoryboard: .Forms)
            let info = leadListArr[index]
            vc.leadId = info.leadId ?? ""
            pushToVC(vc, animated: true)
        }else if insuranceType == "Proposal".localized(){
            let vc = LeadProposalsVC.instantiate(fromAppStoryboard: .leadStoryboard)
            let info = leadListArr[index]
            vc.insurnceType = info.metadata?.type ?? ""
            vc.leadId = info.leadId ?? ""
            vc.agentName = info.agentName ?? ""
            vc.agentId = info.agentId ?? ""
            vc.status = info.status?.localized() ?? ""
            
            var memberNames = NSMutableArray()
            let fName = info.memberDetails?.firstName?.capitalized   ?? ""
            let lName = info.memberDetails?.lastName?.capitalized   ?? ""
            
            memberNames.add(fName + " " + lName)
            UserDefaults.standard.set(fName + " " + lName, forKey: "memebrNameArr")
            
            var memberIds = NSMutableArray()
            
            memberIds.add(info.memberDetails?.memberId ?? "")
//            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(memberIds), forKey: "memberIds")

            UserDefaults.standard.set(memberIds, forKey: "memberIds")
            
            
            pushToVC(vc, animated: true)
            
        }else {
            print(index,insuranceType)
            
        }
        
    }
    
    
}

//MARK: Reload contract list

extension CustomerMemberVC : UpdadetContractListDelegate {
    func updateContract(value: String) {
        let param: [String : Any] = ["entityType": "MEMBER_ID", "entityId": userId ,"proposalState": "POLICY_CREATED","pageSize": 50,"pageCount": 1,"offerType" : ""]
      
        customerMemberVM.getCustomerContractApi(param:param)
    }
    
}

extension CustomerMemberVC : UpdateDoctableDelegate {
   
    func updateDocCount(value: String) {
        let param: [String : Any] = ["userId": userId]
        customerMemberVM.getCustomerUserDocumentApi(param:param)
    }
    
}



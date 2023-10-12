//
//  CustomerProfileVC.swift
//  LTY_Partner
//
//  Created by ChawTech Solutions on 25/05/23.
//

import UIKit

class CustomerProfileVC: UIViewController {
    
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var agentView: UIView!
    
    @IBOutlet weak var lblTitleFrontID: UILabel!
    @IBOutlet weak var lblTitleBackID: UILabel!
    @IBOutlet weak var lblTitleAgentName: UILabel!
    @IBOutlet weak var lblTitleEmail: UILabel!
    @IBOutlet weak var lblTitleGender: UILabel!
    @IBOutlet weak var lblTitlePhone: UILabel!
    @IBOutlet weak var lblTitleCountry: UILabel!
    @IBOutlet weak var lblTitleDob: UILabel!
    
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
    @IBOutlet weak var customNavDrower: CustomNavigationBarForDrawer!
    @IBOutlet weak var customNavHeight: NSLayoutConstraint!
    @IBOutlet weak var registerIdStackView: UIStackView!
    
    @IBOutlet weak var countryViewStack: UIStackView!
    @IBOutlet weak var lblRegistrationIdBack: UILabel!
    @IBOutlet weak var lblRegistrationIdFront: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var mainNameLbl: UILabel!
    
    var customerListObj: UsersList?
    var memberObj: FamilyMemberList?
    var iFrom = "customerMember"
    var registerFrontId = ""
    var registerBackId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    lblTitleFrontID.text = "Registration Id (Front)".localized()
    lblTitleBackID.text = "Registration Id (Back)".localized()
        
        // Do any additional setup after loading the view.
        if iFrom == "customerMember" {
            self.setUpCustomerMemberView()
            countryView.isHidden = true
            postView.isHidden = true
            cityView.isHidden = true
            countryViewStack.isHidden = true
            registerIdStackView.isHidden = false
            lblTitleAgentName.text = "DOB".localized()
            lblTitleDob.text = "Email".localized()
            lblTitleEmail.text = "Phone".localized()
            lblTitlePhone.text = "Gender".localized()
           // lblTitleGender.text = "Address".localized()
           
        } else {
            self.setUpCustomerListView()
            registerIdStackView.isHidden = true
            countryView.isHidden = false
            postView.isHidden = false
            cityView.isHidden = false
            countryViewStack.isHidden = false
            lblTitleAgentName.text = "Agent Name".localized()
            lblTitleDob.text = "Date of Birth".localized()
            lblTitleEmail.text = "Email".localized()
            lblTitlePhone.text = "Phone".localized()
            lblTitleGender.text = "Gender".localized()
        }
        imgImage.makeRounded()
        
        setDrowerHeight()
        customNavDrower.titleLabel.text = "Profile".localized()
        customNavDrower.titleLabel.textAlignment = .center
        customNavDrower.leftSideMenuButtonItem.setImage(Asset.Assets.backArrow.image, for: .normal)
        customNavDrower.leftSideMenuButtonItem.addTarget(self, action: #selector(backActionBtn(_:)), for: .touchUpInside)
        
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
    
    //MARK:- backAction Btn
    
    @objc func backActionBtn(_ sender: UIButton) {
        self.popVC(animated: true)
        
    }
    
    func setUpCustomerListView() {
        if customerListObj?.gender == "Male"{
            if ((customerListObj?.profilePic) != nil) {
                self.imgImage.sd_setImage(with: URL(string: customerListObj?.profilePic ?? ""), placeholderImage:UIImage(named: "user_male"))
            }
        }else{
            if ((customerListObj?.profilePic) != nil) {
                self.imgImage.sd_setImage(with: URL(string: customerListObj?.profilePic ?? ""), placeholderImage:UIImage(named: "user_female"))
            }
        }
        let fName = customerListObj?.firstName?.capitalized   ?? ""
        let lName = customerListObj?.lastName?.capitalized   ?? ""
        self.mainNameLbl.text = fName + lName
       // self.ageLbl.text = customerListObj?.dob ?? ""
        self.typeLbl.text = customerListObj?.type ?? ""
        self.nameLbl.text = customerListObj?.firstName?.capitalized   ?? ""
        self.agentNameLbl.text = customerListObj?.agentName ?? "Unassigned".localized()
        self.dobLbl.text = returnDOB(date: customerListObj?.dob ?? "")//customerListObj?.dob ?? ""
        self.mailLbl.text = customerListObj?.email ?? ""
        let countryCode = customerListObj?.countryCode ?? ""
        
        self.phoneLbl.text = "\(countryCode) \(customerListObj?.mobile  ?? "")"
      //  self.phoneLbl.text = customerListObj?.mobile ?? ""
        self.genderLbl.text = customerListObj?.gender ?? ""
        self.countryLbl.text = customerListObj?.country ?? ""
        self.stateLbl.text = customerListObj?.state ?? ""
        self.cityLbl.text = customerListObj?.city ?? ""
        self.addressLbl.text = customerListObj?.address ?? ""
        self.postalCodeLbl.text = customerListObj?.postCode ?? ""
    }
    
    func setUpCustomerMemberView() {
        if memberObj?.gender == "Male"{
            if ((memberObj?.profilePic) != nil) {
                self.imgImage.sd_setImage(with: URL(string: memberObj?.profilePic ?? ""), placeholderImage:UIImage(named: "user_male"))
            }
        }else{
            if ((memberObj?.profilePic) != nil) {
                self.imgImage.sd_setImage(with: URL(string: memberObj?.profilePic ?? ""), placeholderImage:UIImage(named: "user_female"))
            }
        }
        let fName = memberObj?.firstName?.capitalized   ?? ""
        let lName = memberObj?.lastName?.capitalized   ?? ""
        self.mainNameLbl.text = fName + lName
       // self.ageLbl.text = memberObj?.dob ?? ""
        self.typeLbl.text = memberObj?.memberType ?? ""
        self.nameLbl.text = memberObj?.firstName?.capitalized   ?? ""
        self.agentNameLbl.text = returnDOB(date: memberObj?.dob ?? "")//memberObj?.dob ?? ""
        self.dobLbl.text = memberObj?.email ?? ""
        let countryCode = memberObj?.countryCode ?? ""
        
        self.mailLbl.text = "\(countryCode) \(memberObj?.mobile  ?? "")"
       // self.mailLbl.text = memberObj?.mobile ?? ""
        self.phoneLbl.text = memberObj?.gender ?? ""
        self.genderLbl.text = memberObj?.address ?? ""
        
       // if self.memberObj?.registrationIds?.count != 0 {
            if let registrationIdArr = self.memberObj?.registrationIds, registrationIdArr.count > 0 {

//            let registrationIdArr = self.memberObj?.registrationIds
            self.registerFrontId = registrationIdArr[0] ?? ""
            self.registerBackId = registrationIdArr[1] ?? ""
            
                self.lblRegistrationIdFront.text = self.registerFrontId
//            let data = self.registerFrontId
//            if let lastSlashIndex = data.lastIndex(of: "/") {
//                let fileName = String(data[data.index(after: lastSlashIndex)...])
//                self.lblRegistrationIdFront.text = fileName
//                //            print("File Name: \(fileName)")
//            } else {
//                print("Invalid URL format")
//            }
            
                self.lblRegistrationIdBack.text = self.registerBackId
                
//            let data1 = self.registerBackId
//            if let lastSlashIndex = data1.lastIndex(of: "/") {
//                let fileName = String(data1[data1.index(after: lastSlashIndex)...])
//                self.lblRegistrationIdBack.text = fileName
//                //            print("File Name: \(fileName)")
//            } else {
//                print("Invalid URL format")
//            }
        }
      
    }
    
    @IBAction func onClickFrontIdActionBtn(_ sender: UIButton) {
        
        let filename: NSString = registerFrontId as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            
            
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = registerFrontId
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
            
//            if let url = URL(string:registerFrontId) {
//                UIApplication.shared.open(url)
//            }
        }else{
            
          
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = registerFrontId//self.textPrivateCriminalRecord.text!
            //vc.attachmentStr = self.textPrivateCriminalRecord.text!
            self.presentVC(vc, animated: true, presentationStyle: .fullScreen)
            /*
            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
            vc.image = registerFrontId
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
             */
        }
    }
    
    @IBAction func onClickBackIdActionBtn(_ sender: UIButton) {
        
        let filename: NSString = registerBackId as! NSString
        let pathExtention = filename.pathExtension
        
        if pathExtention == "pdf" || pathExtention == "docx" || pathExtention == "doc"{
            
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = registerBackId
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
//            if let url = URL(string:registerBackId) {
//                UIApplication.shared.open(url)
//            }
        }else{
            let vc = ViewAttachmentsVC.instantiate(fromAppStoryboard: .home)
            vc.attachmentStr = registerBackId//self.textPrivateCriminalRecord.text!
            //vc.attachmentStr = self.textPrivateCriminalRecord.text!
            self.presentVC(vc, animated: true, presentationStyle: .pageSheet)
//            let vc = ViewImageVC.instantiate(fromAppStoryboard: .proposalStoryboard)
//            vc.image = registerBackId
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true)
        }
    }
    
}
